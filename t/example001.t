use strict;
use Test::More tests => 1;
use PNI;

my $join_node = PNI::NODE 'Perlfunc::Join' , list => [ 'Hello' , 'World' , "\n" ];

my $print_node = PNI::NODE 'Perlfunc::Print' , do_print => 1;

PNI::LINK $join_node => $print_node , 'out' => 'list';

ok( PNI::RUN );
