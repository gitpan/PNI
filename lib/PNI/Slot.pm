package PNI::Slot;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Item';
use PNI::Error 0.14;
use Scalar::Util;

sub new {
    my $class = shift;
    my $arg   = {@_};

    # node arg is required and it must be a PNI::Node
    my $node = $arg->{node} or return PNI::Error::missing_required_argument;
    $node->isa('PNI::Node') or return PNI::Error::invalid_argument_type;

    # name arg is required
    my $name = $arg->{name} or return PNI::Error::missing_required_argument;

    # data parameter can be undef
    my $data = $arg->{data};

    my $self = $class->SUPER::new();
    $self->add( node => $node );
    $self->add( name => $name );
    $self->add( data => $data );

    return $self;
}

sub get_data { return shift->get('data'); }

sub get_name { return shift->get('name'); }

sub get_node { return shift->get('node'); }

sub get_type {
    my $data = shift->get_data;
    return 'UNDEF' if not defined $data;
    my $type = ref $data;
    return 'SCALAR' unless $type;
    return $type;
}

sub data {
    my $self = shift;

    if ( $self->is_array ) { return @{ $self->get_data }; }

    if ( $self->is_hash ) { return %{ $self->get_data }; }

    if ( $self->is_scalar ) { return $self->get_data; }

    if ( $self->is_undef ) { return $self->get_data; }

    # never reach here
    return PNI::Error::generic;
}

# by now is the same as get_data
sub data_ref { return shift->get('data'); }

sub join_to { return PNI::Error::unimplemented_abstract_method; }

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

sub is_connected { return PNI::Error::unimplemented_abstract_method; }

sub is_defined {
    my $type = shift->get_type;
    if ( $type eq 'UNDEF' ) {
        return 0;
    }
    else {
        return 1;
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

=head1 NAME

PNI::Slot - is a basic unit of data




=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
