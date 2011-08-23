use strict;
use PNI;
use PNI::GUI::Node;
use PNI::GUI::Slot;
use Test::More;

my $node     = PNI::node;
my $gui_node = PNI::GUI::Node->new(
    center_y => 0,
    center_x => 0,
    height   => 0,
    node     => $node,
    width    => 0,
);
my $slot_name = 'in';
my $slot      = $node->add_input($slot_name);
my $gui_slot  = PNI::GUI::Slot->new( node => $gui_node, slot => $slot );

isa_ok $gui_slot, 'PNI::GUI::Slot';

is $gui_slot->get_node, $gui_node, 'get_node';

done_testing;
__END__

