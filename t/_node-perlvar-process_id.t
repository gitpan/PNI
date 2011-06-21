use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlvar::Process_id';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlvar::Process_id';

# check default values
ok $node->task;

is $node->get_output('out')->get_data, $$;

done_testing;
__END__
