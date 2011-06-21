use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Chop';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Chop';

# check default values
ok $node->task;

# check slots
my $in        = $node->get_input('in');
my $out       = $node->get_output('out');
my $last_char = $node->get_output('last_char');
isa_ok $in,        'PNI::Slot::In';
isa_ok $out,       'PNI::Slot::Out';
isa_ok $last_char, 'PNI::Slot::Out';

# check default values
ok $node->task;

my $string = 'abc';
$in->set_data($string);
ok $node->task;
my $last_char_test = chop($string);
is $out->get_data,       $string,         'chop($string)';
is $last_char->get_data, $last_char_test, 'last_char';

done_testing;
__END__
