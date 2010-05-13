package PNI::Tree;

use 5.010001;
use strict;
use warnings;

our $VERSION = '0.02';

use PNI::Node;

my $PNI = {
    LINK => {},
    NODE => {}
};
my $ID = 0;
my @hierarchy;

sub add_node {
    my $node_type = shift;
    return unless $node_type;
    my $args = { @_ };
    my $node_class = 'PNI::Node::' . $node_type;
    my $node_path = $node_class . '.pm'; $node_path =~ s!::!/!g;

    eval "require $node_class";
    #eval { require $node_path };

    if( $@ ) {
        warn $@;
        return
    };

    #    or { 
    #    warn 'add_node failed ' , $@ , "\n"; 
    #    return 
    #};
    #else {
        $ID++;
        my $node_id = 'Node'.$ID;
        my $node = bless \$node_id , $node_class;
        $node->init( $args );
        #warn 'add node ' . $node->type . " [ $node_id ]\n";
        $PNI->{NODE}->{$node_id} = $node;
        return $PNI->{NODE}->{$node_id}
        #}
}

sub add_link {

    my( $source_node , $target_node , $source_output_name , $target_input_name ) = @_;

    $ID++;
    my $link_id = 'Link'.$ID; # potrei anche mettere solo $ID
    my $link = bless \$link_id , 'PNI::Link';

    $link->connect_to_target( $target_node => $target_input_name  );
    $link->connect_to_source( $source_node => $source_output_name );

    $PNI->{LINK}->{$link_id} = $link;

    #warn 'add link from output ' . $source_output_name . ' of node ' . $source_node . "\n" . ' to input ' . $target_input_name . ' of node ' . $target_node . "\n";
}

sub del_node {}
sub del_link {}

sub update_hierarchy {

    #warn 'update hierarchy' . "\n";
    @hierarchy = ();
    my $level = -1;
    my $next = $PNI->{NODE};
    my $current = {};

    while( values %{ $next } ) {
        $current = $next;
        $next = {};
        $level++; 
        #warn 'level ' . $level . "\n";
        $hierarchy[ $level ] = [];

        for my $node ( values %{ $current } ) {
            my $has_parent = 0;
            for my $input_name ( $node->input_names ) {
                #warn "looking at input $input_name of node $$node\n"; sleep 1;
                last if $has_parent;
                my $link;
                $link = $node->get_link_of_input( $input_name );
                #warn "found link $link\n";
                $link or next;
                if( my $source_node = $link->source->{node} ) {
                    $has_parent = 1 if $current->{$$source_node};
                }
            }
            if( $has_parent ) {
                $next->{$$node} = $node;
            }
            else {
                push @{ $hierarchy[ $level ] } , $node;
                #warn 'node ' . $$node . ' ( ' . $node . ' ) ' . ' has level ' . $level . "\n";
            }
        }
    }
}

=pod

my $update_values_at_level = sub {
    my $level = shift;
    #warn 'update values at level ' . $level . "\n";
    #for( my $level = 1 ; $level <= $#hierarchy ; $level++ ) {
        for my $node ( @{ $hierarchy[$level] } ) {
            for my $input_name ( $node->input_names ) {
                #warn "looking at input $input_name of node $$node\n";
                my $link = $node->get_link_of_input( $input_name ) or next;

                if( my( $source_node , $source_output_name ) = ( $link->source->{node} , $link->source->{output_name} ) ) {
                    #warn 'source_node ' . $source_node , "\n";
                    #warn 'input_name ' . $input_name , "\n";
                    #warn $node->input->{$input_name} . ' = ' . $source_node->output->{$source_output_name} . "\n";
                    $node->input->{$input_name} = $source_node->output->{$source_output_name};
                }
            }
        }
        #}
};

=cut

sub do_tasks {
    my $node;
    #warn 'doing tasks at level 0' . "\n";
    for $node ( @{ $hierarchy[0] } ) {
        #warn 'doing task at level 0 for node ' . $node; sleep 1;
        $node->task()
    }

    for( my $level = 1 ; $level <= $#hierarchy ; $level++ ) {
        
        #warn "update values at level $level\n";

    #my $update_values_at_level = sub {
    #my $level = shift;
    #warn 'update values at level ' . $level . "\n";
    #for( my $level = 1 ; $level <= $#hierarchy ; $level++ ) {
        for $node ( @{ $hierarchy[$level] } ) {
            for my $input_name ( $node->input_names ) {
                #warn "looking at input $input_name of node $$node\n";
                my $link = $node->get_link_of_input( $input_name ) or next;

                if( my( $source_node , $source_output_name ) = ( $link->source->{node} , $link->source->{output_name} ) ) {
                    #warn 'source_node ' . $source_node , "\n";
                    #warn 'input_name ' . $input_name , "\n";
                    #warn $node->input->{$input_name} . ' = ' . $source_node->output->{$source_output_name} . "\n";
                    $node->input->{$input_name} = $source_node->output->{$source_output_name};
                }
            }
        }
        #}
#};

#warn 'doing tasks at level ' . $level . "\n"; sleep 1;
        for $node ( @{ $hierarchy[$level] } ) {
            $node->task()
        }
    }

}

1;
__END__

=head1 NAME

PNI::Tree

=head1 SYNOPSIS

Don't use this module, it is a PNI internal.

=head1 DESCRIPTION

This class holds the PNI nodes and links hierarchy tree.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut


