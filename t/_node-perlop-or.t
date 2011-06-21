use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Or';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Or';

# check default values
ok $node->task;

my $in1 = $node->get_input('in1');
my $in2 = $node->get_input('in2');
my $out = $node->get_output('out');

$in1->set_data(1);
$in2->set_data(0);
ok $node->task;
is $out->get_data, ( 1 or 0 ), '1 or 0';

$in2->set_data(1);
ok $node->task;
is $out->get_data, ( 1 or 1 ), '1 or 1';

$in1->set_data(0);
$in2->set_data(0);
ok $node->task;
is $out->get_data, ( 0 or 0 ), '0 or 0';

$in2->set_data(1);
ok $node->task;
is $out->get_data, ( 0 or 1 ), '0 or 1';

done_testing;
__END__
