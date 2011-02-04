package PNI::Item;
use strict;
use warnings;
our $VERSION = '0.1';

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

sub add {
    my $self = shift;
    my $id   = $self->id;

    my $attribute_name = shift or return;

    # attribute names are unique and cannot be overridden
    exists $attr{$id}{$attribute_name} and return;

    # value can be undef
    my $attribute_value = shift;

    $attr{$id}{$attribute_name} = $attribute_value;

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
    my $self = shift;
    my $id   = $self->id;

    # garbage all item attributes
    for my $attribute_name ( keys %{ $attr{$id} } ) {
        delete $attr{$id}{$attribute_name};
    }

    return 1;
}

1;

