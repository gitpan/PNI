package PNI::Slot;
use strict;
use base 'PNI::Item';
use PNI::Error;
use Scalar::Util;

sub new {
    my $self  = shift->SUPER::new;
    my $arg   = {@_};

    $self->add( changed => 0 );

    # TODO should be renamed as data_ref
    $self->add( data => $arg->{data} );

    # TODO arg name is not required , maybe it should be, or it should default to slot id or something
    $self->add( name => $arg->{name} );

    # $node is not required but should be a PNI::Node
    my $node = $arg->{node};
    if ( defined $node and not $node->isa('PNI::Node') ) {
        return PNI::Error::invalid_argument_type;
    }
    $self->add( node => $node );

    #    # data_check can be undef
    #    my $data_check = $arg->{data_check};
    #    # if provided must be a CODE or an array_ref of CODE
    #    if( defined $data_check ){
    #        if( ref( $data_check ) eq 'CODE' ) {
    #            # if it a single CODE, put it in an array_ref of CODE
    #            $data_check = [ $data_check ];
    #        }elsif( ref( $data_check ) eq 'ARRAY' ) {
    #            # check that every element is a CODE
    #            for my $code ( @{ $data_check } ) {
    #                if( ref( $code ) eq 'CODE' ) { }else{
    #                    return PNI::Error::invalid_argument_type;
    #                }
    #            }
    #        }else{ return PNI::Error::invalid_argument_type; }
    #    }else{
    #        # defaults to an empty array ref
    #        $data_check = [];
    #    }
    #    $self->add( data_check => $data_check );

    return $self;
}

## return 1
#sub add_data_check {
#    my $self = shift;
#    my $data_check = shift or return PNI::Error::missing_required_argument;
#
##    if( ref( $data_check ) eq 'CODE' ) {
#        push @{ $self->get('data_check') }, $data_check;
#    }else{
#        return PNI::Error::invalid_argument_type;
#    }
#    return 1;
#}
################### TODO consider to deprecate data_check
# return 0 or 1
#sub check_data {
#    my $self = shift;
#    # if data arg is not provided check is failed
#    my $data = shift or return 0;
#
#    for my $data_check ( @{ $self->get('data_check') } ) {
#        $data_check->( $data ) or return 0;
#    }
#
#    return 1;
#}

sub get_data { return shift->get('data') }

sub get_name { return shift->get('name') }

sub get_node { return shift->get('node') }

# return $type
# $type can be UNDEF SCALAR, the output of a Perl ref function ( ARRAY, HASH, CODE ... )
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

# return $data_ref
#sub data_ref { return shift->get('data'); }

# return PNI::Edge
sub join_to { return PNI::Error::unimplemented_abstract_method; }

# return 0 or 1
sub is_array {
    my $type = shift->get_type;
    if ( $type eq 'ARRAY' ) {
        return 1;
    }
    else {
        return 0;
    }
}

# return 0 or 1
sub is_changed {
    my $self = shift;
    if ( $self->get('changed') ) {
        return 1;
    }
    else {
        return 0;
    }
}

# return 0 or 1
sub is_code {
    my $type = shift->get_type;
    if ( $type eq 'CODE' ) {
        return 1;
    }
    else {
        return 0;
    }
}

# return 0 or 1
sub is_connected { return PNI::Error::unimplemented_abstract_method; }

# return 0 or 1
sub is_defined {
    my $type = shift->get_type;
    if ( $type eq 'UNDEF' ) {
        return 0;
    }
    else {
        return 1;
    }
}

# return 0 or 1
sub is_hash {
    my $type = shift->get_type;
    if ( $type eq 'HASH' ) {
        return 1;
    }
    else {
        return 0;
    }
}

# return 0 or 1
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

# return 0 or 1
sub is_scalar {
    my $type = shift->get_type;
    if ( $type eq 'SCALAR' ) {
        return 1;
    }
    else {
        return 0;
    }
}

# return 0 or 1
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

# return 0 or 1
sub is_undef {
    my $type = shift->get_type;
    if ( $type eq 'UNDEF' ) {
        return 1;
    }
    else {
        return 0;
    }
}

# return
sub set_data {
    my $self = shift;
    my $data = shift;

    # TODO $data must be a reference or a scalar
    #      try to implement to implement that if passed an array or an hash
    #      set_data understands and put a reference

    # set changed flag
    $self->set( changed => 1 );

    # slot data can be undef
    return $self->set( data => $data );
}

1;
__END__

=head1 NAME

PNI::Slot - is a basic unit of data

=head1 METHODS

=head2 C<data>

=head2 C<get_data>

=head2 C<get_name>

=head2 C<get_node>

=head2 C<get_type>

=head2 C<join_to>

=head2 C<is_array>

=head2 C<is_changed>

Returns 1 if slot data is changed.

=head2 C<is_code>

=head2 C<is_connected>

=head2 C<is_defined>

=head2 C<is_hash>

=head2 C<is_number>

=head2 C<is_scalar>

=head2 C<is_string>

=head2 C<is_undef>

=head2 C<set_data>

=cut
