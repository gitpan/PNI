use strict;
use warnings;
use Test::More;
use English;

use PNI::Hierarchy;

my $root = PNI::Hierarchy->new;

my $node = $root->add_node( type => 'Perlvar::Osname' );

isa_ok( $node, 'PNI::Node' );

ok( $node->task );
is($node->get_output('out')->get_data , $OSNAME);

done_testing();

