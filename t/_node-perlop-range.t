use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlop::Range';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlop::Range';

# check default values
ok $node->task;

my $in1 = $node->get_input('in1');
my $in2 = $node->get_input('in2');
my $out = $node->get_output('out');

my @range;
my $start;
my $end;

sub check_range {
    my $start = shift;
    my $end   = shift;
    my @range = $start .. $end;
    ok $in1->set_data($start);
    ok $in2->set_data($end);
    ok task;
    is_deeply $out->get_data, \@range;
}

check_range( -1,   1 );
check_range( 1,    1 );
check_range( 1,    10 );
check_range( 10,   10 );
check_range( 'a',  'z' );
check_range( 'xx', 'yy' );

done_testing;
__END__
