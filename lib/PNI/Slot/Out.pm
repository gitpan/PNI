package PNI::Slot::Out;
use strict;
use base 'PNI::Slot';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add( edges => {} );

    return $self;
}

sub add_edge {
    my $self = shift;
    my $edge = shift or return PNI::Error::missing_required_argument;
    $edge->isa('PNI::Edge') or return PNI::Error::invalid_argument_type;

    $self->get('edges')->{ $edge->id } = $edge;
    return 1;
}

sub get_edges { return values %{ shift->get('edges') }; }

# return 0 or 1
sub is_connected { return shift->get_edges ? 1 : 0; }

# return $edge
sub join_to {
    my $self = shift;

    # input_slot arg is required
    my $input_slot = shift or return PNI::Error::missing_required_argument;

    return PNI::Edge->new( source => $self, target => $input_slot );
}

1;
__END__

=head1 NAME

PNI::Slot::Out - output slot

=head1 ATTRIBUTES

=head2 C<edges>

=head1 METHODS

=head2 C<add_edge>

=head2 C<get_edges>

=head2 C<is_connected>

=head2 C<join_to>

=cut

