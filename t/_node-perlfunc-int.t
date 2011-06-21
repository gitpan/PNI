use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Int';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Int';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

$in->set_data( 7 / 6 );
ok task;
is $out->get_data, int 7 / 6;

$in->set_data( -1 / 5 );
ok task;
is $out->get_data, int -1 / 5;

$in->set_data('string');
ok task;
is $out->get_data, undef;

done_testing;
__END__
