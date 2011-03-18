use strict;
use Test::More;
use PNI;

# calculate sin( cos( x ) )

my $sin = PNI::NODE 'Perlfunc::Sin';
my $cos = PNI::NODE 'Perlfunc::Cos';

PNI::LINK $cos => $sin , 'out' => 'in';

PNI::RUN;

TODO: { local $TODO = 'add appropiate checks to complete example'; ok(0) }

done_testing();


