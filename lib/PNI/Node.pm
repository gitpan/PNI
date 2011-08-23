package PNI::Node;
use parent 'PNI::Item';
use strict;
use PNI::Error;
use PNI::Slot::In;
use PNI::Slot::Out;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

    $self->add( inputs        => {} );
    $self->add( inputs_order  => [] );
    $self->add( outputs       => {} );
    $self->add( outputs_order => [] );

    return $self;
}

# return $input
sub add_input {
    my $self       = shift;
    my $input_name = shift
      or return PNI::Error::missing_required_argument;

    my $input = PNI::Slot::In->new( node => $self, name => $input_name, @_ )
      or return PNI::Error::unable_to_create_item;

    $self->get('inputs')->{ $input->get_name } = $input;
    push @{ $self->get('inputs_order') }, $input_name;

    return $input;
}

# return $output
sub add_output {
    my $self        = shift;
    my $output_name = shift
      or return PNI::Error::missing_required_argument;

    my $output = PNI::Slot::Out->new( node => $self, name => $output_name, @_ )
      or return PNI::Error::unable_to_create_item;

    $self->get('outputs')->{ $output->get_name } = $output;
    push @{ $self->get('outputs_order') }, $output_name;

    return $output;
}

# return $input : PNI::Slot::In
sub get_input {
    my $self       = shift;
    my $input_name = shift
      or return PNI::Error::missing_required_argument;

    return $self->get('inputs')->{$input_name};
}

# return $output : PNI::Slot::Out
sub get_output {
    my $self        = shift;
    my $output_name = shift
      or return PNI::Error::missing_required_argument;

    return $self->get('outputs')->{$output_name};
}

# return @inputs : PNI::Slot::In
sub get_inputs { values %{ shift->get('inputs') } }

# return @outputs : PNI::Slot:Out
sub get_outputs { values %{ shift->get('outputs') } }

# return @input_edges : PNI::Edge
sub get_input_edges {
    grep { defined } map { $_->get_edge } shift->get_inputs;
}

# return @inputs : PNI::Slot::In
sub get_ordered_inputs {
    my $self = shift;
    return map { $self->get_input($_) } @{ $self->get('inputs_order') };

}

# return @outputs : PNI::Slot::Out
sub get_ordered_outputs {
    my $self = shift;
    return map { $self->get_output($_) } @{ $self->get('outputs_order') };

}

# return @output_edges
sub get_output_edges {
    grep { defined } map { $_->get_edges } shift->get_outputs;
}

# return $type
sub get_type {
    my $type = shift->type;
    $type =~ s/^PNI::Node:://;
    return $type;
}

# return undef
sub init { PNI::Error::unimplemented_abstract_method }

# return @nodes : PNI::Node
sub parents {
    map { $_->get_node } map { $_->get_source } shift->get_input_edges;
}

sub task { PNI::Error::unimplemented_abstract_method }

# return 1 or 0
#sub some_input_is_connected {
#    my $self = shift;
#    for my $input ( $self->get_inputs ) {
#        return 1 if $input->is_connected;
#    }
#    return 0;
#}

1;
__END__

=head1 NAME

PNI::Node - is a basic unit of code

=head1 SYNOPSIS

    my $empty_node = PNI::Node->new;
    my $in = $empty_node->add_input('in');
    my $out = $empty_node->add_output('out');

    my $node = PNI::Node->new( type => 'Foo::Bar' );
    print $node->get_type, "\n"; # prints PNI::Node::Foo::Bar

    $node->init;
    $node->task;


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

    my $in = $node->get_input('in')

=head2 C<get_input_edges>

=head2 C<get_ordered_inputs>

=head2 C<get_ordered_outputs>

=head2 C<get_output>

    my $out = $node->get_output('out')

=head2 C<get_output_edges>

=head2 C<get_outputs>

=head2 C<get_type>
    
    $node->get_type

Returns the PNI node type, which is the name of the node package minus the
leading 'PNI::Node::' string.

=head2 C<parents>

    my @parent_nodes = $node->parents

Returns the list of nodes which outputs are connected to node inputs.

=head2 C<some_input_is_connected>

=cut

