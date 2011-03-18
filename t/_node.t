use strict;
use Test::More;
use PNI::Node;
use PNI::Error;

# create an empty node and decorate it
my $node = PNI::Node->new;
isa_ok $node, 'PNI::Node';

ok $node->add_input('in'),     'add_input';
isa_ok $node->get_input('in'), 'PNI::Slot::In';

ok $node->add_output('out'),     'add_output';
isa_ok $node->get_output('out'), 'PNI::Slot::Out';

my $data = 'foo';
ok $node->get_input('in')->set_data($data), 'set_data';
is $node->get_input('in')->get_data, $data, 'get_data';

ok $node->add_input( 'one', data => 1 ), 'add_input with data';
isa_ok $node->get_input('one'), 'PNI::Slot::In';
is $node->get_input('one')->get_data, 1, 'get_data';
ok $node->get_input('one')->set_data(1), 'set_data';

# tell PNI::Error to be silent for next tests
PNI::Error::verbose_off;

# passing wrong parameters

isnt $node->add_input,  1, 'add input with no name';
isnt $node->add_output, 1, 'add output with no name';

isnt $node->add_input('in'),   1, 'add two inputs with the same name';
isnt $node->add_output('out'), 1, 'add two outputs with the same name';

isnt $node->get_input,  1, 'get_input without arg';
isnt $node->get_output, 1, 'get_output without arg';

done_testing;
