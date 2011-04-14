use strict;
use Test::More;
use PNI;

my $node = PNI::node 'Perlfunc::Print';
isa_ok $node, 'PNI::Node';

# check default values
ok $node->task;

my $do_print = $node->get_input('do_print');
my $list     = $node->get_input('list');

ok $list->set_data('Hello');
TODO: {
    local $TODO = 'need to check stdout output witn Test::More';
    $node->task;
}

done_testing;
__END__
