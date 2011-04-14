use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Scalar::Util::Looks_like_number';
isa_ok $node, 'PNI::Node';

# check default values
ok $node->task;

done_testing;
__END__
