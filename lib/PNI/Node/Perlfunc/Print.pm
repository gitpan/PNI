package PNI::Node::Perlfunc::Print;

use strict;
use warnings;

our $VERSION = '0.1';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input('list');
    $node->add_input( 'do_print', data => 0 );

    return 1;
}

sub task {
    my $node = shift;

    # return unless do_print flag is 1
    return 1 unless $node->get_input('do_print')->get_data;

    my $rv = print STDOUT $node->get_input('list')->get_data;

    # reset do_print flag
    $node->get_input('do_print')->set_data(0);

    return 1;
}

1;
