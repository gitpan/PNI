use strict;
use Test::More tests => 1;
ok( 1 , 'PNI.pm SYNOPSIS code works' );


# TODO try to get synopsis from PNI.pm pod section .

# run the PNI.pm SYNOPSIS pod section .
use PNI;

my $node = PNI::NODE 'Perlfunc::Print';
$node->set_input( list => 'Hello World !' );
$node->set_input( do_print => 1 );

PNI::RUN

