package PNI::Node::Perlop::Not;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');

    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in_data = $node->get_input('in')->get_data;
    my $out     = $node->get_output('out');

    if ( defined $in_data ) {
        $out->set_data( not $in_data );
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlop::Not - PNI node wrapping the Perl not operator






=cut
