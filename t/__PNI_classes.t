use strict;
use Test::More;

use_ok($_) for qw(
  PNI
  PNI::Edge
  PNI::Error
  PNI::Item
  PNI::Node
  PNI::Scenario
  PNI::Slot
  PNI::Slot::In
  PNI::Slot::Out
);

# checking inheritance
isa_ok( "PNI::$_", 'PNI::Item' ) for qw(
  Edge
  Node
  Slot
);
isa_ok 'PNI::Scenario', 'PNI::Node';
isa_ok( "PNI::Slot::$_", 'PNI::Slot' ) for qw(
  In
  Out
);

# checking subs
can_ok( 'PNI', $_ ) for qw(
  edge
  loop
  node
  root
  step
);
can_ok( 'PNI::Edge', $_ ) for qw(
  new
  get_source
  get_target
  get_source_node
  get_target_node
);
can_ok( 'PNI::Error', $_ ) for qw(
  generic
  invalid_argument_type
  missing_required_argument
  unable_to_create_item
  unable_to_init_node
  unable_to_load_node
  unable_to_run_task
  unimplemented_abstract_method
);
can_ok( 'PNI::Item', $_ ) for qw(
  new
  id
  add
  cleanup
  del
  get
  set
);
can_ok( 'PNI::Node', $_ ) for qw(
  new
  add_input
  add_output
  get_input
  get_input_edges
  get_inputs
  get_output
  get_output_edges
  get_outputs
  init
  task
);
can_ok( 'PNI::Scenario', $_ ) for qw(
  new
  add_node
  add_edge
  task
);
can_ok( 'PNI::Slot', $_ ) for qw(
  new
  data
  data_ref
  get_data
  get_name
  get_node
  get_type
  is_array
  is_connected
  is_hash
  is_number
  is_scalar
  is_string
  is_undef
  join_to
  set_data
);
can_ok( 'PNI::Slot::In', $_ ) for qw(
  new
  add_edge
  get_edge
  is_connected
  join_to
);
can_ok( 'PNI::Slot::Out', $_ ) for qw(
  new
  add_edge
  get_edges
  is_connected
  join_to
);

done_testing;
