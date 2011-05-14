package PNI::Node::Perlfunc::Print;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('handle');
    $node->add_input('list');
    $node->add_input('do_print');

    return 1;
}

sub task {
    my $node = shift;

    my $do_print = $node->get_input('do_print');

    if ( $do_print->is_defined ) {

        my $list = $node->get_input('list');

        if ( $list->is_array ) {
            my $rv = print STDOUT @{ $list->get_data };
        }

        if ( $list->is_scalar ) {
            my $rv = print STDOUT $list->get_data;
        }
    }

    # reset do_print flag
    $do_print->set_data(undef);

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlfunc::Print - PNI node wrapping the Perl print function






=cut
