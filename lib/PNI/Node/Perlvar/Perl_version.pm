package PNI::Node::Perlvar::Perl_version;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_output( 'out', data => $^V );

    return 1;
}

sub task {
    return 1;
}

1;
