package PNI;
our $VERSION = '0.0.1';
use 5.008;
use strict;
use warnings;
use Time::HiRes( 'usleep' );
use PNI::Node;
use PNI::Slot;

#sub NODE;
#sub LINK;

my $NODE = {};
my $LINK = {};
my $SLOT = {};

my $id = 0;
my @hierarchy;

my $update_hierarchy = sub {
    #warn 'update hierarchy' . "\n";
    @hierarchy = ();
    my $level = -1;
    my $next = $NODE;
    my $current = {};

    while( values %{ $next } ) {
        $current = $next;
        $next = {};
        $level++; 
        #warn 'level ' . $level . "\n";
        $hierarchy[ $level ] = [];

        for my $node ( values %{ $current } ) {
            my $has_parent = 0;
            for my $input_name ( keys %{ $node->input } ) {
                #warn "looking at input $input_name of node $$node\n";
                last if $has_parent;
                if( my $source_node = $LINK->{ $$node . $input_name }->[0] ) {
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
};

my $update_values_at_level = sub {
    my $level = shift;
    #warn 'update values at level ' . $level . "\n";
    for( my $level = 1 ; $level <= $#hierarchy ; $level++ ) {
        for my $node ( @{ $hierarchy[$level] } ) {
            for my $input_name ( keys %{ $node->input } ) {
                #warn "looking at input $input_name of node $$node\n";
                if( my( $source_node , $source_output_name ) = @{ $LINK->{ $$node . $input_name } } ) {
                    $node->input->{$input_name} = $source_node->output->{$source_output_name};
                }
            }
        }
    }
};

my $do_tasks = sub {
    #warn 'doing tasks at level 0' . "\n";
    for my $node ( @{ $hierarchy[0] } ) {
        $node->task()
    }
    for( my $level = 1 ; $level <= $#hierarchy ; $level++ ) {
        #warn 'doing tasks at level ' . $level . "\n";
        &$update_values_at_level( $level );
        for my $node ( @{ $hierarchy[$level] } ) {
            $node->task()
        }
    }
};

sub NODE {
    my $node_type = shift;
    my $node_class = 'PNI::Node::' . $node_type;
    my $node_path = $node_class . '.pm'; $node_path =~ s!::!/!g;

    eval { require $node_path };

    if( $@ ) { 
        warn $@; 
        return 
    }
    else {
        $id++;
        my $node_id = 'Node'.$id;
        $NODE->{$node_id} = bless \$node_id , $node_class;
        $NODE->{$node_id}->init();
        warn 'PNI::NODE ' . $node_type . '(' . $node_id . ')' . "\n";
        return $NODE->{$node_id}
    }
}

sub LINK {
    # TODO aggiungi un controllo sui cammini chiusi, non deve esistere un cammino
    # piu lungo del numero di nodi presenti altrimenti sto looppando.

    # TODO aggiungi il controllo sul tipo di dati dell' input e dell' output,
    # una cosa del tipo
    #
    # return unless ref $source_node->{$source_output_name} eq ref
    # $source_node->{$target_input_name}
    #
    # per ora lascia solo il warn, da togliere non appena implementato il
    # controllo.
    my( $source_node , $target_node , $source_output_name , $target_input_name ) = @_;

    eval { $LINK->{ $$target_node . $target_input_name } = [ $source_node , $source_output_name ] };
    if( $@ ) { 
        warn $@; 
        return 
    }
    warn 'PNI::LINK ' . $source_node . ' => ' . $target_node . ' , ' . $source_output_name . ' => ' . $target_input_name . "\n";
}

#TODO usa delete $NODE->{$node_id}

sub SLOT {
    my $slot_type = shift;
    my $slot_class = 'PNI::Slot::' . $slot_type;
    my $slot_path = $slot_class . '.pm'; $slot_path =~ s!::!/!g;
    eval{ require $slot_path };

    if( $@ ) {
        warn $@; 
        return
    } else {
        $id++;
        my $slot_id = 'Slot'.$id;
        $SLOT->{$slot_id} = bless \$slot_id , $slot_class;
        return $SLOT->{$slot_id}
    }
}

sub RUN { 
    &$update_hierarchy;
    &$do_tasks;
    usleep( 1 );
}

sub LOOP { &RUN while 1 }

1;
__END__

=head1 NAME

PNI - Perl Node Interface

=head1 SYNOPSIS

use PNI;

my $node1 = PNI::NODE 'Template'; 
my $print = PNI::NODE 'Perlfunc::Print'; 

PNI::LINK $node1 => $print , 'output1' => 'message';

PNI::RUN;

=head1 DESCRIPTION

=head1 AUTHOR

Gianluca Casati

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

PNI::Node

=cut

