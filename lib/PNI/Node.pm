package PNI::Node;
use strict;
use warnings;
our $VERSION = '0.0.1';

sub init { die }
sub task { die }

my $input  = {};
my $output = {};

my $input_link = {};

#----------
# $node->input->{foo}
# ---------
sub input { 
    my $node = shift; 
    return $input->{$$node}
    # if node has no input ...
    ||
    # return an empty hash so $node->input->{missing_input_name}
    # is undef instead of raising a runtime error.
    {}
}

#----------
# $node->output->{bar}
# ---------
sub output { 
    my $node = shift; 
    return $output->{$$node}
    # if node has no output ...
    ||
    # return an empty hash so $node->output->{missing_output_name}
    # is undef instead of raising a runtime error.
    {}
}

sub has_input {
    my $node        = shift;
    my $input_name  = shift;
    my $input_value = shift;

    return unless defined $input_name
        and defined $input_value;
    #warn "node $$node has input $input_name\n";
    $input->{$$node}->{$input_name} = $input_value;
}

sub has_output {
    my $node         = shift;
    my $output_name  = shift;
    
    return unless defined $output_name;
    #warn "node $$node has output $output_name\n";
    $output->{$$node}->{$output_name} = $output_value;
}

#--------
# get input names
#--------
sub input_names {
    my $node = shift;
    return keys %{ $input->{$$node} }
}

sub get_link_of_input {
    my $node = shift;
    my $input_name = shift;
    return $input_link->{$$node}->{$input_name}
}

sub has_input_link {
    my $node = shift;
    my $link = shift;
    my $input_name = shift;
    $input_link->{$$node}->{$input_name} = $link;
}

#-------
# get node's PNI type
#-------
sub type {
    my $node = shift;
    my $node_type = ref $node;
    $node_type =~ s/^PNI::Node:://;
    return $node_type
}

=pod

$node->has_input { };

=cut

sub DESTROY {
my $node = shift;
warn 'del node ' . $node->type . " [ $$node ]\n";
delete $input->{$$node}; delete $output->{$$node};
}

1;
__END__

=head1 NAME

PNI::Node

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

