use strict;
use PNI::Edge;
use PNI::Node;
use PNI::Slot::Out;
use Test::More;

# create an output slot for an empty node
my $node = PNI::Node->new;
my $slot = PNI::Slot::Out->new( node => $node, name => 'slot_test' );
isa_ok $slot, 'PNI::Slot::Out';

# at creation, slot should not be connected
is $slot->is_connected , 0;

# create a fake edge for tests
my $in = $node->add_input('in');
my $out = $node->add_output('out');
my $edge = PNI::Edge->new( source => $out , target => $in );
ok $slot->add_edge( $edge );

# at this point slot should be connected
is $slot->is_connected , 1;

isa_ok $out->join_to($in),'PNI::Edge','join_to';

done_testing;
__END__
