package PNI::Node::Perlfunc::Sleep;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');

    return 1;
}

sub task {
    my $node = shift;

    my $in = $node->get_input('in');

    if ( $in->is_number and $in->get_data > 0 ) {
        sleep $in->get_data;
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlfunc::Sleep - PNI node wrapping the Perl sleep function






=cut
