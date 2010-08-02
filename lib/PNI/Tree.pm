package PNI::Tree;

use strict;
use warnings;

our $VERSION = '0.06';

use PNI::Link;
use PNI::Node;

my $attr = { link => {}, node => {} };
my $ID = 0;
my @hierarchy;

#----------------------------------------------------------------------------
# Usage      |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub add_node {

# TODO cambia l' interfaccia, il metodo non deve essere statico, ma del tipo $tree->add_node
    my $node_type = shift;
    my $arg       = {@_};
    return unless $node_type;
    my $node_class = 'PNI::Node::' . $node_type;
    my $node_path  = $node_class . '.pm';
    $node_path =~ s!::!/!g;

    #TODO prova l' eval con le graffe.
    #
    eval "require $node_class" or do { warn $@ }
      and return;

    $ID++;

    my $node_id = 'Node' . $ID;
    my $node = bless \$node_id, $node_class;
    $node->init();

    if ($arg) {

        # TODO testa per bene, e ancora di piu ... poi documenta sta feature .
        while ( my ( $input_name, $input_value ) = each %{$arg} ) {
            $node->set_input( $input_name => $input_value );
            # warn 'set_input ' . $input_name . ' = ' . $input_value . "\n";
        }
    }

    warn 'add node ' . $node->type . " [ $node_id ]\n";

    $attr->{node}->{$node_id} = $node;

    return $node;
}

#----------------------------------------------------------------------------
# Usage      |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
#sub del_node { }

#----------------------------------------------------------------------------
# Usage      |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub nodes {

# TODO cambia l' interfaccia, il metodo non deve essere statico, ma del tipo $tree->add_node
    return values %{ $attr->{node} };
}

#----------------------------------------------------------------------------
# Usage      |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub add_link {

    my ( $source_node, $target_node, $source_output_name, $target_input_name ) =
      @_;

    return 0
      unless defined $source_node
          and defined $target_node
          and defined $source_output_name
          and defined $target_input_name;

    $ID++;
    my $link_id = 'Link' . $ID;
    my $link = bless \$link_id, 'PNI::Link';

    $link->connect_to_target( $target_node => $target_input_name );
    $link->connect_to_source( $source_node => $source_output_name );

    $attr->{link}->{$link_id} = $link;

    warn 'add link from output '
      . $source_output_name
      . ' of node '
      . $source_node . "\n"
      . ' to input '
      . $target_input_name
      . ' of node '
      . $target_node . "\n";

    return $link;
}

#----------------------------------------------------------------------------
# Usage      |
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub del_link { }

#----------------------------------------------------------------------------
# Usage      | Called by PNI::RUN .
# Purpose    |
# Returns    |
#----------------------------------------------------------------------------
sub update_hierarchy {

    #warn 'update hierarchy' . "\n";
    @hierarchy = ();
    my $level   = -1;
    my $next    = $attr->{node};
    my $current = {};

    while ( values %{$next} ) {
        $current = $next;
        $next    = {};
        $level++;

        #warn 'level ' . $level . "\n";
        $hierarchy[$level] = [];

        for my $node ( values %{$current} ) {
            my $has_parent = 0;
            for my $input_name ( $node->input_names ) {

                #warn "looking at input $input_name of node $$node\n"; sleep 1;
                last if $has_parent;
                my $link;
                $link = $node->get_link_of_input($input_name);

                #warn "found link $link\n";
                $link or next;
                if ( my $source_node = $link->source->{node} ) {
                    $has_parent = 1 if $current->{$$source_node};
                }
            }
            if ($has_parent) {
                $next->{$$node} = $node;
            }
            else {
                push @{ $hierarchy[$level] }, $node;

 #warn 'node ' . $$node . ' ( ' . $node . ' ) ' . ' has level ' . $level . "\n";
            }
        }
    }
    return;
}

#----------------------------------------------------------------------------
# Usage      | Called by PNI::RUN .
# Purpose    | Call each node method task order by hierarchy level .
# Returns    |
#----------------------------------------------------------------------------
sub do_tasks {

    # TODO metti il controllo+test che puo essere chiamato solo da PNI::RUN

    my $node;
    my $node_id;

    my $input_name;

    #    my $output_name;

# reset reset_change_flag for all inputs and outputs
#for $node_id ( keys %{ $attr->{node} } ) {
#    for $input_name ( keys %{ $attr->{node}->{$node_id}->input } ) {
#warn "input name $input_name , " , $attr->{node}->{$node_id}->input->{$input_name} , "\n";
#$attr->{node}->{$node_id}->input->{$input_name}->reset_change_flag
#    }
#for $output_name ( keys %{ $attr->{node}->{$node_id}->output } ) {
#$attr->{node}->{$node_id}->output->{$output_name}->reset_change_flag
#}
#}

    #warn 'doing tasks at level 0' . "\n";
    for $node ( @{ $hierarchy[0] } ) {

        warn 'doing task at level 0 for node ' . $node . "\n";
        $node->task();
    }

    for ( my $level = 1 ; $level <= $#hierarchy ; $level++ ) {

        #warn "update values at level $level\n";

        for $node ( @{ $hierarchy[$level] } ) {
            for my $input_name ( $node->input_names ) {

                #warn "looking at input $input_name of node $$node\n";
                my $link = $node->get_link_of_input($input_name) or next;

                if ( my ( $source_node, $source_output_name ) =
                    ( $link->source->{node}, $link->source->{output_name} ) )
                {

#warn 'source_node ' . $source_node , "\n";
#warn 'input_name ' . $input_name , "\n";
#warn $node->input->{$input_name} . ' = ' . $source_node->output->{$source_output_name} . "\n";

                    #$node->input->{$input_name} =
                    #  $source_node->output->{$source_output_name};
                    $node->set_input( $input_name =>
                          $source_node->get_output($source_output_name) );
                }
            }
        }

        for $node ( @{ $hierarchy[$level] } ) {
        warn 'doing tasks at level ' . $level . ' for node ' , $node . "\n"; #sleep 1;
            $node->task();
        }
    }

    for my $node (nodes) {
        $node->reset_input_changes_flag;
    }

    return 1;
}

1;
__END__

=head1 NAME

PNI::Tree

=head1 SYNOPSIS

Don't use this module, it is a PNI internal.

=head1 DESCRIPTION

This class holds the PNI nodes and links hierarchy tree. At every PNI::RUN
it is updated the node hierarchy tree and then it is called the task method
of every node.

=head1 SUBROUTINES/METHODS

=over

=item add_node

Adds a PNI node to the hierarchy tree. It's called by the PNI::node method.
Returns a reference to the node created.

=item add_link

Adds a PNI link to the hierarchy tree. It's called by the PNI::link method.
Returns a reference to the new link created.

=back

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself .

=cut


