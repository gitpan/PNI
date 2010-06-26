package PNI::Node::Perlfunc::Print;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'list' => 'hello' );
    $node->add_input( 'bang' => 0 );

    return;
}

sub task {
    my $node = shift;

    return unless $node->get_input('bang') and defined $node->get_input('list');

    print STDOUT $node->get_input('list');

    $node->set_input( bang => 0 );

    return;
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Print - PNI node that implements Perl print builtin function.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
