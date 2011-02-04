package PNI::Slot::In;
use strict;
use warnings;
our $VERSION = '0.1';
use base 'PNI::Slot';

sub new {
    my $class = shift;

    # call the Slot constructor and check result
    my $self = $class->SUPER::new(@_) or return;
    $self->add('link');
    return $self;
}

sub add_link {
    my $self = shift;
    my $link = shift or return;
    $link->isa('PNI::Link') or return;
    return $self->set( 'link' => $link );
}

sub get_link {
    return shift->get('link');
}

sub del_link { }

1;

