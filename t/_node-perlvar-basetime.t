use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlvar::Basetime';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlvar::Basetime';

# check default values
ok $node->task;

is $node->get_output('out')->get_data, $^T;

done_testing;
__END__
