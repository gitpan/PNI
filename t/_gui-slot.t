use strict;
use PNI;
use PNI::GUI::Node;
use PNI::GUI::Slot;
use Test::More;

my $node = PNI::GUI::Node->new(
    center_y=>0,
    center_x=>0,
    height => 0,
    node => PNI::node,
    width=>0,
);
my $slot = PNI::GUI::Slot->new(node=>$node);

isa_ok $slot,'PNI::GUI::Slot';

is $slot->get_node,$node,'get_node';

done_testing;
__END__

