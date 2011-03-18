use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlop::Stringwise_equal';
isa_ok( $node, 'PNI::Node' );

# check slots
isa_ok($node->get_input('in1'),'PNI::Slot::In');
isa_ok($node->get_input('in2'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

# check default values
ok( $node->task );

$node->get_input('in1')->set_data('abc');
$node->get_input('in2')->set_data('abc');
ok( $node->task );
is( $node->get_output('out')->get_data, ('abc' eq 'abc'), '\'abc\' eq \'abc\'' );

done_testing();

