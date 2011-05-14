use strict;
use Test::More;
use PNI::Item;

my $item = PNI::Item->new;
isa_ok $item, 'PNI::Item';

is $item->id, ${$item}, 'id';

ok $item->add('foo'), 'add attribute foo to the item';
is $item->add('foo'), undef, 'try to override attribute foo';

ok $item->set( foo => 'bar' ), 'set attribute foo';
is $item->get('foo'), 'bar', 'get attribute foo';

done_testing;
