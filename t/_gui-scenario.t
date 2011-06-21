use strict;
use PNI::GUI::Scenario;
use PNI::Scenario;
use Test::More;

my $scenario = PNI::Scenario->new;
my $gui_scenario = PNI::GUI::Scenario->new( scenario => $scenario );
isa_ok $gui_scenario, 'PNI::GUI::Scenario';

done_testing;
__END__
