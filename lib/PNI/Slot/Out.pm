package PNI::Slot::Out;
use strict;
use warnings;
our $VERSION = '0.1';
use base 'PNI::Slot';

sub new {
    my $class = shift;

    # call the Slot constructor and check result
    my $self = $class->SUPER::new(@_) or return;
    $self->add( links => {} );
    return $self;
}

sub add_link {
    my $self = shift;
    my $link = shift or return;
    $self->get('links')->{ $link->id } = $link;
    return 1;
}

sub get_links {
    return values %{ shift->get('links') };
}

sub del_link { }

1;

