package PNI::Node::Perlvar::Process_id;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_output( 'out', data => $$ );

    return 1;
}

sub task {
    return 1;
}

1;
