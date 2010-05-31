package PNI::Node::Perlop::Quote;

use strict;
use warnings;

our $VERSION = '0.01';

our @ISA = ( 'PNI::Node' );

sub init {
    my $node = shift;
    
    $node->has_input( 'input' => 0 );
    $node->has_output( 'output' => 0 );
}

sub task {
    my $node = shift;
    
    $node->output->{output} = qq{ $node->input->{input} };
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Quote

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

