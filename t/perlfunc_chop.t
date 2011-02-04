use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Chop';

isa_ok( $node, 'PNI::Node' );

my $string = 'abc';
$node->get_input('in')->set_data($string);
ok( $node->task );
my $last_character = chop($string);
is( $node->get_output('out')->get_data, $string, 'chop($string)' );
is( $node->get_output('last_character')->get_data, $last_character, 'last_character' );

done_testing();
