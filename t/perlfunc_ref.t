use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Ref';

isa_ok( $node, 'PNI::Node' );

isa_ok($node->get_input('in'),'PNI::Slot::In');
isa_ok($node->get_output('out'),'PNI::Slot::Out');

my @array = qw( foo bar );
my $array_ref = \@array;
ok($node->get_input('in')->set_data($array_ref));
ok($node->task);
is($node->get_output('out')->get_data,'ARRAY');

my $hash_ref = {};
ok($node->get_input('in')->set_data($hash_ref));
ok($node->task);
is($node->get_output('out')->get_data,'HASH');

done_testing();


