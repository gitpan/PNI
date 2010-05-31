package PNI::Node::Perlfunc::Print;

use strict;
use warnings;

our $VERSION = '0.01';

our @ISA = ( 'PNI::Node' );

sub init {
    my $node = shift;
    #$node->has_input( 'message' => undef );
    my $message = $node->has_input( 'message' => 'hello' );
    $message->set( 'ciaooo' );
    $node->has_input( 'do_print' => 0 );
}

sub task {
    my $node = shift;
    return unless $node->input->{do_print}; 
    return unless defined $node->input->{message};
    
    print STDOUT $node->input->{message}->get();
}

1;
__END__

=head1

PNI::Node::Perlfunc::Print;

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

