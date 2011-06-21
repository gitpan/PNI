use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Sqrt';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Sqrt';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

$in->set_data(1);
ok $node->task;
is $out->get_data, ( sqrt(1) ), 'sqrt(1)';

$in->set_data(0);
ok $node->task;
is $out->get_data, ( sqrt(0) ), 'sqrt(0)';

$in->set_data(-1);
ok $node->task;
is $out->get_data, undef, 'sqrt(-1)';

done_testing;
__END__
