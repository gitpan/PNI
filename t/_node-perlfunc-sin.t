use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Sin';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Sin';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

$in->set_data(0);
ok $node->task;
is $out->get_data, ( sin(0) ), 'sin(0)';

$in->set_data(1);
ok $node->task;
is $out->get_data, ( sin(1) ), 'sin(1)';

$in->set_data('abc');
ok $node->task,    'passing a string value to sin';
is $out->get_data, undef;

done_testing;
__END__
