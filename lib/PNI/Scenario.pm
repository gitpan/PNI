package PNI::Scenario;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';
use PNI::Edge 0.14;
use PNI::Error 0.14;
use PNI::Node 0.14;

sub new {
    my $class = shift;
    my $arg   = {@_};

    my $self = $class->SUPER::new(@_);

    $self->add( nodes => {} );
    $self->add( edges => {} );
    $self->add( name  => 'Untitled' );

    return $self;
}

sub add_edge {
    my $self = shift;
    my $edge = PNI::Edge->new(@_) or return PNI::Error::unable_to_create_item;

    $self->get('edges')->{ $edge->id } = $edge;

    return $edge;
}

sub add_node {
    my $self = shift;
    my $arg  = {@_};

    my $type = $arg->{type} or return PNI::Node->new;

    my $node_class = "PNI::Node::$type";
    my $node_path  = "$node_class.pm";
    $node_path =~ s/::/\//g;
    eval { require $node_path; } or return PNI::Error::unable_to_load_node;
    my $node = $node_class->new(@_) or return PNI::Error::unable_to_create_item;

    # at this point the node is created, so you can initialize it
    $node->init or return PNI::Error::unable_to_init_node;

    $self->get('nodes')->{ $node->id } = $node;
    return $node;
}

sub get_nodes { return values %{ shift->get('nodes') }; }

sub get_edges { return values %{ shift->get('edges') }; }

# Here we go, this is one of the PNI most important subs
sub task {
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

=head1 NAME

PNI::Scenario - is a set nodes and links




=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
