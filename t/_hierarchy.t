use strict;
use Test::More;
use PNI;
use PNI::Hierarchy;

my $root = PNI::Hierarchy->new;
isa_ok $root, 'PNI::Hierarchy';

ok $root->task, 'hierarchy task without nodes';

my $node1 = PNI::NODE;
ok $root->add_node($node1), 'add empty node';

my $node2 = PNI::NODE;
ok $root->add_node($node2), 'add another empty node';

# decorate nodes
$node1->add_output( 'out', data => 1 );
$node2->add_input('in');

my $link = PNI::LINK $node1 => $node2, 'out' => 'in';
ok $root->add_link($link), 'add_link';

ok $root->task, 'hierarchy task';

done_testing;
