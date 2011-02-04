use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Sqrt';

isa_ok( $node, 'PNI::Node' );
isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');


$node->get_input('in')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, (sqrt(1)), 'sqrt(1)' );

done_testing();


