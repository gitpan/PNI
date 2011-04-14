package PNI::Node::Perlfunc::Sleep;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');

    return 1;
}

sub task {
    my $node = shift;

    my $in_data = $node->get_input('in')->get_data;

    if ( defined $in_data ) {
        sleep $in_data;
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlfunc::Sleep - PNI node wrapping the Perl sleep function




=cut
