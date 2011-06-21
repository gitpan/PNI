use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Not';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Not';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

$in->set_data(1);
ok $node->task;
is $out->get_data, ( not 1 ), 'not 1';

$in->set_data(0);
ok $node->task;
is $out->get_data, ( not 0 ), 'not 0';

done_testing;
__END__
