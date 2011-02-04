package PNI::Node::Perlfunc::Sleep;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input('in');

    return 1;
}

sub task {
    my $node = shift;

    my $sleeping_time = $node->get_input('in')->get_data;

    sleep $sleeping_time;

    return 1;
}

1;
