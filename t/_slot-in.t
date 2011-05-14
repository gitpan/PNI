use strict;
use PNI::Edge;
use PNI::Node;
use PNI::Slot::In;
use Test::More;

# create an input slot for an empty node
my $node = PNI::Node->new;
my $slot = PNI::Slot::In->new( node => $node, name => 'slot_test' );
isa_ok $slot, 'PNI::Slot::In';

# at creation, slot should not be connected
is $slot->is_connected , 0;

# create a fake edge for tests
my $in = $node->add_input('in');
my $out = $node->add_output('out');
my $edge = PNI::Edge->new( source => $out , target => $in );
ok $slot->add_edge( $edge );

# at this point slot should be connected
is $slot->is_connected , 1;

done_testing;