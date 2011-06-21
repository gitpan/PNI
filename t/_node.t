use strict;
use Test::More;
use PNI::Node;
use PNI::Error;

# create an empty node and decorate it
my $node = PNI::Node->new;
isa_ok $node, 'PNI::Node';

is $node->get_type, 'PNI::Node';

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

# passing wrong parameters

# tell PNI::Error to be silent for next tests ...
PNI::Error::verbose_off;

isnt $node->add_input,  1, 'add input with no name';
isnt $node->add_output, 1, 'add output with no name';

isnt $node->add_input('in'),   1, 'add two inputs with the same name';
isnt $node->add_output('out'), 1, 'add two outputs with the same name';

isnt $node->get_input,  1, 'get_input without arg';
isnt $node->get_output, 1, 'get_output without arg';

# ... end of silence
PNI::Error::verbose_on;

# checking ordered slots
my $node2        = PNI::Node->new;
my @input_names  = qw(a b c);
my @output_names = qw(d e f g);

$node2->add_input($_)  for @input_names;
$node2->add_output($_) for @output_names;
is_deeply \@input_names,  $node2->get('inputs_order'),  'inputs_order';
is_deeply \@output_names, $node2->get('outputs_order'), 'outputs_order';

my @ordered_inputs;
for my $name (@input_names) {
    push @ordered_inputs, $node2->get_input($name);
}
my @ordered_outputs;
for my $name (@output_names) {
    push @ordered_outputs, $node2->get_output($name);
}
my @node_ordered_inputs  = $node2->get_ordered_inputs;
my @node_ordered_outputs = $node2->get_ordered_outputs;
is_deeply \@node_ordered_inputs,   \@ordered_inputs,  'ordered_inputs';
is_deeply \@node_ordered_outputs, \@ordered_outputs, 'ordered_outputs';

done_testing;
__END__

