package PNI::Node;
our $VERSION = '0.0.1';
use strict;
use warnings;

sub init { die }
sub task { die }

my $input  = {};
my $output = {};

sub input {
    my $node = shift;
    #TODO invece di fare cosi dovrei inizializzare l' input, devono essere tutti
    #riferimenti
    return $input->{$$node} || {};
}

sub output {
    my $node = shift;
    #TODO invece di fare cosi dovrei inizializzare l' output, devono essere tutti
    #riferimenti
    return $output->{$$node} || {};
}

sub has_input { 
    my $node        = shift;
    my $input_name  = shift;
    my $input_value = shift;
    warn "node $$node has input $input_name\n";
    $input->{$$node}->{$input_name} = $input_value;
}

sub has_output {
    my $node         = shift;
    my $output_name  = shift;
    my $output_value = shift;
    warn "node $$node has output $output_name\n";
    $output->{$$node}->{$output_name} = $output_value;
}

sub DESTROY {
warn "fill me :P";
}

1;
__END__

=head1 NAME

PNI::Node

=head1 DESCRIPTION

=head1 AUTHOR

Gianluca Casati

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

PNI

=cut

