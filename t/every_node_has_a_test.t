use strict;
use Test::More;
use File::Spec;
use PNI::Finder;

if ( not $ENV{TEST_AUTHOR} ) {
    my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
    plan( skip_all => $msg );
}

my $find = PNI::Finder->new;

my @core_nodes_dirs;
my $node_dir_path = File::Spec->catfile(qw(lib PNI Node));
opendir my ($node_dir_handle), $node_dir_path;
for my $entry ( readdir $node_dir_handle ) {

    # looking for dirs starting with an uppercase letter
    next unless -d File::Spec->catfile( $node_dir_path, $entry );
    next unless $entry =~ /^[A-Z][a-z]+/;

    push @core_nodes_dirs, $entry;
}

my $core_nodes_dirs_regexp = join '|', @core_nodes_dirs;

for my $node_class ( $find->nodes ) {

    # skip check on nodes not included in PNI core
    next if $node_class !~ /^($core_nodes_dirs_regexp)/;

    # naming convention for test of PNI::Node::Foo::Bar is _node-foo-bar.t
    my $node_test = $node_class;
    $node_test =~ s/^PNI:://;
    $node_test =~ s/::/-/g;
    $node_test = lc "_node-$node_test.t";
    my $test_path = File::Spec->catfile( 't', $node_test );
    ok -e $test_path, "$node_class has a test";
}

done_testing;

