use Test::More tests => 1;

use File::Find;

my $there_is_a_pod_for_every_PNI_Node_dir = 1;
my $dir = './lib/PNI/Node';

sub wanted {

    return unless /(.*)\.pod/;

    return if $File::Find::name =~ /\.svn/;

    $there_is_a_pod_for_every_PNI_Node_dir = 0 unless -d $1
}

&find( \&wanted , $dir );

ok( $there_is_a_pod_for_every_PNI_Node_dir , 'there is .pod for every PNI/Node/dir' );
