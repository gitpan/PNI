package PNI::Node::Perldata::Array_ref;

use strict;
use warnings;

our $VERSION = '0.01';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_output( 'out' => [] );

    return 1;
}

sub task{ 1 }

return 1;
