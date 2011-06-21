package PNI::Node::Cwd::Getcwd;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';
use Cwd;

sub init {
    my $node = shift;

    my $update = $node->add_input('update');

    my $out = $node->add_output('out');

    $update->set_data(1);

    return 1;
}

sub task {
    my $node = shift;

    my $update = $node->get_input('update');

    my $out = $node->get_output('out');

    if ( $update->get_data ) {
        $out->set_data(getcwd);
        $update->set_data(0);
    }

    return 1;
}

1;

=head1 NAME

PNI::Node:: - PNI node wrapping the L<Cwd> C<getcwd> function




=head1 INPUTS

=over 4

=item update

=back

=head1 OUTPUTS

=over 4

=item out

=back

=cut
