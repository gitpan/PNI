use strict;
use Test::More;
use PNI;

my $node1 = PNI::node 'Perlop::Not';
isa_ok($node1,'PNI::Node');

my $node2 = PNI::node 'Perlop::Not';
isa_ok($node2,'PNI::Node');

my $link = PNI::LINK $node1 => $node2 , 'out' => 'in';
isa_ok($link,'PNI::Link');

ok PNI::step;

done_testing;
