package PNI::GUI::Scenario;
use parent 'PNI::Item';
use strict;
use PNI::File;
use PNI::Error;

sub new {
    my $self  = shift->SUPER::new;
    my $arg   = {@_};

    $self->add( comments => {} );
    $self->add( edges    => {} );
    $self->add( nodes    => {} );

    # $file is not required
    # and defaults to a brand new PNI::File.
    my $file = $arg->{file} || PNI::File->new;
    $self->add( file => $file );

    # $scenario is required
    my $scenario = $arg->{scenario}
      or return PNI::Error::missing_required_argument;

    # $scenario must be a PNI::Scenario
    $scenario->isa('PNI::Scenario')
      or return PNI::Error::invalid_argument_type;

    $self->add( scenario => $scenario );

    return $self
}

# return $comment : PNI::GUI::Comment
sub add_comment { PNI::Error::unimplemented_abstract_method }

# return $edge : PNI::GUI::Edge
sub add_edge { PNI::Error::unimplemented_abstract_method }

# return $node : PNI::GUI::Node
sub add_node { PNI::Error::unimplemented_abstract_method }

# return $scenario : PNI::GUI::Scenario
sub add_scenario { PNI::Error::unimplemented_abstract_method }

# return \%content
sub clear_all {
    my $self             = shift;
    my $previous_content = {};

    $previous_content = {
        comments => $self->get('comments'),
        edges    => $self->get('edges'),
        nodes    => $self->get('nodes'),
    };

    # Clear stuff.
    $self->set( comments => {} );
    $self->set( edges    => {} );
    $self->set( nodes    => {} );

    return $previous_content
}

sub del_edge { PNI::Error::unimplemented_abstract_method }

sub del_node { PNI::Error::unimplemented_abstract_method }

sub del_scenario {}

# return $file : PNI::File
sub get_file { shift->get('file') }

# return $scenario : PNI::Scenario
sub get_scenario { shift->get('scenario') }

sub load_file {
    my $self = shift;

    my $previous_content = $self->clear_all;

    my $content         = $self->get_file->get_content;
    my $stored_comments = $content->{comments};
    my $stored_edges    = $content->{edges};
    my $stored_nodes    = $content->{nodes};

    my %new_id_of;
    my %get_node_by_id;

    # Create nodes.
    #--------------------------------------------------------------------------
    for my $stored_node_id ( keys %{$stored_nodes} ) {

        my $stored_node = $stored_nodes->{$stored_node_id};

        # Retrieve stored data
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

        # Remember  stored_node_id <--> node_id  relation.
        $new_id_of{$stored_node_id} = $node_id;

        # Remember  node_id <--> node  relation.
        $get_node_by_id{$node_id} = $node;
    }
    #--------------------------------------------------------------------------

    # Create edges.
    #--------------------------------------------------------------------------
    for my $stored_edge_id ( keys %{$stored_edges} ) {

        my $stored_edge = $stored_edges->{$stored_edge_id};

        # Retrieve stored data.
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

        # N.B. : 
        # add_edge method is abstract, should be defined in child classes.
        $self->add_edge(
            source => $source,
            target => $target
        );
    }
    #--------------------------------------------------------------------------

    # Create comments.
    #--------------------------------------------------------------------------
    for my $stored_comment_id ( keys %{$stored_comments} ) {

        my $stored_comment = $stored_comments->{$stored_comment_id};

        # Retrieve stored data
        my $center_y = $stored_comment->{center_y};
        my $center_x = $stored_comment->{center_x};
        my $content  = $stored_comment->{content};

     # N.B. : add_comment method is abstract, should be defined in child classes
        $self->add_comment(
            center_y => $center_y,
            center_x => $center_x,
            content  => $content,
        );
    }
    #--------------------------------------------------------------------------
}

# return \%content
sub save_file {
    my $self = shift;
    my $file = $self->get_file;

    my $comments = {};
    my $edges    = {};
    my $nodes    = {};

    # Get info about nodes.
    #-------------------------------------------------------------------------
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
    #-------------------------------------------------------------------------

    # Get info about edges.
    #-------------------------------------------------------------------------
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
    #-------------------------------------------------------------------------

    # Get info about comments.
    #-------------------------------------------------------------------------
    while ( my ( $comment_id, $comment ) = each %{ $self->get('comments') } ) {
        my $center_y = $comment->get_center_y;
        my $center_x = $comment->get_center_x;
        my $content  = $comment->get_content;

        $comments->{$comment_id} = {
            center_y => $center_y,
            center_x => $center_x,
            content  => $content,
        };
    }
    #-------------------------------------------------------------------------

    return $file->set_content(
        {
            comments => $comments,
            edges    => $edges,
            nodes    => $nodes,
        }
    )
}

sub set_file {
    my $self = shift;
    my $file = shift;

    $self->set( file => $file );
}

1
__END__

=head1 NAME

PNI::GUI::Scenario - is a scenario abstract view

=head1 SYNOPSIS

    use PNI;
    use PNI::File;
    use PNI::GUI::Scenario;

    my $file = PNI::File->new;
    my $scenario = PNI::root->add_scenario;

    my $gui_scenario = PNI::GUI::Scenario->new(
        file => $file,
        scenario => $scenario,
    );

=head1 ATTRIBUTES

=head2 C<comments>

=head2 C<edges>

=head2 C<file>

    my $file = $gui_scenario->get_file;

    my $new_file = PNI::File->new;
    $gui_scenario->set_file( $new_file );
    $gui_scenario->save_file;

=head2 C<nodes>

=head1 METHODS

=head2 C<add_comment>

=head2 C<add_edge>

=head2 C<add_node>

=head2 C<add_scenario>

=head2 C<clear_all>

    my $previous_content = $scenario->clear_all;

=head2 C<del_edge>

=head2 C<del_node>

=head2 C<get_file>

    my $file = $scenario->get_file;

=head2 C<get_scenario>

=head2 C<load_file>

=head2 C<save_file>

    my $content = $scenario->save_file;

Saves the scenario content in the .pni C<file>.

=head2 C<set_file>

=cut

