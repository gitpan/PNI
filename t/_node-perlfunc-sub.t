use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Perlfunc::Sub';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Sub';

# check default values
ok $node->task;

done_testing;
__END__
