use strict;
use Test::More;
use PNI::File;
use PNI::Scenario;

my $scenario = PNI::Scenario->new;
isa_ok $scenario, 'PNI::Scenario';

#my $file = PNI::File->new(
#    path     => [ 't', 'first_file' ],
#    scenario => $scenario,
#);
#ok $scenario->set_file($file);
#
#ok $scenario->load_file;
#
#ok $scenario->task;

isa_ok $scenario->add_scenario, 'PNI::Scenario';

done_testing;
__END__
