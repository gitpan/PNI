use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Length';

isa_ok( $node, 'PNI::Node' );
isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

$node->get_input('in')->set_data('12345');
ok( $node->task );
is( $node->get_output('out')->get_data, (length('12345')), 'length(\'12345\')' );

$node->get_input('in')->set_data('abc');
ok( $node->task );
is( $node->get_output('out')->get_data, (length('abc')), 'length(\'abc\')' );

my $string = 'hello';
$node->get_input('in')->set_data($string);
ok( $node->task );
is( $node->get_output('out')->get_data, (length($string)), 'length($string)' );

done_testing();
