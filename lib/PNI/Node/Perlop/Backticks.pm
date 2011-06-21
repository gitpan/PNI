package PNI::Node::Perlop::Backticks;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Node';

sub init {
    my $node = shift;

    my $in = $node->add_input('in');

    return 1;
}

sub task {
    my $node = shift;

    my $in = $node->get_input('in');

    my $in_data = $in->get_data;

    if ( defined $in_data ) {

        ## no critic BacktickOperators
        qx{$in_data};

        ## use critic
    }

    return 1;
}

1;

=head1 NAME

PNI::Node::Perlop::Backticks - PNI node wrapping the Perl C<..> operator




=head1 INPUTS

=over 4

=item in

=back

=head1 OUTPUTS

=over 4

=back

=cut
