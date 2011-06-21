package PNI::Node::Perlvar::Basetime;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $out = $node->add_output('out');

    $out->set_data($^T);

    return 1;
}

sub task { return 1; }

1;

=head1 NAME

PNI::Node:: - PNI node to access the Perl C<$^T> variable




=head1 INPUTS

=over 4

=back

=head1 OUTPUTS

=over 4

=item out

=back

=cut
