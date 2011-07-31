package PNI::GUI::Scenario;
use strict;
use base 'PNI::Item';
use PNI::File;
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new;

    $self->add( edges => {} );
    $self->add( nodes => {} );

    # $file is not required
    # and defaults to a brand new PNI::File.
    my $file = $arg->{file} || PNI::File->new;
    $self->add( file => $file );

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

    my $previous_content = $self->clear_all;

    my $content      = $self->get_file->get_content;
    my $stored_edges = $content->{edges};
    my $stored_nodes = $content->{nodes};

    my %new_id_of;
    my %get_node_by_id;

    # create nodes
    for my $stored_node_id ( keys %{$stored_nodes} ) {

        my $stored_node = $stored_nodes->{$stored_node_id};

        # retrieve stored data
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

        # TODO si potrebbe ssaltare un passaggio ?
        #      e usare un solo hash stored_node_id <--> node

        # remember  stored_node_id <--> node_id  relation
        $new_id_of{$stored_node_id} = $node_id;

        # remember  node_id <--> node  relation
        $get_node_by_id{$node_id} = $node;
    }

    # create edges
    for my $stored_edge_id ( keys %{$stored_edges} ) {

        my $stored_edge = $stored_edges->{$stored_edge_id};

        # retrieve stored data
        my $stored_source_node_id = $stored_edge->{source_node_id};
        my $stored_target_node_id = $stored_edge->{target_node_id};
        my $stored_source_name    = $stored_edge->{source_name};
        my $stored_target_name    = $stored_edge->{target_name};

        my $source_node_id = $new_id_of{$stored_source_node_id};
        my $target_node_id = $new_id_of{$stored_target_node_id};
        my $source_node    = $get_node_by_id{$source_node_id};
        my $target_node    = $get_node_by_id{$target_node_id};
        my $source         = $source_node->get_output($stored_source_name);
        my $target         = $target_node->get_input($stored_target_name);

        # N.B. : add_edge method is abstract, should be defined in child classes
        $self->add_edge(
            source => $source,
            target => $target
        );
    }

    return 1;
}

sub save_file {
    my $self = shift;
    my $file = $self->get_file;

    my $content = {};
    my $edges   = {};
    my $nodes   = {};

    # get info about nodes
    while ( my ( $gui_node_id, $gui_node ) = each %{ $self->get('nodes') } ) {
        my $center_y = $gui_node->get_center_y;
        my $center_x = $gui_node->get_center_x;
        my $node     = $gui_node->get_node;
        my $type     = $node->get_type;

        $nodes->{$gui_node_id} = {
            center_y => $center_y,
            center_x => $center_x,

            # TODO persistence for input values
            inputs => {},
            type   => $type,
        };
    }

    # get info about edges
    while ( my ( $edge_id, $edge ) = each %{ $self->get('edges') } ) {
        my $source_name    = $edge->get_source->get_name;
        my $source_node_id = $edge->get_source_node->id;
        my $target_name    = $edge->get_target->get_name;
        my $target_node_id = $edge->get_target_node->id;

        $edges->{$edge_id} = {
            source_name    => $source_name,
            source_node_id => $source_node_id,
            target_name    => $target_name,
            target_node_id => $target_node_id,
        };
    }

    $content->{edges} = $edges;
    $content->{nodes} = $nodes;
    return $file->set_content($content);
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

=cut

