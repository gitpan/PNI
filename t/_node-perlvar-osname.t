use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlvar::Osname';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlvar::Osname';

# check default values
ok $node->task;

is $node->get_output('out')->get_data, $^O;

done_testing;
__END__
