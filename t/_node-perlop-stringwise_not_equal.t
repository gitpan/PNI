use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Stringwise_not_equal';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Stringwise_not_equal';

# check default values
ok $node->task;

# check slots
my $in1 = $node->get_input('in1');
my $in2 = $node->get_input('in2');
my $out = $node->get_output('out');

isa_ok $in1, 'PNI::Slot::In';
isa_ok $in2, 'PNI::Slot::In';
isa_ok $out, 'PNI::Slot::Out';

# check default values
ok $node->task;

$in1->set_data('abc');
$in2->set_data('abc');
ok $node->task;
is $out->get_data, ( 'abc' ne 'abc' ), '\'abc\' ne \'abc\'';

$in1->set_data('xxx');
ok $node->task;
is $out->get_data, ( 'xxx' ne 'abc' ), '\'xxx\' ne \'abc\'';

done_testing;
__END__
