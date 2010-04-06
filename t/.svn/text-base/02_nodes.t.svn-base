use Test;
my $num_of_nodes = 2;
plan tests => $num_of_nodes;
use PNI;
my @node_types = qw(
Template
Perlfunc::Print
);
# aggiusta bene
for my $node_type ( @node_types ) {
ok( PNI::NODE $node_type );
}
