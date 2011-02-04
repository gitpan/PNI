use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Chomp';

isa_ok( $node, 'PNI::Node' );

isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

my $string = 'abc';
$node->get_input('in')->set_data($string);
ok( $node->task );
chomp($string);
is( $node->get_output('out')->get_data, $string, 'chomp($string)' );

done_testing();
