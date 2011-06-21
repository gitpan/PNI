package PNI;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use Exporter 'import';
use PNI::Edge;
use PNI::Finder;
use PNI::Node;
use PNI::Scenario;
use Time::HiRes;

# use PNI ':-D';
# exports edge, node and task
our @EXPORT_OK = qw(edge node task);
our %EXPORT_TAGS = ( '-D' => \@EXPORT_OK );

# root scenario
my $root = PNI::Scenario->new;

# return $edge
sub edge {
    my $source_node        = shift;
    my $target_node        = shift;
    my $source_output_name = shift;
    my $target_input_name  = shift;

    my $source_output = $source_node->get_output($source_output_name);
    my $target_input  = $target_node->get_input($target_input_name);

    return $root->add_edge(
        source => $source_output,
        target => $target_input
    );
}

# return 1
sub loop {
    while (1) {
        task();
        Time::HiRes::usleep(1);
    }
    return 1;
}

# return $node
sub node {
    my $type = shift;
    return $root->add_node( type => $type, @_ );
}

# node finder
my $find = PNI::Finder->new;

# return @nodes
sub node_list { return $find->nodes; }

# return $root
sub root { return $root; }

# return 1
sub task { return $root->task; }

1;
__END__

=head1 NAME

PNI - Perl Node Interface


=head1 ATTENTION

This module was created to be used internally by a GUI, anyway you are free to use the scripting api if it does make sense.

=head1 SYNOPSIS

    use PNI ':-D'; # imports node, edge and task

    my $node = node 'Perlfunc::Print';
    $node->get_input('list')->set_data('Hello World !');
    $node->get_input('do_print')->set_data(1);

    task;

=head1 DESCRIPTION

Hi! I'm an italian mathematician. 
I really like Perl phylosophy as Larry jokes a lot even if 
he is one of the masters of hacking.

PNI stands for Perl Node Interface.

It is my main project, my contribution to the great Perl community. 
Node programming is really interesting since makes possible to realize
a program even if you have no idea about programming. 

Think about genetic researchers, for example. 
They need to focus on protein chains, not on what is a package.
Maybe they can do an extra effort and say the world "variable" or "string" 
or even "regular expression" and that makes them proud, 
but they don't care about inheritance.

They want things working and they need Perl ... 
but if you say Strawberry they think about yogurt, not about Windows.

There are a lot of node programming languages (VVVV, Puredata, Max/Msp) 
but normally they target artists and interaction designers.
I saw a lot of vjs and musicians do really complex programs
with those software, and they never wrote a line of code.

This is my effort to provide a node interface that brings Perl power 
to people who don't know the Perl language.

Blah blah blah. ( this was the h2xs command :-)

=head1 METHODS

=head2 C<edge>

Connects an output of a node to an input of another node.

    my $source_node = node 'Some::Node';

    my $target_node = node 'Another::Node';

    my $edge = edge 
      $source_node         => $target_node , 
      'source_output_name' => 'target_input_name';

This method delegates to L<PNI::Edge> constructor.

=head2 C<node>

Creates a node by its PNI type, that is the name of a package 
under the PNI::Node namespace. If you write

    my $node = node 'Some::Node';

PNI do the following steps:

=over 4

=item 1)

requires the PNI/Node/Some/Node.pm module.

=item 2)

creates a new PNI::Node, assigns it an id 
and bless it as a PNI::Node::Some::Node.

=item 3)

calls the init method as implemented in the PNI::Node::Some::Node package.

=item 4)

adds the node to the root PNI::Scenario.

=back

If no PNI type is passed, and you just write

    my $node = node;
    
PNI creates an empty node.

This method delegates to L<PNI::Node> constructor.

=head2 C<node_list>

    my @nodes = PNI::node_list;

Returns a list of available PNI nodes.

This method delegates to L<PNI::Finder> C<nodes> method.

=head2 C<task>

Calls the task method for every loaded node.
This method delegates to the root scenario task method.

=head2 C<loop>

Starts the PNI main loop. It keeps calling C<task> as fast as it can.

=head2 C<root>

    my $root = PNI::root;

Returns the root PNI::Scenario.

=head1 SEE ALSO

L<PNI::Edge>

L<PNI::Node>

L<PNI::Scenario>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
