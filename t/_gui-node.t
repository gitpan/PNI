use strict;
use PNI;
use PNI::GUI::Node;
use Test::More;

my $node     = PNI::node;
my $center_y = 10;
my $center_x = 10;
my $width    = 10;
my $height   = 10;

my $gui_node = PNI::GUI::Node->new(
    center_y => $center_y,
    center_x => $center_x,
    height   => $height,
    node     => $node,
    width    => $width,
);
isa_ok $gui_node, 'PNI::GUI::Node';

is $gui_node->get_center_y, $center_y;
is $gui_node->get_center_x, $center_x;
is $gui_node->get_height, $height;
is $gui_node->get_label, $node->get_type, 'label defaults to $self->get_node->get_type';
is $gui_node->get_node, $node;
is $gui_node->get_width, $width;

done_testing;
__END__

