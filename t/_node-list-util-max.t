use strict;
use Test::More;
use PNI ':-D';

my $node = node 'List::Util::Max';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::List::Util::Max';

# check default values
ok $node->task;

use List::Util 'max';

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

my $array1 = [ 1, 4, 8 ];
$in->set_data($array1);
ok task;
is $out->get_data, max( @{$array1} );

done_testing;
__END__
