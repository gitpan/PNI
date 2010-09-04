package PNI::Node::Perlop::Sum;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'in1' => 0 );
    $node->add_input( 'in2' => 0 );

    $node->add_output( 'out' => 0 );

    return 1;
}

sub task {
    my $node = shift;

    return 1 unless defined $node->get_input('in1')

          and defined $node->get_input('in2');

    $node->set_output(
        out => $node->get_input('in1') + $node->get_input('in2') );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Sum - PNI node that implements Perl + operator

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
