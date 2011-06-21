package PNI::Node::Perlfunc::Sub;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $in_rows = $node->add_input('in_rows');

    my $do_eval = $node->add_input('do_eval');

    my $code = $node->add_output('code');

    my $error = $node->add_output('error');

    return 1;
}

sub task {
    my $node = shift;

    my $in_rows = $node->get_input('in_rows');

    my $do_eval = $node->get_input('do_eval');

    my $code = $node->get_output('code');

    my $error = $node->get_output('error');

    # nothing to do if do_eval flag is not on
    return 1 unless $do_eval->get_data;

    return 1 if $in_rows->is_undef;

    # reset error output
    $error->set_data(undef);

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

PNI::Node::Perlfunc::Sub - PNI node wrapping the Perl C<sub> function




=head1 INPUTS

=over 4

=item in_rows

=item do_eval

=back

=head1 OUTPUTS

=over 4

=item code

=item error

=back

=cut
