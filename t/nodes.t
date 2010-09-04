use strict;
use Test::More;
use File::Find;
use PNI;
use PNI::Node;

# TODO metti questo algoritmo in PNI::NODECOLLECTION
# poi da qui chiami PNI::NODECOLLECTION

#use Data::Dumper;

#print STDOUT Data::Dumper::Dump( &PNI::NODECOLLECTION );

my @nodes = ();
my $dir   = './lib/PNI/Node/';    # keep the last slash.

sub wanted {
    return unless /\.pm$/;
    push @nodes, $File::Find::name;
}

find( \&wanted, $dir );

my $number_of_tests_run = ( $#nodes + 1 ) * 5;

for my $node_path (@nodes) {

    my $node_class = $node_path;
    $node_class =~ s!$dir!!;
    $node_class =~ s!/!::!g;
    $node_class =~ s/\.pm$//;

    my $node = PNI::NODE $node_class;

    ok( $node, "create node $node_class" );

    # created node is ok .
    isa_ok( $node, 'PNI::Node' );
    can_ok( $node, 'init' );
    can_ok( $node, 'task' );

    # TODO per ora questo test non mi va a buon fine per tutti
  TODO: {
        local $TODO = "give a first run  with default values to $node_class";
        ok( $node->task(), "run $node_class task" );
    }
}

done_testing($number_of_tests_run);
