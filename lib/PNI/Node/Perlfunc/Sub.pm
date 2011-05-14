package PNI::Node::Perlfunc::Sub;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in_rows');

    $node->add_input('do_eval');

    $node->add_output('code');

    $node->add_output('error');

    return 1;
}

sub task {
    my $node = shift;

    # nothing to do if do_eval flag is not on
    my $do_eval = $node->get_input('do_eval');
    return 1 unless $do_eval->get_data;

    my $in_rows = $node->get_input('in_rows');
    return 1 if $in_rows->is_undef;

    my $error = $node->get_output('error');
    $error->set_data(undef);

    my $code = $node->get_output('code');
    my $code_ref;
    if ( $in_rows->is_scalar ) {
        my $row = $in_rows->get_data;
        eval { $code_ref = sub => {$row}; }
          or do { $error->set_data($@) };
    }
    elsif ( $in_rows->is_array ) {
        my $rows = join ' ', @{ $in_rows->get_data };
        eval { $code_ref = sub => {$rows}; }
          or do { $error->set_data($@) };
    }

    if ( $error->is_undef ) {
        $code->set_data($code_ref);

        # reset the do_eval flag
        $do_eval->set_data(0);
    }
    else {
        $code->set_data(0);
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlfunc::Sub - PNI node wrapping the Perl sub function






=cut
