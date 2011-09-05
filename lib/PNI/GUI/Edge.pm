package PNI::GUI::Edge;
use strict;
use warnings;
use base 'PNI::Item';
use PNI::Edge;
use PNI::Error;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

    # create an empty edge
    my $edge = PNI::Edge->new;
    $self->add( edge => $edge );

    return $self
}

sub get_edge { shift->get('edge') }

sub get_end_y { PNI::Error::unimplemented_abstract_method }

sub get_end_x { PNI::Error::unimplemented_abstract_method }

sub get_start_y { PNI::Error::unimplemented_abstract_method }

sub get_start_x { PNI::Error::unimplemented_abstract_method }

sub set_end_y { PNI::Error::unimplemented_abstract_method }

sub set_end_x { PNI::Error::unimplemented_abstract_method }

sub set_start_y { PNI::Error::unimplemented_abstract_method }

sub set_start_x { PNI::Error::unimplemented_abstract_method }

1
__END__

=head1 NAME

PNI::GUI::Edge - is an edge abstract view

=head1 METHODS

=head2 C<get_edge>

=head2 C<get_end_x>

=head2 C<get_end_y>

=head2 C<get_start_x>

=head2 C<get_start_y>

=head2 C<set_end_y>

=head2 C<set_end_x>

=head2 C<set_start_y>

=head2 C<set_start_x>

=cut

