use strict;
use Test::More;
use PNI;
use PNI::Slot::Out;

# create an output slot for an empty node
my $slot = PNI::Slot::Out->new( node => PNI::node, name => 'slot_test' );
isa_ok $slot, 'PNI::Slot::Out';

done_testing;
