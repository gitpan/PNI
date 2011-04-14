use strict;
use Test::More;
use PNI;
use PNI::Error;
use PNI::Scenario;
use PNI::Scenario::Node;

my ( $x, $y ) = ( 100, 100 );
my $pni_node = PNI::node;
my $scenario = PNI::Scenario->new;
my $node     = PNI::Scenario::Node->new(
    node     => $pni_node,
    scenario => $scenario,
    center   => [ $x, $y ]
);
isa_ok $node, 'PNI::Scenario::Node';

is_deeply $node->get_center, [ $x, $y ], 'get_center';
is $node->get_center_x, $x, 'get_center_x';
is $node->get_center_y, $y, 'get_center_y';
cmp_ok $node->get_height, '>', 0, 'node height is positive';
cmp_ok $node->get_width,  '>', 0, 'node width is positive';

# tell PNI::Error to be silent for next tests
PNI::Error::verbose_off;

# constructor without node arg
my $node2 = PNI::Scenario::Node->new(
    scenario => $scenario,
    center   => [ $x, $y ]
);
isa_ok $node2, 'PNI::Scenario::Node';

# passing wrong parameters to constructor
my $undef_node1 = PNI::Scenario::Node->new;
is $undef_node1, undef, 'constructor without required arguments';
my $undef_node2 = PNI::Scenario::Item->new( node => bless {}, 'Foo' );
is $undef_node2, undef, 'node must be a PNI::Node';

done_testing;
