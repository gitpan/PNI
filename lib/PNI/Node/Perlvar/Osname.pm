package PNI::Node::Perlvar::Osname;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_output( 'out', data => $^O );

    return 1;
}

sub task {
    return 1;
}

1;
