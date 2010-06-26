use Test::More tests => 10;

BEGIN { use_ok('PNI') };

use_ok( 'PNI::Node' );
use_ok( 'PNI::Link' );
use_ok( 'PNI::Tree' );

can_ok( 'PNI' , 'NODE' );
can_ok( 'PNI' , 'LINK' );

can_ok( 'PNI::Node' , 'add_input' );
can_ok( 'PNI::Node' , 'add_output' );
can_ok( 'PNI::Node' , 'del_input' );
can_ok( 'PNI::Node' , 'del_output' );


