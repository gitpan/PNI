use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::And';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::And';

# check default values
ok $node->task;

my $in1 = $node->get_input('in1');
my $in2 = $node->get_input('in2');
my $out = $node->get_output('out');

$in1->set_data(1);
$in2->set_data(0);
ok $node->task;
is $out->get_data, ( 1 and 0 ), '1 and 0';

$in1->set_data(0);
$in2->set_data(1);
ok $node->task;
is $out->get_data, ( 0 and 1 ), '0 and 1';

$in1->set_data(0);
$in2->set_data(0);
ok $node->task;
is $out->get_data, ( 0 and 0 ), '0 and 0';

$in1->set_data(1);
$in2->set_data(1);
ok $node->task;
is $out->get_data, ( 1 and 1 ), '1 and 1';

done_testing;
__END__
