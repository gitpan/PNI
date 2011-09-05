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
is $slot->is_connected, 0;

my $data = 'foo';
ok $slot->set_data( $data );
is $slot->get_data,$data;

# create a fake edge for tests
my $edge = PNI::Edge->new(
    source => $node->add_output('out'),
    target => $node->add_input('in'),

);
ok $slot->add_edge($edge);

is $edge, $slot->get_edge, 'get_edge';

# at this point slot should be connected
is $slot->is_connected, 1;

isa_ok $slot->join_to($node->add_output('out2')), 'PNI::Edge', 'join_to';

ok $slot->del_edge, 'del_edge';

# after deleting edge the slot is not connected anymore
isnt $edge, $slot->get_edge;
is $slot->is_connected, 0;

done_testing;
__END__
