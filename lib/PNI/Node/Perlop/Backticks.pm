package PNI::Node::Perlop::Backticks;
use strict;
use warnings;
our $VERSION = '0.11';
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

        ## no critic BacktickOperators
        qx{$in_data};

        ## use critic
    }

    return 1;
}

1;
