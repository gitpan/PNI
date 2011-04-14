package PNI::Item;
use strict;
use warnings;
our $VERSION = '0.12';
use PNI::Error;

my $next_id;

# the %attr hash holds all attributes of every PNI::Item
my %attr;

sub new {
    my $class   = shift;
    my $item_id = ++$next_id;
    return bless \$item_id, $class;
}

sub id {
    my $self = shift;
    return $$self;
}

sub cleanup {
    my $self = shift;
    my $id   = $self->id;

    for my $attribute_name ( keys %{ $attr{$id} } ) {
        delete $attr{$id}{$attribute_name};
    }

    return 1;
}

# init is abstract ...
sub init { return PNI::Error::unimplemented_abstract_method; }

sub add {
    my $self = shift;
    my $id   = $self->id;

    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    # attribute names are unique and cannot be overridden
    exists $attr{$id}{$attribute_name} and return;

    # attribute value can be undef
    my $attribute_value = shift;

    $attr{$id}{$attribute_name} = $attribute_value;

    return 1;
}

sub del {
    my $self           = shift;
    my $id             = $self->id;
    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    delete $attr{$id}{$attribute_name};
    return 1;
}

sub set {
    my $self = shift;
    my $id   = $self->id;

    my $attribute_name = shift or return;

    # check if attribute exists
    exists $attr{$id}{$attribute_name} or return;

    # attribute value can be undef
    my $attribute_value = shift;

    $attr{$id}{$attribute_name} = $attribute_value;

    return 1;
}

sub get {
    my $self           = shift;
    my $id             = $self->id;
    my $attribute_name = shift or return;
    exists $attr{$id}{$attribute_name} or return;
    return $attr{$id}{$attribute_name};
}

sub DESTROY {

    # garbage all item attributes
    return shift->cleanup;
}

1;
