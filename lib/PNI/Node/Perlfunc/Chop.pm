package PNI::Node::Perlfunc::Chop;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');

    $node->add_output('last_char');

    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in        = $node->get_input('in');
    my $last_char = $node->get_output('last_char');
    my $out       = $node->get_output('out');

    if ( $in->is_undef ) {
        $out->set_data(undef);
    }
    else {
        my $in_data = $in->get_data;

        if ( $in->is_scalar ) {
            my $char = chop $in_data;
            $last_char->set_data($char);
            $out->set_data($in_data);
        }

        elsif ( $in->is_array ) {
            my $char = chop @{$in_data};
            $last_char->set_data($char);
            $out->set_data($in_data);
        }
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlfunc::Chop - PNI node wrapping the Perl chop function






=cut
