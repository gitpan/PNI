use strict;
use Test::More;

use PNI;

my $node = PNI::NODE 'Perlop::Not';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

# check default values
ok( $node->task );

ok( $node->get_input('in')->set_data(1) );
ok( $node->task );
is( $node->get_output('out')->get_data, ( not 1 ), 'not 1' );

ok( $node->get_input('in')->set_data(0) );
ok( $node->task );
is( $node->get_output('out')->get_data, ( not 0 ), 'not 0' );

done_testing();

