package PNI::Node::Perlop::Eq;

use strict;
use warnings;

our $VERSION = '0.01';

our @ISA = ( 'PNI::Node' );

sub init {
    my $node = shift;
    
    $node->has_input( 'arg1' => undef );
    $node->has_input( 'arg2' => undef );
    $node->has_output( 'result' => undef );
}

sub task {
    my $node = shift;
    $node->output->{result} = $node->input->{arg1} eq $node->input->{arg2}
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Eq

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut


