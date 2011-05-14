use strict;
use Test::More;
use PNI::Node;
use PNI::Scenario;

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

done_testing;
__END__
