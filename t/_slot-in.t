use strict;
use Test::More;
use PNI;
use PNI::Slot::In;

# create an input slot for an empty node
my $slot = PNI::Slot::In->new( node => PNI::node, name => 'slot_test' );
isa_ok $slot, 'PNI::Slot::In';

done_testing;
