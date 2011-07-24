use strict;
use File::Spec;
use JSON;
use PNI::File;
use PNI::Scenario;
use Test::More;

my $scenario = PNI::Scenario->new;

my $file = PNI::File->new( scenario => $scenario );
isa_ok $file, 'PNI::File';

my $path = File::Spec->catfile( 't', 'first_file.pni' );
ok $file->set_path($path), 'set_path';
is $file->get_path, $path, 'get_path';

local $/;
open my $fh,'<',$path;
my $text = <$fh>;
my $content = decode_json($text);
close $fh;

is_deeply $file->get_content,$content,'get_content';

done_testing;
__END__

