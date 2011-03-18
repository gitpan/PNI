use strict;
use Test::More tests => 1;

ok(1);

# PNI.pm SYNOPSIS start

use PNI;

my $node = PNI::NODE 'Perlfunc::Print';
$node->get_input('list')->set_data('Hello World!');
$node->get_input('do_print')->set_data(1);

PNI::RUN;

# PNI.pm SYNOPSIS end

