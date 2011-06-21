use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Stringwise_equal';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Stringwise_equal';

# check default values
ok $node->task;

my $in1 = $node->get_input('in1');
my $in2 = $node->get_input('in2');
my $out = $node->get_output('out');

$in1->set_data('abc');
$in2->set_data('abc');
ok $node->task;
is $out->get_data, ( 'abc' eq 'abc' ), '\'abc\' eq \'abc\'';

done_testing;
__END__
