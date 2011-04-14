use strict;
use Test::More;
use PNI::Find;

my $find  = PNI::Find->new;
my $find2 = PNI::Find->new;

is $find , $find2, 'PNI::Find is a singleton';

ok $find->nodes, 'nodes';

done_testing;
