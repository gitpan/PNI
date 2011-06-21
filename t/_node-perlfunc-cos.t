use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Cos';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Cos';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

$in->set_data(0);
ok $node->task;
is $out->get_data, ( cos(0) ), 'cos(0)';

$in->set_data(1);
ok $node->task;
is $node->get_output('out')->get_data, ( cos(1) ), 'cos(1)';

$in->set_data('xxx');
ok $node->task,    'passing a string value to cos';
is $out->get_data, undef;

done_testing;
__END__
