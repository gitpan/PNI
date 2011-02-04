use strict;
use Test::More;

use PNI::Hierarchy;

my $root = PNI::Hierarchy->new;
isa_ok( $root, 'PNI::Hierarchy' );

ok( $root->task, 'hierarchy task without nodes' );

ok( my $node1 = $root->add_node(), 'add empty node' );
isa_ok( $node1, 'PNI::Node' );

ok( my $node2 = $root->add_node(), 'add another empty node' );
isa_ok( $node2, 'PNI::Node' );

$node1->add_output('out',data=>1);
$node2->add_input('in');

my $link = $root->add_link(
    source => $node1->get_output('out'),
    target => $node2->get_input('in')
);

ok( $root->task, 'hierarchy task' );

done_testing();
