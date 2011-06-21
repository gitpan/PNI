use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Exp';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Exp';

# check default values
ok $node->task;

# check slots
isa_ok( $node->get_input('in'),   'PNI::Slot::In' );
isa_ok( $node->get_output('out'), 'PNI::Slot::Out' );

# check default values
ok( $node->task );

$node->get_input('in')->set_data(0);
ok( $node->task );
is( $node->get_output('out')->get_data, ( exp(0) ), 'exp(0)' );

$node->get_input('in')->set_data(1);
ok( $node->task );
is( $node->get_output('out')->get_data, ( exp(1) ), 'exp(1)' );

done_testing;
__END__
