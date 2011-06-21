use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perldata::Scalar';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perldata::Scalar';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

my $scalar = 'foo';
ok $in->set_data($scalar);
ok $node->task;
is $out->get_data, $scalar, 'scalar input';

my $array_ref = [qw(foo bar)];
ok $in->set_data($array_ref);
ok $node->task;
is $out->get_data, undef, 'array input';

done_testing;
__END__
