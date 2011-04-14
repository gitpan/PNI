use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Perldata::Array';
isa_ok $node, 'PNI::Node';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

my $array_ref = [qw(foo bar)];
ok $in->set_data($array_ref);
ok $node->task;
is_deeply $out->get_data, $array_ref, 'array input';

my $scalar = 'foo';
ok $in->set_data($scalar);
ok $node->task;
is $out->get_data, undef, 'scalar input';

done_testing;
__END__
