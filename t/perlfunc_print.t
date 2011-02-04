use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Print';

isa_ok( $node, 'PNI::Node' );

# input list
isa_ok( $node->get_input('do_print') , 'PNI::Slot::In');
isa_ok( $node->get_input('list') , 'PNI::Slot::In');

ok($node->get_input('list')->set_data('Hello'));
#$node->task;

done_testing();

