use strict;
use PNI::GUI::Edge;
use Test::More;

my $gui_edge = PNI::GUI::Edge->new;
isa_ok $gui_edge, 'PNI::GUI::Edge';

isa_ok $gui_edge->get_edge, 'PNI::Edge';

done_testing;
__END__

