package PNI::Node::Perlfunc::Chop;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');
    $node->add_output('last_character');
    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in_data        = $node->get_input('in')->get_data;
    my $last_character = $node->get_output('last_character');
    my $out            = $node->get_output('out');

    if ( defined $in_data ) {
        my $last_character_data = chop $in_data;
        $last_character->set_data($last_character_data);

        $out->set_data($in_data);
    }
    else {
        $last_character->set_data(undef);
        $out->set_data(undef);
    }
    return 1;
}

1;
