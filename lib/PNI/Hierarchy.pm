package PNI::Hierarchy;
use strict;
use warnings;
our $VERSION = '0.1';
use base 'PNI::Item';
use PNI::Link;
use PNI::Node;

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new();
    $self->add( nodes => {} );
    $self->add( links => {} );
    return $self;
}

sub add_node {
    my $self = shift;
    my $node = PNI::Node->new( @_, hierarchy => $self ) or return;
    $self->get('nodes')->{ $node->id } = $node;
    return $node;
}

sub add_link {
    my $self = shift;
    my $link = PNI::Link->new( @_, hierarchy => $self ) or return;
    $self->get('links')->{ $link->id } = $link;
    return $link;
}

sub del_node { }
sub del_link { }

sub get_node {
    my $self    = shift;
    my $node_id = shift or return;
    my $node    = $self->get('nodes')->{$node_id} or return;
    return $node;
}

sub get_link {
    my $self    = shift;
    my $link_id = shift or return;
    my $link    = $self->get('links')->{$link_id};
    defined $link or return;
    return $link;
}

sub get_nodes {
    return values %{ shift->get('nodes') };
}

sub get_links {
    return values %{ shift->get('links') };
}

sub task {
    my $self = shift;

    my %parents_of;
    for my $node ( $self->get_nodes ) {
        $parents_of{$node} = [];
        for my $link ( $node->get_input_links ) {
            push @{ $parents_of{$node} }, $link->get_source_node;
        }
    }

    my %has_run_task_of;

  RUN_TASKS:
    for my $node ( $self->get_nodes ) {
        next if $has_run_task_of{$node};

        # wait until all parent nodes run
        my $node_can_run_task = 1;
        for my $parent_node ( @{ $parents_of{$node} } ) {
            if ( $has_run_task_of{$parent_node} ) {

            }
            else { $node_can_run_task = 0; }
        }

        if ($node_can_run_task) {

            # ok, now it's time to run node task
            eval { $node->task } or warn "unable to run $node task";
            $has_run_task_of{$node} = 1;

            # after node task, trigger all its output links
            for my $link ( $node->get_output_links ) {
                $link->task;
            }
        }
    }

    # check if all tasks run
    for my $node ( $self->get_nodes ) {
        if   ( $has_run_task_of{$node} ) { }
        else                             { goto RUN_TASKS; }
    }

    return 1;
}

1;

