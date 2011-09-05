use strict;
use PNI;
use Test::More;

my $node = PNI::node 'PNI::Root';
isa_ok $node, 'PNI::Node::PNI::Root';

ok $node->task;

my $root = $node->get_output('object')->get_data;

is $root, PNI::root;

done_testing
__END__

