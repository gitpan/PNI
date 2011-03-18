use strict;
use Test::More;
use PNI;
use PNI::Scenario;

my ( $x, $y ) = ( 100, 100 );
# create an empty node for tests
my $node = PNI::NODE;

my $scenario = PNI::Scenario->new;
isa_ok( $scenario, 'PNI::Scenario' );

ok($scenario->add_node(node=>$node,center=>[$x,$y]),'add_node');

done_testing();
