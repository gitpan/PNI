use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlop::Numerically_equal';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok($node->get_input('in1'),'PNI::Slot::In');
isa_ok($node->get_input('in2'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

# check default values
ok( $node->task );

$node->get_input('in1')->set_data(1);
$node->get_input('in2')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, (1 == 1), '1 == 1' );

done_testing();


