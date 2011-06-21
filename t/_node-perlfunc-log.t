use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Log';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Log';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

$in->set_data(10);
ok $node->task;
is $out->get_data, ( log(10) ), 'log(10)';

$in->set_data(1);
ok $node->task;
is $out->get_data, ( log(1) ), 'log(1)';

done_testing;
__END__
