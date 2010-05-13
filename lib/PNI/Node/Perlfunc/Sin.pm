package PNI::Node::Perlfunc::Sin;

use 5.010001;
use strict;
use warnings;

our $VERSION = '0.01';

our @ISA = ( 'PNI::Node' );

sub init {
    my $node = shift;
    $node->has_input( 'radians' );
    $node->has_output( 'output' );
}

sub task {
    my $node = shift;
    return unless defined $node->input->{radians};
    $node->output->{output} = sin( $node->input->{radians} );
}

1;
__END__

=head1 NAME 

PNI::Node::Perlfunc::Sin;

=head1 SEE ALSO

PNI::Node::Perlfunc::Cos;

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

