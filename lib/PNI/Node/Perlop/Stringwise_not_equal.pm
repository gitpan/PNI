package PNI::Node::Perlop::Stringwise_not_equal;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in1');
    $node->add_input('in2');
    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in1_data = $node->get_input('in1')->get_data;
    my $in2_data = $node->get_input('in2')->get_data;
    my $out      = $node->get_output('out');

    if ( defined $in1_data and $in2_data ) {
        $out->set_data( $in1_data ne $in2_data );
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;
