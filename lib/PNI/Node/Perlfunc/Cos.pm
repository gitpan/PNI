package PNI::Node::Perlfunc::Cos;
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
        my $cos_result = cos $in_data;

        $out->set_data($cos_result);
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;
