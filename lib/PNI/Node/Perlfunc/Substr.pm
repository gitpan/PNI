package PNI::Node::Perlfunc::Substr;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'in'          => '' );
    $node->add_input( 'offset'      => 0 );
    $node->add_input( 'length'      => 0 );
    $node->add_input( 'replacement' => '' );

    $node->add_output( 'out' => '' );

    return 1;
}

sub task {
    my $node = shift;

    return unless $node->get_input('in')

          and defined $node->get_input('offset');

    $node->set_output(
        out => substr( $node->get_input('in'), $node->get_input('offset') ) )

      unless defined $node->get_input('length')
          and defined $node->get_input('replacement');

    return unless defined $node->get_input('length');

    $node->set_output(
        out => substr(
            $node->get_input('in'), $node->get_input('offset'),
            $node->get_input('length')
        )
      )

      unless defined $node->get_input('replacement');

    $node->set_output(
        out => substr(
            $node->get_input('in'),     $node->get_input('offset'),
            $node->get_input('length'), $node->get_input('replacement')
        )
    );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Substr - PNI node that implements Perl substr builtin function.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
