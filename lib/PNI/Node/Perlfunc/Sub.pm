package PNI::Node::Perlfunc::Sub;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'code_rows' => [] );
    $node->add_input( 'update'    => 0 );

    $node->add_output( 'code_ref' => sub { } );

    return 1;
}

sub task {
    my $node = shift;

    return 1 unless $node->get_input('update');

    my $code = join ' ', @{ $node->get_input('code_rows') };

    my $code_ref = eval "sub { $code }";

    $node->set_output( code_ref => $code_ref );

    $node->set_input( 'update' => 0 );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Sub - PNI node that implements Perl subroutine definition.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
