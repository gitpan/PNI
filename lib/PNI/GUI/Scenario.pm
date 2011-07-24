package PNI::GUI::Scenario;
use strict;
use base 'PNI::Item';
use PNI::File;
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add( edges => {} );
    $self->add( nodes => {} );

    # $file is not required but should be a PNI::File
    # and defaults to an brand new PNI::File.
    $self->add('file');
    my $file = $arg->{file};
    if ( defined $file and not $file->isa('PNI::File') ) {
        return PNI::Error::invalid_argument_type;
    }
    else {
        $file = PNI::File->new;
    }
    $self->set_file($file);

    # $scenario is required
    my $scenario = $arg->{scenario}
      or return PNI::Error::missing_required_argument;

    # $scenario must be a PNI::Scenario
    $scenario->isa('PNI::Scenario') or return PNI::Error::invalid_argument_type;

    $self->add( scenario => $scenario );

    return $self;
}

# return $scenario: PNI::GUI::Scenario
sub add_scenario { return PNI::Error::unimplemented_abstract_method; }

# return $edge: PNI::GUI::Edge
sub add_edge { return PNI::Error::unimplemented_abstract_method; }

# return $node: PNI::GUI::Node
sub add_node { return PNI::Error::unimplemented_abstract_method; }

# my $previous_content = $self->clear_all;
# return \%content
sub clear_all {
    my $self             = shift;
    my $previous_content = {};

    $previous_content = {
        edges => $self->get('edges'),
        nodes => $self->get('nodes'),
    };

    # clear stuff
    $self->set( edges => {} );
    $self->set( nodes => {} );

    return $previous_content;
}

sub del_edge { return PNI::Error::unimplemented_abstract_method; }

sub del_node { return PNI::Error::unimplemented_abstract_method; }

sub get_file { shift->get('file') }

sub get_scenario { shift->get('scenario') }

# return 1
sub load_file {
    my $self = shift;

    my $file    = $self->get_file;
    my $content = $file->get_content;

    my %new_id_of;
    my %get_node_by_id;
    my $previous_content = $self->clear_all;

    my $stored_edges = $content->{edges};
    my $stored_nodes = $content->{nodes};

    # create nodes
    for my $stored_node_id ( keys %{$stored_nodes} ) {

        my $stored_node = $stored_nodes->{$stored_node_id};

        my $center_y = $stored_node->{center_y};
        my $center_x = $stored_node->{center_x};
        my $inputs   = $stored_node->{inputs};
        my $type     = $stored_node->{type};

        # N.B. : add_node method is abstract, should be defined in child classes
        my $node = $self->add_node(
            center_y => $center_y,
            center_x => $center_x,
            inputs   => $inputs,
            type     => $type,
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

        # N.B. : add_edge method is abstract, should be defined in child classes
        my $edge = $self->add_edge(
            source => $source,
            target => $target
        );
    }

    return 1;
}

sub save_file {
    my $self = shift;
    my $file = $self->get_file;

    my $edges = $self->get('edges');
    my $nodes = $self->get('nodes');

    return $file->set_content( { edges => $edges, nodes => $nodes, } );
}

sub set_file {
    my $self = shift;
    my $file = shift;

    $self->set( file => $file );
}

1;
__END__

=head1 NAME

PNI::GUI::Scenario - is a scenario abstract view

=head1 METHODS

=head2 C<add_edge>

=head2 C<add_node>

=head2 C<add_scenario>

=head2 C<clear_all>

=head2 C<del_edge>

=head2 C<del_node>

=head2 C<get_file>

=head2 C<get_scenario>

=head2 C<load_file>

=head2 C<save_file>

=head2 C<set_file>

=cut

