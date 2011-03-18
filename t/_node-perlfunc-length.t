use strict;
use Test::More tests => 12;
use PNI;

my $node = PNI::NODE 'Perlfunc::Length';
isa_ok $node, 'PNI::Node';

# check slots
my $in  = $node->get_input('in');
my $out = $node->get_output('out');
isa_ok $in,  'PNI::Slot::In';
isa_ok $out, 'PNI::Slot::Out';

# check default values
ok $node->task;

$in->set_data('12345');
ok $node->task;
is $out->get_data, ( length('12345') ), 'length(\'12345\')';

$in->set_data('abc');
ok $node->task;
is $out->get_data, ( length('abc') ), 'length(\'abc\')';

my $string = 'hello';
$in->set_data($string);
ok $node->task;
is $out->get_data, ( length($string) ), 'length($string)';

$in->set_data('12345');
ok $node->task;
is $out->get_data, ( length('12345') ), 'length(\'12345\')';

