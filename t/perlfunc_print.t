use strict;
use Test::More tests => 1;
use PNI;

ok(1);

my $node = PNI::NODE 'Perlfunc::Print' , do_print => 1 , list => [ 'Hello World!' ];

$node->task;
#PNI::RUN;
#
#TODO: {
#    local $TODO = "run tests after PNI::RUN";
#    cmp_ok( $node->get_input( 'do_print' ) , '==' , 0 , 'reset input do_print' );
#}
