package PNI::Node::Perlfunc::Sin;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');
    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in_data = $node->get_input('in')->get_data;
    my $out     = $node->get_output('out');

    if ( defined $in_data ) {
        $out->set_data( sin $in_data );
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;
