package PNI::YAML;
our $VERSION = '0.0.1';
use strict;
use warnings;
use YAML;

use Data::Dumper;

###
#
# meglio lasciare questo in un modulo a parte per documentare bene e nel posto giusto che PNI usa YAML e
#
# chissà, in futuro potrei usare anche PNI::XML
#

sub LOAD {
    my $path = shift;

    my $PNI = YAML::LoadFile( $path );

    print STDOUT Dumper( $PNI ); #exit;

    for my $virtual_node_id ( keys %{ $PNI->{NODES} } ) {
        
        my $node_class = $PNI->{NODES}->{$virtual_node_id}->{node_class};
        my $node = PNI::NODE $node_class;


        print STDOUT $PNI->{NODES}->{$virtual_node_id};
        for my $input_name ( keys %{ $PNI->{NODES}->{$virtual_node_id}->{input} } ) {
            $node->input->{$input_name} = $PNI->{NODES}->{$virtual_node_id}->{input}->{$input_name}
        }
        

        # lo faccio alla fine altrimenti sovrascrivo i dati
        $PNI->{NODES}->{$virtual_node_id} = $node;
    }

    #print STDOUT join( ' ' , @{$_} ) , "\n" for @LINKS;
    for my $link_params ( @{ $PNI->{LINKS} } ) {
        my $virtual_source_node_id = $link_params->{source_node_id};
        my $virtual_target_node_id = $link_params->{target_node_id};
        my $output_name            = $link_params->{output_name};
        my $input_name             = $link_params->{input_name};
        PNI::LINK $PNI->{NODES}->{$virtual_source_node_id} => $PNI->{NODES}->{$virtual_target_node_id} , $output_name => $input_name
    }
}

1;
__END__

