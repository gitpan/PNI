use strict;
use English;
use PNI;
use Test::More;

my $node = PNI::NODE 'Perlvar::Osname';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok($node->get_output('out'),'PNI::Slot::Out');

# just run once the task to evaluate the variable
ok( $node->task );
is($node->get_output('out')->get_data , $OSNAME);

done_testing();

