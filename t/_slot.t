use strict;
use Test::More;
use PNI;
use PNI::Slot;
use PNI::Slot::In;

# create a generic slot for an empty node
# ... this doesn't make sense except testing the Slot constructor
my $slot = PNI::Slot->new( node => PNI::NODE, name => 'slot_test' );
isa_ok( $slot, 'PNI::Slot' );

ok( $slot->set_data(1), 'set_data 1' );
is( $slot->get_data, 1, 'get_data 1' );

ok( $slot->set_data(undef), 'set_data undef' );
is( $slot->get_data, undef, 'get_data undef' );

my $slot_in = PNI::Slot::In->new( node => PNI::NODE, name => 'slot_in' );
isa_ok( $slot_in, 'PNI::Slot::In' );
is( $slot_in->get_link,undef,'get_link undef');

done_testing();
