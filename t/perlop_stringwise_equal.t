use strict;
use warnings;
use Test::More;

use PNI::Hierarchy;

my $root = PNI::Hierarchy->new;

my $node = $root->add_node( type => 'Perlop::Stringwise_equal' );

isa_ok( $node, 'PNI::Node' );

$node->get_input('in1')->set_data('abc');
$node->get_input('in2')->set_data('abc');
ok( $node->task );
is( $node->get_output('out')->get_data, ('abc' eq 'abc'), '\'abc\' eq \'abc\'' );

done_testing();


