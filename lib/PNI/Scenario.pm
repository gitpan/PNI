package PNI::Scenario;
use parent 'PNI::Node';
use strict;
use PNI::Edge;
use PNI::Error;
use PNI::Node;

sub new {
    my $self = shift->SUPER::new;

    $self->add( edges => {} );
    $self->add( nodes => {} );
    $self->add( scenarios => {} );

    return $self
}

# return $edge : PNI::Edge
sub add_edge {
    my $self = shift;
    my $edge = PNI::Edge->new(@_)
      or return PNI::Error::unable_to_create_item;

    return $self->get('edges')->{ $edge->id } = $edge
}

# return $node : PNI::Node
sub add_node {
    my $self = shift;
    my $arg  = {@_};

    my $type = $arg->{type};

    # If type is not provided return a dummy node.
    if ( not defined $type ) {
        my $node = PNI::Node->new;

        return $self->get('nodes')->{ $node->id } = $node
    }

    my $node_class = "PNI::Node::$type";
    my $node_path  = "$node_class.pm";
    $node_path =~ s/::/\//g;

    eval { require $node_path }
      or return PNI::Error::unable_to_load_node;

    my $node = $node_class->new(@_)
      or return PNI::Error::unable_to_create_item;

    # At this point the node is created, so it can be initialized.
    $node->init
      or return PNI::Error::unable_to_init_node;

    # Set input data, if any
    while ( my ( $slot_name, $slot_data ) = each %{ $arg->{inputs} or {} } ) {
        $node->get_input($slot_name)->set_data($slot_data);
    }

    return $self->get('nodes')->{ $node->id } = $node
}

# return $scenario : PNI::Scenario
sub add_scenario {
    my $self     = shift;
    my $scenario = PNI::Scenario->new(@_)
      or return PNI::Error::unable_to_create_item;

    return $self->get('scenarios')->{ $scenario->id } = $scenario
}

sub del_edge {
    my $self = shift;
    my $edge = shift;

    $edge->get_source->del_edge($edge);
    $edge->get_target->del_edge;

    delete $self->get('edges')->{ $edge->id };
}

sub del_node {
    my $self = shift;
    my $node = shift;

    $self->del_edge($_) for $node->get_input_edges;
    $self->del_edge($_) for $node->get_output_edges;

    delete $self->get('nodes')->{ $node->id };
}

sub del_scenario {
    my $self     = shift;
    my $scenario = shift;

    # Clean up all items contained in the scenario

    # Deleting a node deletes also the edges connected to it.
    $scenario->del_node($_) for $scenario->get_nodes;

    # Deleting a scenario deletes also the nodes contained in it.
    $scenario->del_scenario($_) for $scenario->get_scenarios;

    delete $self->get('scenarios')->{ $scenario->id };
}

# return @edges : PNI::Edges
sub get_edges { values %{ shift->get('edges') } }

# return @nodes : PNI::Node
sub get_nodes { values %{ shift->get('nodes') } }

# return @scenarios : PNI::Scenario
sub get_scenarios { values %{ shift->get('scenarios') } }

sub task {

    # Here we go, this is one of the most important PNI subs.
    my $self = shift;

    my %has_run_task_of;

  RUN_TASKS:

    for my $node ( $self->get_nodes ) {

        # Discard nodes that run their task yet
        next if $has_run_task_of{$node};

        my $node_can_run_task = 1;

        # Nodes with no parents will skip this for loop
        # so their task will run before their children
        for my $parent_node ( $node->parents ) {

            # Wait until all parent nodes run.
            next RUN_TASKS if not exists $has_run_task_of{$parent_node};
        }

        # Retrieve slot data coming from input edges
        $_->task for ( $node->get_input_edges );

        # Ok, now it's time to run node task
        eval { $node->task } or do {

            # If node task fails raise error (without return)
            PNI::Error::unable_to_run_task;
        };

        # Remember that node has run its task
        $has_run_task_of{$node} = 1;
    }

    # Check if all tasks run
    for my $node ( $self->get_nodes ) {
        $has_run_task_of{$node} or goto RUN_TASKS;
    }

    # At this point all tasks are run so reset all slots "changed" flag.
    for my $node ( $self->get_nodes ) {
        $_->set( changed => 0 ) for ( $node->get_inputs, $node->get_outputs );
    }

    # Finally, run all sub scenarios tasks.
    $_->task for ( $self->get_scenarios );

    return 1
}

1
__END__

=head1 NAME

PNI::Scenario - is a set of nodes connected by edges

=head1 SYNOPSIS

    use PNI;

    my $scenario = PNI::root->add_scenario;

    my $sub_sccenario = $scenario->add_scenario;


    # You can call the constructor to get a scenario ...

    use PNI::Scenario;
    $standalone_scenario = PNI::Scenario->new;

    # ... but it will not belong to PNI hierarchy tree,
    # so its task method will not be called.

=head1 ATTRIBUTES

=head2 C<edges>

=head2 C<nodes>

=head2 C<scenarios>

=head1 METHODS

=head2 C<add_edge>

=head2 C<add_node>

    # Suppose 'Foo::Bar' is a valid PNI node type,
    # create a new PNI::Node::Foo::Bar
    my $node_foo_bar = $scenario->add_node( type => 'Foo::Bar' );

Adds a new node, given a PNI node type. 
L<PNI::Scenario> checks if PNI node type is valid, then initializes it.

    my $dummy_node = $scenario->add_node;

If arg type is not provided, creates a dummy node:
it can be useful for tests, and you can also decorate it later.

    $node = $scenario->add_node( 
        type => 'Perlfunc::Print',
        inputs => {
            list => [ 'Hello World!' ],
            do_print => 1,
        }
    );

An additional inputs arg, if provided, is used to set node inputs data before
running the first node task.

=head2 C<add_scenario>

    my $sub_scenario = $scenario->add_scenario;

=head2 C<del_edge>

=head2 C<del_node>

=head2 C<del_scenario>

=head2 C<get_edges>

=head2 C<get_nodes>

=head2 C<get_scenarios>

=head2 C<task>

=cut

