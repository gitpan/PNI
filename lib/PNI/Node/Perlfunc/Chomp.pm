package PNI::Node::Perlfunc::Chomp;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'in' => [] );

    $node->add_output( 'out' => undef );

    return 1;
}

sub task {
    my $node = shift;

    my @list = @{ $node->get_input('in') };

    chomp(@list);

    $node->set_output( 'out' => [@list] );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Chomp - PNI node that implements Perl chomp builtin function.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
