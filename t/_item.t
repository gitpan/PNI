use strict;
use Test::More;
use PNI::Error;
use PNI::Item;

my $item = PNI::Item->new;
isa_ok $item, 'PNI::Item';

is $item->id, ${$item}, 'id';

is $item->has('foo'), 0, 'item has no attribute foo';
ok $item->add('foo'), 'add attribute foo to the item';
is $item->has('foo'), 1, 'item has attribute foo';
# this test will complain
PNI::Error::verbose_off;
is $item->add('foo'), undef, 'try to override attribute foo';
PNI::Error::verbose_on;
is $item->has('foo'), 1, 'item still has attribute foo';
is $item->get('foo'), undef, 'attribute foo now is undef';
is $item->has('foo'), 1, 'item still has attribute foo';
ok $item->set( foo => 'bar' ), 'set attribute foo = bar';
is $item->get('foo'), 'bar', 'get attribute foo';
is $item->has('foo'), 1, 'item still has attribute foo';
is $item->del('foo'), 1, 'del attribute foo';
is $item->has('foo'), 0, 'item has no attribute foo anymore';

done_testing;
__END__
