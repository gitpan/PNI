use strict;
use File::Spec;
use JSON;
use PNI::File;
use Test::More;

my $path = File::Spec->catfile( 't', 'first_file.pni' );
my $file = PNI::File->new(path=>$path);
isa_ok $file, 'PNI::File';

is $file->get_path, $path, 'get_path';

local $/;
open my $fh, '<', $path;
my $text    = <$fh>;
my $content = decode_json($text);
close $fh;

is_deeply $file->get_content, $content, 'get_content';

# if not provided, $path defaults to a temporary file
my $empty_content = { edges => {}, nodes => {}, };
my $file2 = PNI::File->new;
ok $file2->get_path;
is_deeply $file2->get_content, $empty_content, 'empty_content';

ok $file2->set_content($content);
is_deeply $file->get_content, $file2->get_content, 'overwrite content';

done_testing;
__END__

