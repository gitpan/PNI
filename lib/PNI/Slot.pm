package PNI::Slot;
use strict;
use warnings;
our $VERSION = '0.1';
use base 'PNI::Item';

sub new {
    my $class = shift;
    my $arg = {@_} or return;

    my $node = $arg->{node} or return;
    $node->isa('PNI::Node') or return;

    my $name = $arg->{name} or return;

    # data parameter can be undef
    my $data = $arg->{data};

    my $self = $class->SUPER::new();
    $self->add( node => $node );
    $self->add( name => $name );
    $self->add( data => $data );
    return $self;
}

sub get_name {
    return shift->get('name');
}

sub set_name { }

sub get_node {
    return shift->get('node');
}

sub get_data {
    return shift->get('data');
}

sub set_data {
    my $self = shift;

    # slot data can be undef
    my $data = shift;
    return $self->set( data => $data );
}

1;

