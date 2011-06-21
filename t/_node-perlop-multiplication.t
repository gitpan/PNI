use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Multiplication';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Multiplication';

# check default values
ok $node->task;

my $in1 = $node->get_input('in1');
my $in2 = $node->get_input('in2');
my $out = $node->get_output('out');

ok $in1->set_data(1);
ok $in2->set_data(1);
ok $node->task;
is $out->get_data, ( 1 * 1 ), '1 * 1';

done_testing;
__END__
