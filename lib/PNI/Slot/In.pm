package PNI::Slot::In;
use strict;
use base 'PNI::Slot';
use PNI::Edge;
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add('edge');

    return $self;
}

sub add_edge {
    my $self = shift;
    my $edge = shift or return PNI::Error::missing_required_argument;
    $edge->isa('PNI::Edge') or return PNI::Error::invalid_argument_type;
    return $self->set( edge => $edge );
}

# return $edge: PNI::Edge
sub get_edge { shift->get('edge') }

# return 0 or 1
sub is_connected { defined( shift->get_edge ) ? 1 : 0 }

# return $edge: PNI::Edge
sub join_to {
    my $self = shift;

    # output_slot arg is required
    my $output_slot = shift or return PNI::Error::missing_required_argument;

    return PNI::Edge->new( source => $output_slot, target => $self );
}

1;
__END__

=head1 NAME

PNI::Slot::In - input slot

=head1 METHODS

=head2 C<add_edge>

=head2 C<get_edge>

=head2 C<is_connected>

    $in->is_connected;

=head2 C<join_to>

    my $new_edge = $in->join_to( $out );

=cut
