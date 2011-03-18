use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Print';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok( $node->get_input('do_print') , 'PNI::Slot::In');
isa_ok( $node->get_input('list') , 'PNI::Slot::In');

# check default values
ok( $node->task );

ok($node->get_input('list')->set_data('Hello'));
#$node->task;

done_testing();

