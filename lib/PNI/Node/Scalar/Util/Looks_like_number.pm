package PNI::Node::Scalar::Util::Looks_like_number;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Node';

use Scalar::Util 'looks_like_number';

sub init {
    my $node = shift;

    $node->add_input('in');

    return 1;
}

sub task {
    my $node = shift;

    return 1;
}

1;

=head1 NAME

PNI::Node::Scalar::Util::Looks_like_number




=head1 SEE ALSO

L<Scalar::Util>
L<PNI::Node::Scalar::Util>

=cut
