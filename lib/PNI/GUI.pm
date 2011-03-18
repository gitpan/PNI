package PNI::GUI;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Item';

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new();
    return $self;
}

1;
