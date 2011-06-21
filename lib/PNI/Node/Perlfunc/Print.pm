package PNI::Node::Perlfunc::Print;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $handle = $node->add_input('handle');

    my $list = $node->add_input('list');

    my $do_print = $node->add_input('do_print');

    return 1;
}

sub task {
    my $node = shift;

    my $handle = $node->get_input('handle');

    my $list = $node->get_input('list');

    my $do_print = $node->get_input('do_print');

    if ( $do_print->is_defined ) {

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

PNI::Node::Perlfunc::Print - PNI node wrapping the Perl C<print> function




=head1 INPUTS

=over 4

=item handle

=item list

=item do_print

=back

=head1 OUTPUTS

=over 4

=back

=cut
