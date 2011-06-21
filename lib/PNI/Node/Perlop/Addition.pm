package PNI::Node::Perlop::Addition;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $in1 = $node->add_input('in1');

    my $in2 = $node->add_input('in2');

    my $out = $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in1 = $node->get_input('in1');

    my $in2 = $node->get_input('in2');

    my $out = $node->get_output('out');

    if ( $in1->is_defined and $in2->is_defined ) {
        my $in1_data = $in1->get_data;
        my $in2_data = $in2->get_data;
        $out->set_data( $in1_data + $in2_data );
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlop::Addition - PNI node wrapping the Perl C<+> operator




=head1 INPUTS

=over 4

=item in1

=item in2

=back

=head1 OUTPUTS

=over 4

=item out

=back

=cut
