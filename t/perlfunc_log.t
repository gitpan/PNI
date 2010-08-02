use strict;
use Test::More tests => 2;
use PNI;

ok( my $node = PNI::NODE 'Perlfunc::Log' );

# TODO aggiungi il test sul contrllo dell' input che non può essere nullo.

ok( PNI::RUN );

