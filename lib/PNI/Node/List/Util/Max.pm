package PNI::Node::List::Util::Max;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

use List::Util 'max';

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
    my $result;

    if ( $in->is_array ) {
        $result = max $in->data;
    }

    $out->set_data($result);

    return 1;
}

1;

=head1 NAME

PNI::Node::List::Util::Max - PNI node wrapping the List::Util max function






=cut
