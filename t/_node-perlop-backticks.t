use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Backticks';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Backticks';

# check default values
ok $node->task;

done_testing;
__END__
