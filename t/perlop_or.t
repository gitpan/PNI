use strict;
use warnings;
use Test::More;

use PNI::Hierarchy;

my $root = PNI::Hierarchy->new;

my $node = $root->add_node( type => 'Perlop::Or' );

isa_ok( $node, 'PNI::Node' );

$node->get_input('in1')->set_data(1);
$node->get_input('in2')->set_data(0);
ok( $node->task );
is( $node->get_output('out')->get_data, (1 or 0), '1 or 0' );

$node->get_input('in1')->set_data(1);
$node->get_input('in2')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, (1 or 1), '1 or 1' );

$node->get_input('in1')->set_data(0);
$node->get_input('in2')->set_data(0);
ok( $node->task );
is( $node->get_output('out')->get_data, (0 or 0), '0 or 0' );

$node->get_input('in1')->set_data(0);
$node->get_input('in2')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, ( 0 or 1 ), '0 or 1' );

done_testing();

