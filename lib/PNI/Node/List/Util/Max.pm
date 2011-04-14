package PNI::Node::List::Util::Max;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';

use List::Util 'max';

sub init {
    my $node = shift;

    $node->add_input('in1');

    $node->add_input('in2');

    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    return 1;
}

1;

=head1 NAME

PNI::Node::List::Util::Max




=cut
