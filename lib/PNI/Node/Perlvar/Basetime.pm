package PNI::Node::Perlvar::Basetime;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_output( 'out', data => $^T );

    return 1;
}

sub task {
    return 1;
}

1;
