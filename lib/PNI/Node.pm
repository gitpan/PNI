package PNI::Node;

use strict;
use warnings;

our $VERSION = '0.06';

use Carp;

#sub info { return {} }
# posso fare sub info; ?

sub init { die }
sub task { die }

my $attr = {
    input              => {},
    output             => {},
    input_link         => {},
    inputs_are_changed => {}
};

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub add_input {

    my $node        = shift;
    my $input_name  = shift;
    my $input_value = shift;

    return
      unless defined $input_name
          and defined $input_value
          and not exists $attr->{input}->{$$node}->{$input_name};

    $attr->{input}->{$$node}->{$input_name} = $input_value;

    return 1;
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub del_input;

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub get_input {
    my $node = shift
      or carp 'undefined node';
    my $input_name = shift
      or carp 'missing input name parameter';

    exists $attr->{input}->{$$node}->{$input_name}
      or carp "input $input_name is not defined for node $node";

    return $attr->{input}->{$$node}->{$input_name};
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub set_input {
    my $node       = shift;
    my $input_name = shift;

    my $input_value = shift;

    return
      unless defined $input_name
          and defined $input_value
          and exists $attr->{input}->{$$node}->{$input_name};

    $attr->{input}->{$$node}->{$input_name} = $input_value;
    $attr->{inputs_are_changed}->{$$node} = 1;

    return 1;
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub add_output {
    my $node         = shift;
    my $output_name  = shift;
    my $output_value = shift;

    return
      unless defined $output_name
          and defined $output_value
          and not exists $attr->{output}->{$$node}->{$output_name};

    $attr->{output}->{$$node}->{$output_name} = $output_value;

    return 1;
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub del_output;

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub get_output {
    my $node        = shift;
    my $output_name = shift;

    return unless exists $attr->{output}->{$$node}->{$output_name};

    return $attr->{output}->{$$node}->{$output_name};
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub set_output {
    my $node         = shift;
    my $output_name  = shift;
    my $output_value = shift;

    return
      unless defined $output_name
          and defined $output_value
          and exists $attr->{output}->{$$node}->{$output_name};

    $attr->{output}->{$$node}->{$output_name} = $output_value;

    return 1;
}

#----------------------------------------------------------------------------
# Usage      | $node->add_input_link( $input_link => $input_name );
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub add_input_link {
    my $node       = shift;
    my $input_link = shift;
    my $input_name = shift;

    return 0
      unless defined $input_link
          and defined $input_name;

    $attr->{input_link}->{$$node}->{$input_name} = $input_link;
    return 1;
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub del_input_link;

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub get_link_of_input {

    # TODO sarebbe da cambiare in get_input_link
    my $node       = shift;
    my $input_name = shift;

    return unless exists $attr->{input_link}->{$$node}->{$input_name};

    return $attr->{input_link}->{$$node}->{$input_name};
}

#----------------------------------------------------------------------------
# Usage      | $node->inputs_are_changed
# Purpose    |
# Returns    | 1 or 0
#----------------------------------------------------------------------------
sub inputs_are_changed {
    my $node = shift;

    return 0
      if not exists $attr->{inputs_are_changed}->{$$node}
          or not defined $attr->{inputs_are_changed}->{$$node};
    return $attr->{inputs_are_changed}->{$$node};
}

#----------------------------------------------------------------------------
# Usage      | $node->reset_input_changes_flag
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub reset_input_changes_flag {
    my $node = shift;

    return 0
      if not exists $attr->{inputs_are_changed}->{$$node}
          or not defined $attr->{inputs_are_changed}->{$$node};

    $attr->{inputs_are_changed}->{$$node} = 1;
    return 1;
}

#----------------------------------------------------------------------------
# Usage      | $node->input_names
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub input_names {
    my $node = shift;

    return unless exists $attr->{input}->{$$node};

    return keys %{ $attr->{input}->{$$node} };
}

#----------------------------------------------------------------------------
# Usage      | $node->output_names
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub output_names {
    my $node = shift;

    return unless exists $attr->{output}->{$$node};

    return keys %{ $attr->{output}->{$$node} };
}

#----------------------------------------------------------------------------
# Usage      |
#            |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub type {
    my $node      = shift;
    my $node_type = ref $node;
    $node_type =~ s/^PNI::Node:://;
    return $node_type;
}

sub DESTROY {
    my $node = shift;

    #warn 'del node ' . $node->type . " [ $$node ]\n";
    delete $attr->{input}->{$$node};
    delete $attr->{output}->{$$node};

    return 1;
}

1;
__END__

=head1 NAME

PNI::Node

=head1 DESCRIPTION

This is the base class every PNI::Node must inherit from. 
It declares two abstract methods: init and task. 

Don't use this module, call PNI::NODE instead and use the reference it returns.

=head1 SUBROUTINES/METHODS

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
it under the same terms as Perl itself .

=cut

