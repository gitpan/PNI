use strict;
use PNI::Edge;
use PNI::Node;
use Test::More;

# construct an empty node with one output
my $source_node = PNI::Node->new;
my $source      = $source_node->add_output('out');

# construct an empty node with one input
my $target_node = PNI::Node->new;
my $target      = $target_node->add_input('in');

# construct edge
my $edge = PNI::Edge->new( source => $source, target => $target );
isa_ok $edge, 'PNI::Edge';

done_testing;
__END__

