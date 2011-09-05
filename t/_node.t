use strict;
use Test::More;
use PNI::Node;
use PNI::Error;

# Create an empty node and decorate it.
my $node1 = PNI::Node->new;
isa_ok $node1, 'PNI::Node';

is $node1->get_type, 'PNI::Node';

ok $node1->add_input('in'),     'add_input';
isa_ok $node1->get_input('in'), 'PNI::Slot::In';

ok $node1->add_output('out'),     'add_output';
isa_ok $node1->get_output('out'), 'PNI::Slot::Out';

is $node1->has_no_input_slot_changed,  1;
ok $node1->some_input_slot_is_changed;
is $node1->has_no_input_slot_changed, 0;

my $data = 'foo';
ok $node1->get_input('in')->set_data($data), 'set_data';
is $node1->get_input('in')->get_data, $data, 'get_data';

ok $node1->add_input( 'one', data => 1 ), 'add_input with data';
isa_ok $node1->get_input('one'), 'PNI::Slot::In';
is $node1->get_input('one')->get_data, 1, 'get_data';
ok $node1->get_input('one')->set_data(1), 'set_data';

# Passing wrong parameters:
# tell PNI::Error to be silent for next tests ...
PNI::Error::verbose_off;

isnt $node1->add_input,  1, 'add input with no name';
isnt $node1->add_output, 1, 'add output with no name';

isnt $node1->add_input('in'),   1, 'add two inputs with the same name';
isnt $node1->add_output('out'), 1, 'add two outputs with the same name';

isnt $node1->get_input,  1, 'get_input without arg';
isnt $node1->get_output, 1, 'get_output without arg';

# ... end of silence.
PNI::Error::verbose_on;

# Checking ordered slots.
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
is_deeply \@node_ordered_inputs,  \@ordered_inputs,  'ordered_inputs';
is_deeply \@node_ordered_outputs, \@ordered_outputs, 'ordered_outputs';

my $node3 = PNI::Node->new;
$node3->add_output('out');
$node1->get_output('out')->join_to( $node2->get_input('a') );
$node3->get_output('out')->join_to( $node2->get_input('b') );
my @parents1 = sort ( $node1, $node3 );
my @parents2 = sort $node2->parents;
is_deeply \@parents1, \@parents2, 'parents';

done_testing;
__END__

