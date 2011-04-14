package PNI::Node::Cwd::Getcwd;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';
use Cwd;

sub init {
    my $node = shift;

    $node->add_input( 'update', data => 1 );
    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $update      = $node->get_input('update');
    my $update_flag = $update->get_data;

    if ($update_flag) {
        $node->get_output('out')->set_data(getcwd);
        $update->set_data(0);
    }

    return 1;
}

1;
