use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Print', inputs => {
    do_print => 1,
    list     => ['Hello World','!',"\n"],
};

ok task;

done_testing;
__END__
