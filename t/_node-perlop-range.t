use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlop::Range';
isa_ok $node, 'PNI::Node';

# check slots
isa_ok $node->get_input('in1'),  'PNI::Slot::In';
isa_ok $node->get_input('in2'),  'PNI::Slot::In';
isa_ok $node->get_output('out'), 'PNI::Slot::Out';

# check default values
ok( $node->task );

done_testing;
__END__
