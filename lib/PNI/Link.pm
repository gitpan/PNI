package PNI::Link;
use strict;
use warnings;
our $VERSION = '0.1';
use base 'PNI::Item';

sub new {
    my $class = shift;
    my $arg = {@_} or return;

    my $source = $arg->{source} or return;
    $source->isa('PNI::Slot::Out') or return;

    my $target = $arg->{target} or return;
    $target->isa('PNI::Slot::In') or return;

    my $self = $class->SUPER::new();

    # hierarchy is required for every node and link
    my $hierarchy = $arg->{hierarchy} or return;

    $self->add( hierarchy => $hierarchy );
    $self->add( source    => $source );
    $self->add( target    => $target );

    $source->add_link($self);
    $target->add_link($self);

    return $self;
}

sub get_source {
    return shift->get('source');
}

sub get_target {
    return shift->get('target');
}

sub get_source_node {
    return shift->get_source->get_node;
}

sub get_target_node {
    return shift->get_target->get_node;
}

sub task {
    my $self = shift;
    return $self->get_target->set_data( $self->get_source->get_data );
}

1;

