package PNI::Edge;
use parent 'PNI::Item';
use strict;
use PNI::Error;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

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

    # Finally, if both source and target are defined emulate a task method
    # TODO this could be inside an init method
    if ( defined $source and defined $target ) {
        $target->set_data( $source->get_data );
    }

    return $self
}

# return $source : PNI::Slot::Out
sub get_source { shift->get('source') }

# return $target : PNI::Slot::In
sub get_target { shift->get('target') }

sub task {
    my $self = shift;

    # Nothing to do if there is no source.
    my $source = $self->get_source or return 1;

    # Nothing to do if there is no target.
    my $target = $self->get_target or return 1;

    # This is Edge's task: pass data from target to source.
    $target->set_data( $source->get_data );

    return 1
}

1
__END__

=head1 NAME

PNI::Edge - is used to connect two slots

=head1 SYNOPSIS

    # connects the output of a node to the input of another node
    my $edge = PNI::Edge->new( source => $output, target => $input );

    my $not_connected_edge = PNI::Edge->new;

=head1 METHODS

=head2 C<get_source>

    my $output = $edge->get_source;

=head2 C<get_target>

    my $input = $edge->get_target;

=head2 C<task>

    $edge->task

If edge is connected, pass data from target to source.

=cut

