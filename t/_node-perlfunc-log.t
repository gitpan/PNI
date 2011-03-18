use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Log';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

# check default values
ok( $node->task );

$node->get_input('in')->set_data(10);
ok( $node->task );
is( $node->get_output('out')->get_data, ( log(10) ), 'log(10)' );

$node->get_input('in')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, ( log(1) ), 'log(1)' );

done_testing();

