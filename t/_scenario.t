use strict;
use Test::More;
use PNI::File;
use PNI::Scenario;

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

# scenario is empty
is 0, $scenario->get_nodes;
is 0, $scenario->get_scenarios;
ok $scenario->task;

# add some stuff
my $node1 = $scenario->add_node;
isa_ok $node1, 'PNI::Node';

my $node2 = $scenario->add_node;
isa_ok $node2, 'PNI::Node';

# connect nodes
my @nodes1 = sort ( $node1, $node2 );
my @nodes2 = sort $scenario->get_nodes;
is_deeply \@nodes1, \@nodes2;

my $source = $node1->add_output('out');
my $target = $node2->add_input('in');
my $edge   = $scenario->add_edge( source => $source, target => $target, );
isa_ok $edge , 'PNI::Edge';
is $edge->get_source, $source;
is $edge->get_target, $target;

my $sub_scenario = $scenario->add_scenario;
isa_ok $sub_scenario, 'PNI::Scenario';

my $node3 = $sub_scenario->add_node;

my @scenarios1 = ($sub_scenario);
my @scenarios2 = $scenario->get_scenarios;
is_deeply \@scenarios1, \@scenarios2;

# remove sub scenario
ok $scenario->del_scenario($sub_scenario);

# $sub_scenario was deleted from $scenario so now should be without nodes
is 0, $sub_scenario->get_nodes;

# scenario does not contain sub scenarios again
is 0, $scenario->get_scenarios;

ok $scenario->del_node($node1);

# the edge connecting node1 and node2 now is deleted
is 0, $node1->get_output_edges;
is 0, $node2->get_input_edges;
ok $scenario->del_node($node2);

# now $scenario is empty
is 0, $scenario->get_nodes;

done_testing;
__END__
