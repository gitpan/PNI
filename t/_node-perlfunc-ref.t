use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Ref';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Ref';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

my @array     = qw( foo bar );
my $array_ref = \@array;
ok $in->set_data($array_ref);
ok $node->task;
is $out->get_data, 'ARRAY';

my $hash_ref = {};
ok $in->set_data($hash_ref);
ok $node->task;
is $out->get_data, 'HASH';

done_testing;
__END__
