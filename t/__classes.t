use strict;
use Test::More;

BEGIN {
    use_ok($_)
      or BAIL_OUT(" $_ module does not compile :-(")
      for qw(
      PNI
      PNI::Edge
      PNI::Error
      PNI::File
      PNI::Finder
      PNI::GUI::Edge
      PNI::GUI::Node
      PNI::GUI::Scenario
      PNI::GUI::Slot
      PNI::Item
      PNI::Node
      PNI::Scenario
      PNI::Slot
      PNI::Slot::In
      PNI::Slot::Out
    );
}

# checking inheritance
isa_ok( "PNI::$_", 'PNI::Item' ) for qw(
  Edge
  File
  GUI::Edge
  GUI::Node
  GUI::Scenario
  GUI::Slot
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
  task
);
can_ok( 'PNI::Edge', $_ ) for qw(
  new
  get_source
  get_source_node
  get_target
  get_target_node
  task
);
can_ok( 'PNI::Error', $_ ) for qw(
  attribute_does_not_exists
  generic
  invalid_argument_type
  missing_required_argument
  overridden_attribute_name
  unable_to_create_item
  unable_to_init_node
  unable_to_load_node
  unable_to_run_task
  unimplemented_abstract_method
);
can_ok( 'PNI::File', $_ ) for qw(
  get_content
  get_path
  set_content
);
can_ok( 'PNI::Finder', $_ ) for qw(
  instance
  nodes
);
can_ok( 'PNI::GUI::Edge', $_ ) for qw(
  new
);
can_ok( 'PNI::GUI::Node', $_ ) for qw(
  new
  get_center_y
  get_center_x
  get_height
  get_label
  get_node
  get_width
  move
  set_center_y
  set_center_x
  set_height
  set_label
  set_width
);
can_ok( 'PNI::GUI::Scenario', $_ ) for qw(
  new
  add_edge
  add_node
  del_edge
  del_node
  clear_all
  load_file
  save_file
  set_file
);
can_ok( 'PNI::GUI::Slot', $_ ) for qw(
  get_node
);
can_ok( 'PNI::Item', $_ ) for qw(
  new
  id
  add
  cleanup
  del
  get
  has
  set
  type
);
can_ok( 'PNI::Node', $_ ) for qw(
  new
  add_input
  add_output
  get_input
  get_input_edges
  get_inputs
  get_ordered_inputs
  get_ordered_outputs
  get_output
  get_output_edges
  get_outputs
  get_type
  some_input_is_connected
  init
  task
);
can_ok( 'PNI::Scenario', $_ ) for qw(
  new
  add_edge
  add_node
  add_scenario
  get_nodes
  task
);
can_ok( 'PNI::Slot', $_ ) for qw(
  new
  data
  get_data
  get_name
  get_node
  get_type
  is_array
  is_changed
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
