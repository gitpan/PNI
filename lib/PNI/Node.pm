package PNI::Node;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Item';
use PNI::Error 0.15;
use PNI::Slot::In 0.15;
use PNI::Slot::Out 0.15;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add( inputs        => {} );
    $self->add( inputs_order  => [] );
    $self->add( outputs       => {} );
    $self->add( outputs_order => [] );

    return $self;
}

# return $input
sub add_input {
    my $self = shift;
    my $input_name = shift or return PNI::Error::missing_required_argument;

    my $input = PNI::Slot::In->new( node => $self, name => $input_name, @_ )
      or return PNI::Error::unable_to_create_item;

    $self->get('inputs')->{ $input->get_name } = $input;
    push @{ $self->get('inputs_order') }, $input_name;

    return $input;
}

# return $output
sub add_output {
    my $self = shift;
    my $output_name = shift or return PNI::Error::missing_required_argument;

    my $output = PNI::Slot::Out->new( node => $self, name => $output_name, @_ )
      or return PNI::Error::unable_to_create_item;

    $self->get('outputs')->{ $output->get_name } = $output;
    push @{ $self->get('outputs_order') }, $output_name;

    return $output;
}

# TODO consider to deprecate this
# return 1
#sub check_inputs {
#    my $self = shift;
#
#    for my $input ( $self->get_inputs ) {
#        if( my $data = $input->get_data ) {
#            $input->check_data( $data ) or return PNI::Error::check_data_failed;
#        }
#    }
#
#    return 1;
#}

# return $input
sub get_input {
    my $self = shift;
    my $input_name = shift or return PNI::Error::missing_required_argument;
    return $self->get('inputs')->{$input_name};
}

# return $output
sub get_output {
    my $self = shift;
    my $output_name = shift or return PNI::Error::missing_required_argument;
    return $self->get('outputs')->{$output_name};
}

# return @inputs
sub get_inputs { return values %{ shift->get('inputs') }; }

# return @outputs
sub get_outputs { return values %{ shift->get('outputs') }; }

# return @input_edges
sub get_input_edges {
    my $self        = shift;
    my @input_edges = ();
    for my $input ( $self->get_inputs ) {
        my $edge = $input->get_edge;
        if ( defined $edge ) {
            push @input_edges, $edge;
        }
    }
    return @input_edges;
}

# return @inputs
sub get_ordered_inputs {
    my $self = shift;
    my @inputs;
    for my $input_name ( @{ $self->get('inputs_order') } ) {
        push @inputs, $self->get_input($input_name);
    }
    return @inputs;
}

# return @outputs
sub get_ordered_outputs {
    my $self = shift;
    my @outputs;
    for my $output_name ( @{ $self->get('outputs_order') } ) {
        push @outputs, $self->get_output($output_name);
    }
    return @outputs;
}

# return @output_edges
sub get_output_edges {
    my $self         = shift;
    my @output_edges = ();
    for my $output ( $self->get_outputs ) {
        my @edges = $output->get_edges;
        if (@edges) {
            push @output_edges, @edges;
        }
    }
    return @output_edges;
}

# return $type
sub get_type {
    my $type = shift->type;
    $type =~ s/^PNI::Node:://;
    return $type;
}

# return undef
sub init { return PNI::Error::unimplemented_abstract_method; }

# return undef
sub task { return PNI::Error::unimplemented_abstract_method; }

# return 1 or 0
sub some_input_is_connected {
    my $self = shift;
    for my $input ( $self->get_inputs ) {
        return 1 if $input->is_connected;
    }
    return 0;
}

1;
__END__

=head1 NAME

PNI::Node - is a basic unit of code


=head1 DESCRIPTION

This is an abstract class: it has an init method called after creation and a task method called at every PNI::task.

=head1 ATTRIBUTES

=head2 C<inputs>

=head2 C<outputs>

=head1 ABSTRACT METHODS

=head2 C<init>

=head2 C<task>

=head1 METHODS

=head2 C<add_input>

my $in = $node->add_input('in');

Creates a new L<PNI::Slot::In>.

=head2 C<add_output>

my $out = $node->add_output('out');

Creates a new L<PNI::Slot::Out>.

=head2 C<get_input>

=head2 C<get_inputs>

=head2 C<get_input_edges>

=head2 C<get_ordered_inputs>

=head2 C<get_ordered_outputs>

=head2 C<get_output>

=head2 C<get_output_edges>

=head2 C<get_outputs>

=head2 C<get_type>

=head2 C<some_input_is_connected>

=head1 SEE ALSO

L<PNI::Node::Perlfunc>

L<PNI::Node::Perlop>

L<PNI::Node::Perlvar>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
