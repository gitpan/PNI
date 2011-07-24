package PNI::Item;
use strict;
use warnings;
use PNI::Error;

my $next_id;

# the %attr hash holds all attributes of every PNI::Item
my %attr;

# return $self
sub new {
    my $class   = shift;
    my $item_id = ++$next_id;
    return bless \$item_id, $class;
}

# return 1
sub add {
    my $id = shift->id;

    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    # attribute names are unique and cannot be overridden
    exists $attr{$id}{$attribute_name}
      and return PNI::Error::overridden_attribute_name;

    # attribute value can be undef
    my $attribute_value = shift;

    $attr{$id}{$attribute_name} = $attribute_value;

    return 1;
}

# return 1
sub cleanup {
    my $id = shift->id;

    for my $attribute_name ( keys %{ $attr{$id} } ) {
        my $attribute_value = $attr{$id}{$attribute_name};
        delete $attr{$id}{$attribute_name};
        undef $attribute_value;
    }

    return 1;
}

# return 1
sub del {
    my $id = shift->id;
    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    my $attribute_value = delete $attr{$id}{$attribute_name};
    undef $attribute_value;

    return 1;
}

# return $attribute_value
sub get {
    my $self           = shift;
    my $id             = $self->id;
    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    # check if attribute exists
    $self->has($attribute_name) or return PNI::Error::attribute_does_not_exists;

    return $attr{$id}{$attribute_name};
}

# return 1 or 0
sub has {
    my $id = shift->id;
    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    return exists $attr{$id}{$attribute_name} || 0;
}

# return $id
sub id {
    my $self = shift;
    return ${$self};
}

# TODO every package should define an $attribute hash_ref
# so this init sub could be called after constructor by default
# this should give introspection and a lot of cool things
# also need an $init_args
# so nodes could just have a "our $attributes" or "our $inputs" "out $outputs"
# do this before 1.0 !!!!!!
sub init { return PNI::Error::unimplemented_abstract_method; }

# return 1
sub set {
    my $self           = shift;
    my $id             = $self->id;
    my $attribute_name = shift or return PNI::Error::missing_required_argument;
    ### set: $attribute_name

    # check if attribute exists
    $self->has($attribute_name) or return PNI::Error::attribute_does_not_exists;

    # attribute value can be undef
    my $attribute_value = shift;

    $attr{$id}{$attribute_name} = $attribute_value;

    return 1;
}

# return $type
sub type { return ref shift; }

sub DESTROY {

    # garbage all item attributes
    return shift->cleanup;
}

1;
__END__

=head1 NAME

PNI::Item - is the base class

=head1 SYNOPSIS

    package PNI::Point;

    use strict;
    use base 'PNI::Item';

=head1 DESCRIPTION

This is an inside out object, to provide encapsulation for PNI classes.

Every object has an id, for instance, the reference to the object itself is a blessed id.

Objects can be (un)decorated adding/removing attributes at runtime.

Every attribute value is a scalar or a reference.

=head1 METHODS

=head2 C<add>

    $self->add('x'); 
    $self->add( y => 1 );

=head2 C<cleanup>

=head2 C<del>

=head2 C<get>

    my $x = $self->get('x');

=head2 C<has>

=head2 C<id>

    my $id = $self->id;

=head2 C<init>

=head2 C<set>

    $self->set( x => 10 );

=head2 C<type>

    my $type = $self->type; # the package name

=cut
