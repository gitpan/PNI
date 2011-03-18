use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlop::Backticks';
isa_ok $node, 'PNI::Node';

# check slots
isa_ok $node->get_input('in') , 'PNI::Slot::In';

# check default values
ok $node->task;

done_testing;

