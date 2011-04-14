package PNI::Node::Perldata::Array;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';

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
    my $in_data;

    if ( $in->is_array ) {
        $in_data = $in->get_data;
    }

    $out->set_data($in_data);

    return 1;
}

1;

=head1 NAME

PNI::Node::Perldata::Array




=cut
