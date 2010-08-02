package PNI::Node::Perlop::Range;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'in1' => 0 );
    $node->add_input( 'in2' => 0 );

    $node->add_output( 'out' => [] );

    return 1;
}

sub task {
    my $node = shift;

    $node->set_output(
        out => [ $node->get_input('in1') .. $node->get_input('in2') ] );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Range - PNI node that implements Perl and operator

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
