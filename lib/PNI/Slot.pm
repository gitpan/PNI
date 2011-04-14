package PNI::Slot;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Item';
use Scalar::Util;

sub new {
    my $class = shift;
    my $arg = {@_} or return;

    # node arg is required and it must be a PNI::Node
    my $node = $arg->{node} or return;
    $node->isa('PNI::Node') or return;

    # name arg is required
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

sub get_data {
    return shift->get('data');
}

sub get_node {
    return shift->get('node');
}

sub get_type {
    my $data = shift->get_data;
    return 'UNDEF' if not defined $data;
    my $type = ref $data;
    return 'SCALAR' unless $type;
    return $type;
}

sub is_array {
    my $type = shift->get_type;
    if ( $type eq 'ARRAY' ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub is_code {
    my $type = shift->get_type;
    if ( $type eq 'CODE' ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub is_hash {
    my $type = shift->get_type;
    if ( $type eq 'HASH' ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub is_number {
    my $self = shift;
    if ( $self->is_scalar ) {
        my $data = $self->get_data;
        if ( Scalar::Util::looks_like_number($data) ) {
            return 1;
        }
        else { return 0; }
    }
    else { return 0; }
}

sub is_scalar {
    my $type = shift->get_type;
    if ( $type eq 'SCALAR' ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub is_string {
    my $self = shift;
    if ( $self->is_scalar ) {
        if ( $self->is_number ) {
            return 0;
        }
        else { return 1; }
    }
    else { return 0; }
}

sub is_undef {
    my $type = shift->get_type;
    if ( $type eq 'UNDEF' ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub set_data {
    my $self = shift;

    # slot data can be undef
    my $data = shift;
    return $self->set( data => $data );
}

1;
