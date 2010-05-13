use strict;
use Test::More;
use File::Find;
use PNI;

my @nodes = ();
my $dir = './lib/PNI/Node/'; # keep the last slash.

sub wanted {
    return unless /\.pm$/;
    push @nodes , $File::Find::name;
}

&find( \&wanted , $dir );

my $number_of_tests_run = ( $#nodes + 1 ) * 3;

for my $node_path ( @nodes ) {

    my $node_class = $node_path;
    $node_class =~ s!$dir!!;
    $node_class =~ s!/!::!g;
    $node_class =~ s/\.pm$//;
    my $node = PNI::NODE $node_class;
    ok( $node , 'PNI::NODE ' . $node_class );
    isa_ok( $node , 'PNI::Node' );
    can_ok( $node , qw( init task ) );
}

&done_testing( $number_of_tests_run );
