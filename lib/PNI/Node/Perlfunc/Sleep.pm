package PNI::Node::Perlfunc::Sleep;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'seconds' => 1 );
    $node->add_input( 'bang'    => 0 );

    return 1;
}

sub task {
    my $node = shift;

    return 1 unless $node->get_input('bang');

    my $seconds = $node->get_input('seconds');

    sleep $seconds;

    $node->set_input( 'bang' => 0 );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Sleep - PNI node that implements Perl sleep builtin function.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
