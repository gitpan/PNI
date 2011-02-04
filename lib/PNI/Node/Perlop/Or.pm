package PNI::Node::Perlop::Or;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input('in1');
    $node->add_input('in2');

    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    $node->get_output('out')->set_data(
             $node->get_input('in1')->get_data
          or $node->get_input('in2')->get_data
    );

    return 1;
}

1;
