use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Perlfunc::Sleep';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Sleep';

# check default values
ok $node->task;

done_testing;
__END__
