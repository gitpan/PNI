use strict;
use Test::More;
use PNI::Finder;

my $find  = PNI::Finder->instance;
my $find2 = PNI::Finder->instance;

is $find , $find2, 'PNI::Finder is a singleton';

print for $find->files;

done_testing
__END__
