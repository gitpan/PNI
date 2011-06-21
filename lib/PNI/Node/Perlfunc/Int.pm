package PNI::Node::Perlfunc::Int;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $in = $node->add_input('in');

    my $out = $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in = $node->get_input('in');

    my $out = $node->get_output('out');

    my $result;

    if ( $in->is_number ) {
        $result = int $in->get_data;
    }

    $out->set_data($result);

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlfunc::Int - PNI node wrapping the Perl C<int> function




=head1 INPUTS

=over 4

=item in

=back

=head1 OUTPUTS

=over 4

=item out

=back

=cut
