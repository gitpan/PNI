use strict;
use Test::More tests => 19;

BEGIN {
    use_ok('PNI');
    use_ok('PNI::Node');
    use_ok('PNI::Link');
    use_ok('PNI::Tree');
}

can_ok( 'PNI', 'NODE' );
can_ok( 'PNI', 'LINK' );
can_ok( 'PNI', 'NODECOLLECTION' );

can_ok( 'PNI::Node', 'add_input' );
can_ok( 'PNI::Node', 'get_input' );
can_ok( 'PNI::Node', 'set_input' );
can_ok( 'PNI::Node', 'add_output' );
can_ok( 'PNI::Node', 'get_output' );
can_ok( 'PNI::Node', 'set_output' );

can_ok( 'PNI::Node', 'input_names' );
can_ok( 'PNI::Node', 'output_names' );
can_ok( 'PNI::Node', 'type' );

TODO: {
    local $TODO = 'not implemented methods';
    can_ok( 'PNI::Node', 'del_output' );
    can_ok( 'PNI::Node', 'del_input' );
    can_ok( 'PNI',       'NODEDIR' );
}

