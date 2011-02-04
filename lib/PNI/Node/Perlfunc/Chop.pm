package PNI::Node::Perlfunc::Chop;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input('in');
    $node->add_output('out');
    $node->add_output('last_character');

    return 1;
}

sub task {
    my $node = shift;

    my $in = $node->get_input('in')->get_data;

    $node->get_output('last_character')->set_data( chop $in );

    $node->get_output('out')->set_data($in);

    return 1;
}

1;
