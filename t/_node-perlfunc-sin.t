use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Sin';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

# check default values
ok( $node->task );

$node->get_input('in')->set_data(0);
ok( $node->task );
is( $node->get_output('out')->get_data, ( sin(0) ), 'sin(0)' );

$node->get_input('in')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, ( sin(1) ), 'sin(1)' );

done_testing();

