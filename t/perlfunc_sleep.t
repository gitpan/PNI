use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Sleep';

isa_ok( $node, 'PNI::Node' );

#isa_ok($node->get_input('in'),'PNI::Slot::In');

done_testing();



