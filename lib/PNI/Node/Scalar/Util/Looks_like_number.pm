package PNI::Node::Scalar::Util::Looks_like_number;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

use Scalar::Util 'looks_like_number';

sub init {
    my $node = shift;

    $node->add_input('in');

    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in  = $node->get_input('in');
    my $out = $node->get_output('out');

    if ( $in->is_defined ) {
        my $in_data  = $in->get_data;
        my $out_data = looks_like_number($in_data);
        $out->set_data($out_data);
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Scalar::Util::Looks_like_number - PNI node wrapping the Scalar::Util looks_like_number function






=cut
