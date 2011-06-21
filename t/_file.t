use strict;
use File::Spec;
use PNI::File;
use PNI::Scenario;
use Test::More;

my $scenario = PNI::Scenario->new;

my $file = PNI::File->new( scenario => $scenario );
isa_ok $file, 'PNI::File';

ok $file->set_dir( ['t'] ), 'set_dir';
ok $file->set_name( 'first_file' ), 'set_name';
is $file->path, File::Spec->catfile('t','first_file'.'.pni'),'path';

ok $file->get_edges;
ok $file->get_nodes;

done_testing;
__END__

