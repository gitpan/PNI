use strict;
use Test::More;
use PNI;

# calculate sin( cos( x ) )

my $sin = PNI::node 'Perlfunc::Sin';
my $cos = PNI::node 'Perlfunc::Cos';

PNI::LINK $cos => $sin, 'out' => 'in';

for my $in_data ( 0, 1, 0.5 ) {
    
	$cos->get_input('in')->set_data($in_data);
    
	ok PNI::step;
    
	is $sin->get_output('out')->get_data, sin( cos($in_data) ),
      "sin( cos( $in_data ) )";
}

done_testing;

