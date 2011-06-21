use strict;
use Test::More;
use PNI ':-D';

# calculate sin( cos( x ) )

ok my $cos = node 'Perlfunc::Cos';
ok my $sin = node 'Perlfunc::Sin';

edge $cos => $sin, 'out' => 'in';

for my $in_data ( 0, 1, 0.5 ) {
    
	$cos->get_input('in')->set_data($in_data);
    
	ok task;
    
	is $sin->get_output('out')->get_data, sin( cos($in_data) ),
      "sin( cos( $in_data ) )";
}

done_testing;
__END__
