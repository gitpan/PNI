package PNI::Node::Perlfunc::Ref;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'expr' => ' ' );

    $node->add_output( 'type' => '' );

    return 1;
}

sub task {
    my $node = shift;

    return unless defined $node->get_input('expr');

    $node->set_output( type => ref( $node->get_input('expr') ) );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Ref - PNI node that implements Perl ref builtin function.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
