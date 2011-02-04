package PNI::Node::Perlfunc::Sqrt;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input('in');
    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    $node->get_output('out')->set_data( sqrt $node->get_input('in')->get_data );

    return 1;
}

1;
