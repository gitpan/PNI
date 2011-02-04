use strict;
use Test::More;

BEGIN {
    use_ok('PNI');
    use_ok('PNI::Link');
    use_ok('PNI::Hierarchy');
    use_ok('PNI::Item');
    use_ok('PNI::Node');
    use_ok('PNI::Slot');
    use_ok('PNI::Slot::In');
    use_ok('PNI::Slot::Out');
}

isa_ok( "PNI::$_", 'PNI::Item' ) for qw(
  Hierarchy
  Link
  Node
  Slot
  Slot::In
  Slot::Out
);
isa_ok( "PNI::Slot::$_", 'PNI::Slot' ) for qw(
  In
  Out
);

can_ok( 'PNI::Hierarchy', $_ ) for qw(
  new
  add_node
  add_link
  del_node
  del_link
  get_node
  get_link
  get_nodes
  get_links
  task
  DESTROY
);
can_ok( 'PNI', $_ ) for qw(
  ROOT
  LINK
  NODE
  RUN
  LOOP
);
can_ok( 'PNI::Item', $_ ) for qw(
  new
  id
  DESTROY
);
can_ok( 'PNI::Link', $_ ) for qw(
  new
  get_source
  get_target
  get_source_node
  get_target_node
  task
  DESTROY
);
can_ok( 'PNI::Node', $_ ) for qw(
  new
  add_input
  add_output
  del_input
  del_output
  get_input
  get_output
  get_inputs
  get_outputs
  get_input_links
  get_output_links
  task
  DESTROY
);
can_ok( 'PNI::Slot', $_ ) for qw(
  new
  get_data
  set_data
  get_name
  set_name
  get_node
  DESTROY
);
can_ok( 'PNI::Slot::In', $_ ) for qw(
  new
  add_link
  del_link
  get_link
  DESTROY
);
can_ok( 'PNI::Slot::Out', $_ ) for qw(
  new
  add_link
  del_link
  get_links
  DESTROY
);

done_testing();

