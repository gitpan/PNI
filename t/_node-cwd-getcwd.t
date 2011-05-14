use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Cwd::Getcwd';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Cwd::Getcwd';

# check default values
ok $node->task;

done_testing;
__END__
