use strict;
use Test::More;
use PNI ':-D';

my $node = node 'Perlfunc::Length';
isa_ok $node, 'PNI::Node';
isa_ok $node, 'PNI::Node::Perlfunc::Length';

# check default values
ok $node->task;

my $in  = $node->get_input('in');
my $out = $node->get_output('out');
ok $node->task;

$in->set_data('12345');
ok $node->task;
is $out->get_data, ( length('12345') ), 'length(\'12345\')';

$in->set_data('abc');
ok $node->task;
is $out->get_data, ( length('abc') ), 'length(\'abc\')';

my $string = 'hello';
$in->set_data($string);
ok $node->task;
is $out->get_data, ( length($string) ), 'length($string)';

$in->set_data('12345');
ok $node->task;
is $out->get_data, ( length('12345') ), 'length(\'12345\')';

done_testing;
__END__
