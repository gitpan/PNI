use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Chomp';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Chomp';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');

my $string = 'abc';
ok $in->set_data($string);
ok $node->task;
chomp $string;
is $out->get_data, $string, 'chomp $string';

my @list      = ( "foo\n", "bar" );
my @same_list = ( "foo\n", "bar" );
my $list_ref  = \@list;
ok $in->set_data($list_ref);
ok $node->task;
chomp @same_list;
my $same_list_ref = \@same_list;
is_deeply $out->get_data, $same_list_ref;

done_testing;
__END__
