use strict;
use Test::More;
use PNI;

my $node = PNI::NODE 'Perlfunc::Cos';
isa_ok( $node, 'PNI::Node' );

# check slots
my $in  = $node->get_input('in');
my $out = $node->get_output('out');
isa_ok $in,  'PNI::Slot::In';
isa_ok $out, 'PNI::Slot::Out';

# check default values
ok( $node->task );

$in->set_data(0);
ok $node->task;
is $out->get_data, ( cos(0) ), 'cos(0)';

$in->set_data(1);
ok $node->task;
is $node->get_output('out')->get_data, ( cos(1) ), 'cos(1)';

TODO: {

    local $TODO = 'check cos input type ... to be implemented';

    # tell PNI::Error to be silent for next tests
    PNI::Error::verbose_off;

    #$in->set_data('xxx');
    is $node->task, undef, 'passing string value to cos';
}

done_testing;

