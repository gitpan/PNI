use strict;
use Test::More;
use PNI;

my $node = PNI::node 'PNI::Node_list';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::PNI::Node_list';

# check default values
ok $node->task;

done_testing;
__END__
