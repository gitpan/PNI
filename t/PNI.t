# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl PNI.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { use_ok('PNI') };

use_ok( 'PNI::Node' );
use_ok( 'PNI::Link' );
use_ok( 'PNI::Tree' );

#TODO vedi come aggiungere i vari methodi dei moduli
#     documenta il metodo e lo inserisci qua
#
#my $modules = ( )
#can_ok( $_ , @{ $_->{methods} } ) for ();

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

