package PNI::Node::Perlop::Backticks;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'in' => '' );

    return 1;
}

sub task {
    my $node = shift;

    return 1 unless my $in = $node->get_input('in');

    qx{$in};

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Backticks - PNI node that implements Perl qx{} operator

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
