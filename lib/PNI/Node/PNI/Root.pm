package PNI::Node::PNI::Root;
use parent 'PNI::Node';
use strict;
use PNI;

sub init {
    my $node = shift;

    $node->add_output( 'object', data => PNI::root );
}

sub task { 1 }

1
__END__

