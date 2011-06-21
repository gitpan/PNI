use strict;
use Test::More;
use PNI::Finder;

my $find  = PNI::Finder->new;
my $find2 = PNI::Finder->new;

is $find , $find2, 'PNI::Finder is a singleton';

ok $find->nodes, 'nodes';

done_testing;
__END__
