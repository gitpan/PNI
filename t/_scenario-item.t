use strict;
use Test::More;
use PNI::Scenario;
use PNI::Scenario::Item;
use PNI::Error;

my $scenario = PNI::Scenario->new;
my $item = PNI::Scenario::Item->new( scenario => $scenario );
isa_ok $item, 'PNI::Scenario::Item';

is $item->get_hierarchy, $scenario->get_hierarchy, 'get_hierarchy';

# tell PNI::Error to be silent for next tests
PNI::Error::verbose_off;

# passing wrong parameters to constructor
my $undef_item1 = PNI::Scenario::Item->new;
is $undef_item1, undef, 'scenario arg is required';
my $undef_item2 = PNI::Scenario::Item->new(
    scenario => bless {},
    'Foo'
);
is $undef_item2, undef, 'and it must be a PNI::Scenario';

done_testing;
