package PNI::Link;

use strict;
use warnings;

our $VERSION = '0.03';

my $source = {};
my $target = {};

sub connect_to_source {
    my $link = shift;
    my $source_node = shift;
    my $output_name = shift;
    $source->{$$link} = {
        node => $source_node,
        output_name => $output_name
    };
}

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

#-------------
# $link->source->{node}
# $link->source->{output_name}
#-------------
sub source {
    my $link = shift;
    return $source->{$$link}
}

#---------
# $link->target->{node}
#---------
sub target {
    my $link = shift;
    return $target->{$$link}
}

1;
__END__

=head1 NAME

PNI::Link

=head2 DESCRIPTION

This class represents connections between nodes. It links a node output to a node input, 
so at every PNI::RUN every node input is updated with the corresponding node output.

Don't use this module, call PNI::LINK instead.

=head2 SUBS

=item connect_to_source

Used to connect a link to its node source.

=item connect_to_target

Used to connect a link to its node target.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut


