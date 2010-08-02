package PNI::Node::Jolly;

use strict;
use warnings;

our $VERSION = '0.01';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_input( 'task' => 0 );

    return 1;
}

sub task {
    my $node = shift;

    return 1 unless $node->get_input('task');

    &{$node->get_input('task')};

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Jolly - PNI generic node.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
