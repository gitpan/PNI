use strict;
use Test::More;
use PNI;

my $node = PNI::node 'List::Util::Max';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::List::Util::Max';

# check default values
ok $node->task;

done_testing;
__END__
