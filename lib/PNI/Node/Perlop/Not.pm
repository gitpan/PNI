package PNI::Node::Perlop::Not;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'in' => 0 );

    $node->add_output( 'out' => 0 );

    return 1;
}

sub task {
    my $node = shift;

    if ( not $node->get_input('in') ) {

        $node->set_output( out => 1 );

    }
    else {

        $node->set_output( out => 0 );

    }

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Not - PNI node that implements Perl not operator

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
