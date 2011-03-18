use strict;
use Test::More;

use_ok($_) for qw(
  PNI
  PNI::GUI
  PNI::Error
  PNI::Hierarchy
  PNI::Item
  PNI::Link
  PNI::Node
  PNI::Scenario
  PNI::Scenario::Item
  PNI::Scenario::Link
  PNI::Scenario::Node
  PNI::Slot
  PNI::Slot::In
  PNI::Slot::Out
);

# checking inheritance
isa_ok( "PNI::$_", 'PNI::Item' ) for qw(
  GUI
  Hierarchy
  Link
  Node
  Scenario
  Scenario::Item
  Slot
  Slot::In
  Slot::Out
);
isa_ok( "PNI::Scenario::$_", 'PNI::Scenario::Item' ) for qw(
  Link
  Node
);
isa_ok( "PNI::Slot::$_", 'PNI::Slot' ) for qw(
  In
  Out
);

# checking subs
can_ok( 'PNI::Scenario', $_ ) for qw(
  new
  add_node
  add_link
  get_hierarchy
);
can_ok( 'PNI::Scenario::Item', $_ ) for qw(
  new
  get_scenario
  get_hierarchy
);
can_ok( 'PNI::Scenario::Link', $_ ) for qw(
  new
);
can_ok( 'PNI::Scenario::Node', $_ ) for qw(
  new
  get_center
  get_center_x
  get_center_y
  get_height
  get_label
  get_node
  get_width
  set_center
  set_height
  set_width
);
can_ok( 'PNI::Hierarchy', $_ ) for qw(
  new
  add_node
  add_link
  get_node
  get_link
  get_nodes
  get_links
  task
);
can_ok( 'PNI', $_ ) for qw(
  ROOT
  LINK
  NODE
  RUN
  LOOP
);
can_ok( 'PNI::Error', $_ ) for qw(
  generic
  missing_required_argument
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
);
can_ok( 'PNI::Slot', $_ ) for qw(
  new
  get_data
  get_name
  get_node
  set_data
);
can_ok( 'PNI::Slot::In', $_ ) for qw(
  new
);
can_ok( 'PNI::Slot::Out', $_ ) for qw(
  new
);
can_ok( 'PNI::Scenario', $_ ) for qw(
  new
  add_link
  add_node
);
can_ok( 'PNI::Scenario::Item', $_ ) for qw(
  new
);
can_ok( 'PNI::Scenario::Link', $_ ) for qw(
  new
);
can_ok( 'PNI::Scenario::Node', $_ ) for qw(
  new
  get_center
  get_height
  get_width
  set_center
  set_height
  set_width
);
can_ok( 'PNI::Slot::In', $_ ) for qw(
  new
  add_link
  del_link
  get_link
);
can_ok( 'PNI::Slot::Out', $_ ) for qw(
  new
  add_link
  del_link
  get_links
);

done_testing;
