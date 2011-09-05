package PNI::GUI::Comment;
use parent 'PNI::Item';
use strict;

sub new {
    my $self = shift->SUPER::new;
    my $arg={@_};

    $self->add( center_y => $arg->{center_y} );

    $self->add( center_x => $arg->{center_x} );

    $self->add( content => $arg->{content} );

    return $self
}

sub get_center_y { shift->get('center_y') }

sub get_center_x { shift->get('center_x') }

sub get_content { shift->get('content') }

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

PNI::GUI::Comment

=head1 METHODS

=head2 C<get_center_y>

=head2 C<get_center_x>

=head2 C<get_content>

=head2 C<set_center_y>

=head2 C<set_center_x>

=cut

