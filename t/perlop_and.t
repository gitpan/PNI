use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlop::And';

isa_ok( $node, 'PNI::Node' );

# inputs in1, in2
isa_ok( $node->get_input('in1'), 'PNI::Slot::In' );
isa_ok( $node->get_input('in2'), 'PNI::Slot::In' );

# output out
isa_ok( $node->get_output('out'), 'PNI::Slot::Out' );

ok( $node->get_input('in1')->set_data(1), 'set_data' );
ok( $node->get_input('in2')->set_data(0), 'set_data' );

ok( $node->task, 'task' );
is( $node->get_output('out')->get_data, ( 1 and 0 ), '1 and 0' );

$node->get_input('in1')->set_data(1);
$node->get_input('in2')->set_data(1);
ok( $node->task, 'task' );
is( $node->get_output('out')->get_data, ( 1 and 1 ), '1 and 1' );

$node->get_input('in1')->set_data(0);
$node->get_input('in2')->set_data(0);
ok( $node->task, 'task' );
is( $node->get_output('out')->get_data, ( 0 and 0 ), '0 and 0' );

$node->get_input('in1')->set_data(0);
$node->get_input('in2')->set_data(1);
ok( $node->task, 'task' );
is( $node->get_output('out')->get_data, ( 0 and 1 ), '0 and 1' );

done_testing();

