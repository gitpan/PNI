package PNI::Scenario;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';
use PNI::Edge 0.15;
use PNI::Error 0.15;
use PNI::File 0.15;
use PNI::Node 0.15;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add( edges => {} );

    # $file is not required but should be a PNI::File
    my $file = $arg->{file};
    if ( defined $file ) {
        $file->isa('PNI::File') or return PNI::Error::invalid_argument_type;
    }
    $self->add( file => $file );

    $self->add( nodes => {} );

    $self->add( scenarios => {} );

    return $self;
}

# return $edge
sub add_edge {
    my $self = shift;
    my $edge = PNI::Edge->new(@_) or return PNI::Error::unable_to_create_item;

    return $self->get('edges')->{ $edge->id } = $edge;
}

# return $node
sub add_node {
    my $self = shift;
    my $arg  = {@_};

    # if arg type is not provided return a dummy node
    my $type = $arg->{type} or return PNI::Node->new;

    my $node_class = "PNI::Node::$type";
    my $node_path  = "$node_class.pm";
    $node_path =~ s/::/\//g;
    eval { require $node_path; } or return PNI::Error::unable_to_load_node;
    my $node = $node_class->new(@_) or return PNI::Error::unable_to_create_item;

    # at this point the node is created, so you can initialize it
    $node->init or return PNI::Error::unable_to_init_node;

    my $inputs = $arg->{inputs};
    if ( defined $inputs ) {
        while ( my ( $slot_name, $slot_data ) = each %{$inputs} ) {
            $node->get_input($slot_name)->set_data($slot_data);
        }
    }

    return $self->get('nodes')->{ $node->id } = $node;
}

# return 1
sub add_scenario {
    my $self     = shift;
    my $scenario = PNI::Scenario->new(@_)
      or return PNI::Error::unable_to_create_item;

    return $self->get('scenarios')->{ $scenario->id } = $scenario;
}

# my $previous_content = $self->clear_all;
# return \%content
sub clear_all {
    my $self    = shift;
    my $content = {};

    my $edges = $self->get_edges;
    my $nodes = $self->get_nodes;

    $content = { edges => $edges, nodes => $nodes, };

    # clear stuff
    $self->set( edges => {} );
    $self->set( file  => undef );
    $self->set( nodes => {} );

    return $content;
}

sub get_edges { return shift->get('edges') }

sub get_file { return shift->get('file') }

# return %nodes
sub get_nodes { return values %{ shift->get('nodes') }; }

# return 1
sub load_file {

    #TODO put this code inside PNI::File
    my $self = shift;

    my $file = $self->get_file;

    my %new_id_of;
    my %get_node_by_id;
    my $previous_content = $self->clear_all;

    my $stored_edges = $file->get_edges;
    my $stored_nodes = $file->get_nodes;

    # create nodes
    for my $stored_node_id ( keys %{$stored_nodes} ) {

        my $stored_node = $stored_nodes->{$stored_node_id};

        my $type   = $stored_node->{type};
        my $inputs = $stored_node->{inputs};
        my $node   = $self->add_node(
            type   => $type,
            inputs => $inputs,
        );

        my $node_id = $node->id;
        $new_id_of{$stored_node_id} = $node_id;

        # remember node <--> node_id relation
        $get_node_by_id{$node_id} = $node;
    }

    # create edges
    for my $stored_edge_id ( keys %{$stored_edges} ) {

        my $stored_edge = $stored_edges->{$stored_edge_id};

        # stored_egde => { source_id => x, target_id => y,
        #                  source_name => 'foo', target_name => 'bar' }
        my $stored_source_id = $stored_edge->{source_id};
        my $stored_target_id = $stored_edge->{target_id};
        my $source_name      = $stored_edge->{source_name};
        my $target_name      = $stored_edge->{target_name};

        my $source_id   = $new_id_of{$stored_source_id};
        my $source_node = $get_node_by_id{$source_id};
        my $source      = $source_node->get_input($source_name);

        my $target_id   = $new_id_of{$stored_target_id};
        my $target_node = $get_node_by_id{$target_id};
        my $target      = $target_node->get_input($target_name);

        my $edge = $self->add_edge( source => $source, target => $target );
    }

    return 1;
}

sub set_file {
    my $self = shift;
    my $file = shift or return PNI::Error::missing_required_argument;
    return $self->set( file => $file );
}

# return 1
sub task {

    # Here we go, this is one of the most important PNI subs
    my $self = shift;

    # Start with nodes without a parent
    my %parents_of;
    for my $node ( $self->get_nodes ) {
        $parents_of{$node} = [];
        for my $edge ( $node->get_input_edges ) {
            push @{ $parents_of{$node} }, $edge->get_source_node;
        }
    }

    my %has_run_task_of;

  RUN_TASKS:
    for my $node ( $self->get_nodes ) {

        # discard nodes that run task yet
        next if $has_run_task_of{$node};

        # wait until all parent nodes run
        my $node_can_run_task = 1;
        for my $parent_node ( @{ $parents_of{$node} } ) {
            if   ( $has_run_task_of{$parent_node} ) { }
            else                                    { $node_can_run_task = 0; }
        }

        if ($node_can_run_task) {

            # retrieve slot data coming from input edges
            for my $edge ( $node->get_input_edges ) {
                $edge->get_target->set_data( $edge->get_source->get_data );
            }

            # ok, now it's time to run node task
            ######### TODO consider to deprecate this ## $node->check_inputs and
            eval { $node->task } or do {

                # if node task fails raise error (without return)
                PNI::Error::unable_to_run_task;
            };

            $has_run_task_of{$node} = 1;
        }
    }

    # check if all tasks run
    for my $node ( $self->get_nodes ) {
        if   ( $has_run_task_of{$node} ) { }
        else                             { goto RUN_TASKS; }
    }

    return 1;
}

1;
__END__

=head1 NAME

PNI::Scenario - is a persistent PNI graph


=head1 METHODS

=head2 C<add_edge>

=head2 C<add_node>

=head2 C<add_scenario>

=head2 C<clear_all>

=head2 C<get_file>

=head2 C<get_nodes>

=head2 C<get_edges>

=head2 C<load_file>

=head2 C<set_file>

=head2 C<task>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
