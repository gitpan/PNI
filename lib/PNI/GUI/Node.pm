package PNI::GUI::Node;
use strict;
use warnings;
use base 'PNI::Item';
use PNI::Error;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

    $self->add( center_y => $arg->{center_y} );

    $self->add( center_x => $arg->{center_x} );

    $self->add( height => $arg->{height} );

    # $node is not required but should be a PNI::Node
    my $node = $arg->{node};
    if ( defined $node and not $node->isa('PNI::Node') ) {
        return PNI::Error::invalid_argument_type;
    }
    $self->add( node => $node );

    # type is delegated to node

    # $label defaults to $self->get_node->get_type
    my $label = $arg->{label} || $self->get_node->get_type;

    $self->add( label => $label );

    $self->add( width => $arg->{width} );

    return $self;
}

# TODO sub add_input, add_output, del_input, del_output sono ABSTRACT ??

sub get_center_y { shift->get('center_y') }

sub get_center_x { shift->get('center_x') }

sub get_height { shift->get('height') }

sub get_label { shift->get('label') }

sub get_node { shift->get('node') }

sub get_type { shift->get_node->get_type }

sub get_width { shift->get('width') }

sub set_center_y {
    my $self     = shift;
    my $center_y = shift
      or return PNI::Error::missing_required_argument;

    $self->set( center_y => $center_y );
}

sub set_center_x {
    my $self     = shift;
    my $center_x = shift
      or return PNI::Error::missing_required_argument;

    $self->set( center_x => $center_x );
}

sub set_height {
    my $self   = shift;
    my $height = shift
      or return PNI::Error::missing_required_argument;

    $self->set( height => $height );
}

sub set_label {
    my $self  = shift;
    my $label = shift
      or return PNI::Error::missing_required_argument;

    $self->set( label => $label );
}

sub set_node {
    my $self = shift;
    my $node = shift
      or return PNI::Error::missing_required_argument;

    $self->set( node => $node );
}

sub set_width {
    my $self  = shift;
    my $width = shift
      or return PNI::Error::missing_required_argument;

    $self->set( width => $width );
}

1;
__END__

=head1 NAME

PNI::GUI::Node - is a node abstract view

=head1 METHODS

=head2 C<get_center_x>

=head2 C<get_center_y>

=head2 C<get_height>

=head2 C<get_label>

=head2 C<get_node>

=head2 C<get_type>

=head2 C<get_width>

=head2 C<set_center_x>

=head2 C<set_center_y>

=head2 C<set_height>

=head2 C<set_label>

=head2 C<set_node>

=head2 C<set_width>

=cut

