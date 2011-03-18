package PNI::Link;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Item';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg = {@_} or return;

    # source arg is required and it must be a PNI::Slot::Out
    my $source = $arg->{source}
      or return PNI::Error::missing_required_argument;
    $source->isa('PNI::Slot::Out')
      or return PNI::Error::invalid_argument_type;

    # target arg is required and it must be a PNI::Slot::In
    my $target = $arg->{target}
      or return PNI::Error::missing_required_argument;
    $target->isa('PNI::Slot::In')
      or return PNI::Error::invalid_argument_type;

    my $self = $class->SUPER::new;

    $self->add( source => $source );
    $self->add( target => $target );

    $source->add_link($self);
    $target->add_link($self);

    return $self;
}

sub get_source { return shift->get('source'); }

sub get_target { return shift->get('target'); }

sub get_source_node { return shift->get_source->get_node; }

sub get_target_node { return shift->get_target->get_node; }

sub task {
    my $self = shift;
    return $self->get_target->set_data( $self->get_source->get_data );
}

1;

