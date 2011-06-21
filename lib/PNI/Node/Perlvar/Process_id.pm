package PNI::Node::Perlvar::Process_id;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $out = $node->add_output('out');

    $out->set_data($$);

    return 1;
}

sub task { return 1; }

1;

=head1 NAME

PNI::Node:: - PNI node to access the Perl C<$$> variable




=head1 INPUTS

=over 4

=back

=head1 OUTPUTS

=over 4

=item out

=back

=cut
