use strict;
use Test::More;
use PNI;

my $source_node = PNI::NODE;
$source_node->add_output('out');
my $target_node = PNI::NODE;
$target_node->add_input('in');

my $link = PNI::LINK $source_node => $target_node,
  'out' => 'in';
isa_ok( $link, 'PNI::Link' );

$source_node->get_output('out')->set_data('test');
ok( $link->task );
is(
    $source_node->get_output('out')->get_data,
    $target_node->get_input('in')->get_data
);

$source_node->get_output('out')->set_data(1);
ok( $link->task );
is(
    $source_node->get_output('out')->get_data,
    $target_node->get_input('in')->get_data
);

done_testing();
