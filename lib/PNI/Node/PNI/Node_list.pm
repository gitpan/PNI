package PNI::Node::PNI::Node_list;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';
use PNI::Finder 0.14;

my $find = PNI::Finder->new;

sub init {
    my $node = shift;

    $node->add_input('do_update');

    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $do_update = $node->get_input('do_update');

    if ( $do_update->get_data ) {
        my @nodes = $find->plugins;
        my $out   = $node->get_output('out');
        $out->set_data( \@nodes );
    }

    $do_update->set_data(0);

    return 1;
}

1;

=head1 NAME

PNI::Node::PNI::Node_list - PNI node list




=cut
