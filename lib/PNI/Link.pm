package PNI::Link;

use 5.010001;
use strict;
use warnings;

our $VERSION = '0.01';

my $source = {};
my $target = {};

sub connect_to_target {
    my $link = shift;
    my $target_node = shift;
    my $input_name = shift;
    $target->{$$link} = {
        node => $target_node,
        input_name => $input_name
    };
    $target_node->has_input_link( $link => $input_name );
}

sub connect_to_source {
    my $link = shift;
    my $source_node = shift;
    my $output_name = shift;
    $source->{$$link} = {
        node => $source_node,
        output_name => $output_name
    };
}

#---------
# $link->target->{node}
#---------
sub target {
    my $link = shift;
    return $target->{$$link}
}

#-------------
# $link->source->{node}
# $link->source->{output_name}
#-------------
sub source {
    my $link = shift;
    return $source->{$$link}
}

1;
__END__

=head1 NAME

PNI::Link

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut


