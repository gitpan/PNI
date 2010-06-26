package PNI::Node;

use strict;
use warnings;

our $VERSION = '0.05';

#sub info { return {} }
# posso fare sub info; ?

sub init { die }
sub task { die }

my $input  = {};
my $output = {};

my $input_link = {};

# per ora lo lascio per non creare errori, ma, è DEPRECATO
sub input {
    my $node = shift;
    return $input->{$$node}

      # if node has no input ...
      ||

      # return an empty hash so $node->input->{missing_input_name}
      # is undef instead of raising a runtime error.
      {};
}

# per ora lo lascio per non creare errori, ma, è DEPRECATO
sub output {
    my $node = shift;
    return $output->{$$node}

      # if node has no output ...
      ||

      # return an empty hash so $node->output->{missing_output_name}
      # is undef instead of raising a runtime error.
      {};
}

sub add_input {

    my $node        = shift;
    my $input_name  = shift;
    my $input_value = shift;

    return
      unless defined $input_name
          and defined $input_value
          and not exists $input->{$$node}->{$input_name};

    $input->{$$node}->{$input_name} = $input_value;

    return;
}

sub add_output {
    my $node         = shift;
    my $output_name  = shift;
    my $output_value = shift;

    return
      unless defined $output_name
          and defined $output_value
          and not exists $output->{$$node}->{$output_name};

    $output->{$$node}->{$output_name} = $output_value;

    return;
}

sub del_input;    # controlla che esista altrimenti return
sub del_output;

sub get_input {
    my $node       = shift;
    my $input_name = shift;

    return unless exists $input->{$$node}->{$input_name};

    return $input->{$$node}->{$input_name};
}

sub get_output {
    my $node        = shift;
    my $output_name = shift;

    return unless exists $output->{$$node}->{$output_name};

    return $output->{$$node}->{$output_name};
}

sub set_input {
    my $node       = shift;
    my $input_name = shift;

    my $input_value = shift;

    return
      unless defined $input_name
          and defined $input_value
          and exists $input->{$$node}->{$input_name};

    $input->{$$node}->{$input_name} = $input_value;

    return;
}

sub set_output {
    my $node         = shift;
    my $output_name  = shift;
    my $output_value = shift;

    return
      unless defined $output_name
          and defined $output_value
          and exists $output->{$$node}->{$output_name};

    $output->{$$node}->{$output_name} = $output_value;

    return;
}

sub input_names {
    my $node = shift;

    return unless exists $input->{$$node};

    return keys %{ $input->{$$node} };
}

sub get_link_of_input {
    my $node       = shift;
    my $input_name = shift;

    return unless exists $input_link->{$$node}->{$input_name};

    return $input_link->{$$node}->{$input_name};
}

sub del_input_link;
sub add_input_link;

# per ora lo lascio per non creare errori, ma, è DEPRECATO
sub has_input_link {
    my $node       = shift;
    my $link       = shift;
    my $input_name = shift;
    $input_link->{$$node}->{$input_name} = $link;
}

sub type {
    my $node      = shift;
    my $node_type = ref $node;
    $node_type =~ s/^PNI::Node:://;
    return $node_type;
}

sub DESTROY {
    my $node = shift;

    #warn 'del node ' . $node->type . " [ $$node ]\n";
    delete $input->{$$node};
    delete $output->{$$node};
}

1;
__END__

=head1 NAME

PNI::Node

=head1 DESCRIPTION

This is the base class every PNI::Node must inherit from. 
It declares two abstract methods: init and task. 

Don't use this module, call PNI::NODE instead and use the reference it returns.

=head2 SUBS

=over

=item add_input

Declares node has the given input.

=item add_output

Declares node has the given output.

=item type

Returns the PNI node type, i.e. package name minus PNI::Node .

=back

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

