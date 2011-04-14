use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Perlfunc::Chop';
isa_ok $node, 'PNI::Node';

# check default values
ok $node->task;

# check slots
my $in             = $node->get_input('in');
my $out            = $node->get_output('out');
my $last_character = $node->get_output('last_character');
isa_ok $in,             'PNI::Slot::In';
isa_ok $out,            'PNI::Slot::Out';
isa_ok $last_character, 'PNI::Slot::Out';

# check default values
ok $node->task;

my $string = 'abc';
$in->set_data($string);
ok $node->task;
my $last_character_test = chop($string);
is $out->get_data, $string, 'chop($string)';
is $last_character->get_data, $last_character_test, 'last_character';

done_testing;
__END__
