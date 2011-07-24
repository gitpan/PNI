package PNI::Edge;
use strict;
use base 'PNI::Item';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    # $source is not required but should be a PNI::Slot::Out
    my $source = $arg->{source};
    if ( defined $source and not $source->isa('PNI::Slot::Out') ) {
        return PNI::Error::invalid_argument_type;
    }
    $self->add( source => $source );

    # $target is not required but should be a PNI::Slot::In
    my $target = $arg->{target};
    if ( defined $target and not $target->isa('PNI::Slot::In') ) {
        return PNI::Error::invalid_argument_type;
    }
    $self->add( target => $target );

    defined $source and $source->add_edge($self);
    defined $target and $target->add_edge($self);

    return $self;
}

# return $source: PNI::Slot::Out
sub get_source { return shift->get('source') }

# return $source_node: PNI::Node
sub get_source_node { return shift->get_source->get_node; }

# return $target: PNI::Slot::In
sub get_target { return shift->get('target') }

# return $target_node: PNI::Node
sub get_target_node { return shift->get_target->get_node; }

sub task {
    my $self   = shift;
    my $source = $self->get_source or return 1;
    my $target = $self->get_target or return 1;

    $source->is_changed or return 1;

    $target->set_data( $source->get_data );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Edge - is used to connect two slots

=head1 METHODS

=head2 C<get_source>

=head2 C<get_source_node>

=head2 C<get_target>

=head2 C<get_target_node>

=head2 C<task>

=cut
