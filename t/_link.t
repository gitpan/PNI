use strict;
use Test::More;
use PNI::Link;
use PNI::Node;

# construct an empty node with one output
my $source_node = PNI::Node->new;
my $source      = $source_node->add_output('out');

# construct an empty node with one input
my $target_node = PNI::Node->new;
my $target      = $target_node->add_input('in');

# construct link
my $link = PNI::Link->new( source => $source, target => $target );
isa_ok( $link, 'PNI::Link' );

$source_node->get_output('out')->set_data('test');
ok $link->task;
is $source_node->get_output('out')->get_data,
  $target_node->get_input('in')->get_data;

$source_node->get_output('out')->set_data(1);
ok $link->task;
is $source_node->get_output('out')->get_data,
  $target_node->get_input('in')->get_data;

done_testing;
