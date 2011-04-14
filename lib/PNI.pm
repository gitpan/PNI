package PNI;
use strict;
use warnings;
our $VERSION = '0.12';
use 5.008008008;
use PNI::Find;
use PNI::Hierarchy;
use PNI::Link;
use PNI::Node;
use File::Spec;
use Time::HiRes('usleep');

# PNI::Find is a singleton
sub find { return PNI::Find->new; }

# there is only one PNI root
my $root = PNI::Hierarchy->new;
sub root { return $root; }

sub LINK {
    my $source_node        = shift;
    my $target_node        = shift;
    my $source_output_name = shift;
    my $target_input_name  = shift;

    my $source_output = $source_node->get_output($source_output_name);
    my $target_input  = $target_node->get_input($target_input_name);

    my $link = PNI::Link->new(
        source => $source_output,
        target => $target_input
    ) or return;

    return root->add_link($link);
}

sub node {

    # return an empty node if no arg is provided
    my $type = shift or return PNI::Node->new;

    my $node = PNI::Node->new( type => $type, @_ ) or return;

    return root->add_node($node);
}

sub step {
    return root->task;
}

sub LOOP {
    while (1) {
        step;
        usleep(1);
    }

    return 1;
}

1;

=head1 NAME

PNI - Perl Node Interface

=head1 ATTENTION

This module was created to be used by a GUI, anyway you are free to use the scripting api if it does make sense.

=head1 SYNOPSIS

use PNI;

    my $node = PNI::node 'Perlfunc::Print';
    $node->get_input('list')->set_data('Hello World !');
    $node->get_input('do_print')->set_data(1);

    PNI::step;

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

No method is exported by PNI, you have to call them directly .

=item PNI::find



=item PNI::LINK

Connects an output of a node to an input of another node.

    my $source_node = PNI::node 'Some::Node';

    my $target_node = PNI::node 'Another::Node';

    my $link = PNI::LINK 
      $source_node => $target_node , 
      'source_output_name' => 'target_input_name';

Delegates to PNI::Link constructor .

=item PNI::node

Creates a node by its pni type. If you write

    my $node = PNI::node 'Some::Node';

PNI do the following steps:

=over 4

=item 1

requires the PNI/Node/Some/Node.pm module .

=item 2

creates a new PNI::Node, assigns it an id 
and bless it as a PNI::Node::Some::Node .

=item 3

calls the init method as implemented in the PNI::Node::Some::Node package .

=item 4

adds the node to the root hierarchy .

=back

If no type is passed, and you just write

    my $node = PNI::node;
    
PNI creates an empty node that can be decorated later .

Delegates to PNI::Node constructor .

=item PNI::root

Returns the root hierarchy which is a PNI::Hierarchy created at startup .

=item PNI::step

Updates the root hierarchy and calls the task method for every loaded node .

=item PNI::LOOP

Starts the PNI main loop . It keeps calling PNI::step as fast as it can.

=back

=head1 SEE ALSO

L<PNI::Node::Perlfunc>

L<PNI::Node::Perlop>

L<PNI::Node::Perlvar>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
