package PNI::Scenario;
use strict;
use base 'PNI::Node';
use PNI::Edge;
use PNI::Error;
use PNI::File;
use PNI::Node;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add( edges => {} );

    # $file is not required but should be a PNI::File
    my $file = $arg->{file};
    if ( defined $file and not $file->isa('PNI::File') ) {
        return PNI::Error::invalid_argument_type;
    }
    $self->add( file => $file );

    $self->add( nodes => {} );

    $self->add( scenarios => {} );

    return $self;
}

# return $edge: PNI::Edge
sub add_edge {
    my $self = shift;
    my $edge = PNI::Edge->new(@_) or return PNI::Error::unable_to_create_item;

    return $self->get('edges')->{ $edge->id } = $edge;
}

# return $node: PNI::Node
sub add_node {
    my $self = shift;
    my $arg  = {@_};

    # if arg type is not provided return a dummy node
    my $type = $arg->{type} or return PNI::Node->new;

    my $node_class = "PNI::Node::$type";
    my $node_path  = "$node_class.pm";
    $node_path =~ s/::/\//g;
    eval { require $node_path; } or return PNI::Error::unable_to_load_node;
    my $node = $node_class->new(@_) or return PNI::Error::unable_to_create_item;

    # at this point the node is created, so you can initialize it
    $node->init or return PNI::Error::unable_to_init_node;

    my $inputs = $arg->{inputs};
    if ( defined $inputs ) {
        while ( my ( $slot_name, $slot_data ) = each %{$inputs} ) {
            $node->get_input($slot_name)->set_data($slot_data);
        }
    }

    return $self->get('nodes')->{ $node->id } = $node;
}

# return 1
sub add_scenario {
    my $self     = shift;
    my $scenario = PNI::Scenario->new(@_)
      or return PNI::Error::unable_to_create_item;

    return $self->get('scenarios')->{ $scenario->id } = $scenario;
}

# return @nodes: PNI::Node
sub get_nodes { values %{ shift->get('nodes') } }

# return 1
sub task {

    # Here we go, this is one of the most important PNI subs
    my $self = shift;

    # Start with nodes without a parent
    my %parents_of;
    for my $node ( $self->get_nodes ) {
        $parents_of{$node} =
          [ map { $_->get_source_node } $node->get_input_edges ];
    }

    my %has_run_task_of;

  RUN_TASKS:
    for my $node ( $self->get_nodes ) {

        # discard nodes that run their task yet
        next if $has_run_task_of{$node};

        # wait until all parent nodes run
        my $node_can_run_task = 1;
        for my $parent_node ( @{ $parents_of{$node} } ) {
            if   ( $has_run_task_of{$parent_node} ) { }
            else                                    { $node_can_run_task = 0; }
        }

        if ($node_can_run_task) {

            # retrieve slot data coming from input edges
            for my $edge ( $node->get_input_edges ) {
                $edge->get_target->set_data( $edge->get_source->get_data );
            }

            # ok, now it's time to run node task
            ######### TODO consider to deprecate this ## $node->check_inputs and
            eval { $node->task } or do {

                # if node task fails raise error (without return)
                PNI::Error::unable_to_run_task;
            };

            $has_run_task_of{$node} = 1;
        }
    }

    # check if all tasks run
    for my $node ( $self->get_nodes ) {
        if   ( $has_run_task_of{$node} ) { }
        ### TODO apply Marcos patches !!!!
        else                             { goto RUN_TASKS; }
    }

    # at this point all tasks are run so reset all slots "changed" flag
    for my $node ( $self->get_nodes ) {
        for my $slot ( $node->get_inputs, $node->get_outputs ) {
            $slot->set( changed => 0 );
        }
    }

    return 1;
}

1;
__END__

################################
# TODO consider rename this package as PNI::Tree

=head1 NAME

PNI::Scenario - is a persistent PNI graph

=head1 METHODS

=head2 C<add_edge>

=head2 C<add_node>

Adds a new node, given a PNI node type. 
L<PNI::Scenario> checks if PNI node type is valid, then initializes it.

    # if arg type is not provided, creates a dummy node:
    my $dummy_node = $scenario->add_node;
    # it can be useful for tests, and you can also decorate it later.

    # suppose 'Foo::Bar' is a valid PNI node type,
    # this creates a PNI::Node::Foo::Bar.
    my $node_foo = $scenario->add_node( type => 'Foo::Bar' );

    # an additional inputs => {} arg, is used to set node inputs data
    # before running the first node task.
    $node = $scenario->add_node( 
        type => 'Perlfunc::Print',
        inputs => {
            list => [ 'Hello World!' ],
            do_print => 1,
        }
    );

=head2 C<add_scenario>

=head2 C<get_nodes>

=head2 C<task>

=cut

