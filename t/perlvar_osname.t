use Test::More tests => 1;
use PNI;

my $node = PNI::NODE 'Perlvar::Osname';

PNI::RUN;

cmp_ok( $node->get_output('OSNAME') , 'eq' , $^O , "OSNAME is $^O" );
