package PNI::Item;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use PNI::Error 0.15;

my $next_id;

# the %attr hash holds all attributes of every PNI::Item
my %attr;

# return $self
sub new {
    my $class = shift;
    ### new: $class
    my $item_id = ++$next_id;
    ### id: $item_id
    return bless \$item_id, $class;
}

# return 1
sub add {
    my $self = shift;
    my $id   = $self->id;

    my $attribute_name = shift or return PNI::Error::missing_required_argument;
    ### add: $attribute_name

    # attribute names are unique and cannot be overridden
    exists $attr{$id}{$attribute_name} and return PNI::Error::generic;

    # attribute value can be undef
    my $attribute_value = shift;

    $attr{$id}{$attribute_name} = $attribute_value;

    return 1;
}

# return 1
sub cleanup {
    my $self = shift;
    my $id   = $self->id;

    ### cleanup: $id
    for my $attribute_name ( keys %{ $attr{$id} } ) {
        ### delete: $attribute_name
        delete $attr{$id}{$attribute_name};
    }

    return 1;
}

# return 1
sub del {
    my $self           = shift;
    my $id             = $self->id;
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
    my $self           = shift;
    my $id             = $self->id;
    my $attribute_name = shift or return PNI::Error::missing_required_argument;

    return exists $attr{$id}{$attribute_name} || 0;
}

# return $id
sub id {
    my $self = shift;
    return ${$self};
}

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


=head1 METHODS

=head2 C<add>

=head2 C<cleanup>

=head2 C<del>

=head2 C<get>

=head2 C<has>

=head2 C<id>

=head2 C<set>

=head2 C<type>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
