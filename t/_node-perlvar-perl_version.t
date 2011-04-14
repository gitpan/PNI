use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Perlvar::Perl_version';
isa_ok $node, 'PNI::Node';

# check default values
ok $node->task;

is $node->get_output('out')->get_data, $^V;

done_testing;
__END__
