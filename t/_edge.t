use strict;
use warnings;
use PNI::Edge;
use PNI::Node;
use Test::More tests => 3;

my $node   = PNI::Node->new;
my $source = $node->out;
my $target = $node->in;

my $edge = PNI::Edge->new( source => $source, target => $target );
isa_ok $edge, 'PNI::Edge';

is_deeply \( $source->edges->list ), \($edge), 'source edges';
is $target->edge, $edge, 'target edge';

