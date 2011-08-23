use strict;
use PNI::GUI::Comment;
use Test::More;

my $center_y = 10;
my $center_x = 10;
my $content = 'This is a comment';
my $comment  = PNI::GUI::Comment->new(
    center_y => $center_y,
    center_x => $center_x,
    content => $content,
);
isa_ok $comment, 'PNI::GUI::Comment';

is $comment->get_center_y,$center_y,'get_center_y';
is $comment->get_center_x,$center_x,'get_center_x';
is $comment->get_content,$content,'get_content';

done_testing;
__END__

