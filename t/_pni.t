use strict;
use PNI ':-D';
use Test::More;

my $node = node;
isa_ok $node , 'PNI::Node';

my $node2 = node;
$node->add_output('out');
$node2->add_input('in');

my $edge = edge $node => $node2, 'out' => 'in';
isa_ok $edge , 'PNI::Edge';

ok task;

done_testing;
__END__

