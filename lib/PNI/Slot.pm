package PNI::Slot;
use parent 'PNI::Item';
use strict;
use PNI::Error;
use Scalar::Util;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

    $self->add( changed => 0 );

    # TODO should be renamed as data_ref
    # TODO IMPORTANTE !!! devono essere tutti dei riferimenti, anche gli scalari
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

    return $self
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

sub data {
    my $self = shift;

    if ( $self->is_array ) { return @{ $self->get_data } }

    if ( $self->is_hash ) { return %{ $self->get_data } }

    if ( $self->is_scalar ) { return $self->get_data }

    if ( $self->is_undef ) { return $self->get_data }

    # Never reach here!
    PNI::Error::generic
}

sub get_data { shift->get('data') }

sub get_name { shift->get('name') }

# return $node : PNI::Node
sub get_node { shift->get('node') }

# return $type
sub get_type {
    my $data = shift->get_data;

    return 'UNDEF' if not defined $data;

    my $type = ref $data;

    return 'SCALAR' unless $type;

    return $type
}

sub is_array { shift->get_type eq 'ARRAY' ? 1 : 0 }

sub is_changed { shift->get('changed') }

sub is_code { shift->get_type eq 'CODE' ? 1 : 0 }

sub is_connected { PNI::Error::unimplemented_abstract_method }

sub is_defined { shift->get_type eq 'UNDEF' ? 0 : 1 }

sub is_hash { shift->get_type eq 'HASH' ? 1 : 0 }

sub is_number { Scalar::Util::looks_like_number(shift->get_data) ? 1 : 0 }

sub is_scalar { shift->get_type eq 'SCALAR' ? 1 : 0 }

sub is_string {
    my $self = shift;
    $self->is_scalar or return 0;
    $self->is_number ? 0 : 1
}

sub is_undef { shift->get_type eq 'UNDEF' ? 1 : 0 }

# return PNI::Edge
sub join_to { PNI::Error::unimplemented_abstract_method }

sub set_data {
    my $self = shift;
    my $data = shift;

    # TODO $data must be a reference or a scalar
    #      try to implement to implement that if passed an array or an hash
    #      set_data understands and put a reference

    $self->set( changed => 1 ) if $data;

    # Slot data can be undef.
    return $self->set( data => $data )
}

1
__END__

=head1 NAME

PNI::Slot - is a basic unit of data

=head1 METHODS

=head2 C<data>

=head2 C<get_data>

=head2 C<get_name>

=head2 C<get_node>

=head2 C<get_type>

    my $type = $slot->get_type;

Returns a string representing the data type:
can be UNDEF, SCALAR or the output of Perl ref function ( ARRAY, HASH, CODE ... ).

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
