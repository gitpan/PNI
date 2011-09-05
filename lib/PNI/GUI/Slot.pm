package PNI::GUI::Slot;
use parent 'PNI::Item';
use strict;
use PNI::Error;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

    my $center_y = $arg->{center_y};
    $self->add( center_y => $center_y );

    my $center_x = $arg->{center_x};
    $self->add( center_x => $center_x );

  # arg node is required
  # TODO non deve essere un PNI::GUI::Node, puo essere PNI::Node o PNI::Scenario
    my $node = $arg->{node}
      or return PNI::Error::missing_required_argument;

    $self->add( node => $node );

    my $slot = $arg->{slot}
      or return PNI::Error::missing_required_argument;
    $self->add( slot => $slot );

    return $self
}

sub get_center_y { shift->get('center_y') }

sub get_center_x { shift->get('center_x') }

sub get_name { shift->get_slot->get_name }

sub get_node { shift->get('node') }

sub get_slot { shift->get('slot') }

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

1
__END__

=head1 NAME

PNI::GUI::Slot

=head1 METHODS

=head2 C<get_center_y>

=head2 C<get_center_x>

=head2 C<get_name>

=head2 C<get_node>

=head2 C<get_slot>

=head2 C<set_center_y>

=head2 C<set_center_x>

=cut

