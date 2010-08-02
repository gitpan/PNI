package PNI::Node::Perlvar::Process_id;

use strict;
use warnings;

our $VERSION = '0.05';

our @ISA = ('PNI::Node');

sub init {
    my $node = shift;

    $node->add_output( 'PID' => 0 );

    return 1;
}

sub task {
    my $node = shift;

    $node->set_output( PID => $$ );

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node::Perlvar::Process_id - PNI node that returns Perl $$ var.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
