package PNI;
use strict;
use warnings;
our $VERSION = '0.1';
use 5.8.8;
use PNI::Hierarchy;
use File::Find;
use Time::HiRes('usleep');

# there is only one PNI root
my $root = PNI::Hierarchy->new;

sub ROOT { return $root }

sub LINK {
    my $source_node        = shift;
    my $target_node        = shift;
    my $source_output_name = shift;
    my $target_input_name  = shift;

    my $source_output = $source_node->get_output($source_output_name);
    my $target_input  = $target_node->get_input($target_input_name);

    return ROOT->add_link( source => $source_output, target => $target_input );
}

sub NODE {
    my $node_type = shift;
    return ROOT->add_node( type => $node_type, @_ );
}

sub RUN {
    return ROOT->task;
}

sub LOOP {
    while (1) {
        RUN;
        usleep(1);
    }

    return 1;
}

1;
__END__

=head1 NAME

PNI - Perl Node Interface

=head1 SYNOPSIS

  use PNI;

  my $node = PNI::NODE 'Perlfunc::Print';
  $node->set_input( list => 'Hello World !' );
  $node->set_input( do_print => 1 );

  PNI::RUN;

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

=head2 EXPORT

PNI module does not export subs, you have to call them directly. 
They are all uppercase and you can omit parenthesis, like

  PNI::NODE 'Some::Node';

  PNI::RUN;

They often delegates to other modules methods inside the PNI namespace.

=head1 SUBROUTINES/METHODS

=over

=item PNI::LINK

Connects an output of a node to an input of another node.

  my $source_node = PNI::NODE 'Some::Node';

  my $target_node = PNI::NODE 'Another::Node';

  PNI::LINK $source_node => $target_node , 'source_output_name' => 'target_input_name';

=item PNI::NODE

Creates a node by its pni type. If you write

  PNI::NODE 'Some::Node'

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

adds the node to the root hierarchy

=back

=item PNI::RUN

Updates the tree node hierarchy and calls the task method for every loaded node.

=item PNI::LOOP

Starts the PNI main loop, it keeps calling PNI::RUN as fast as it can.

=back

=head1 SEE ALSO

L<PNI::Node::Perlfunc>

L<PNI::Node::Perlop>

L<PNI::Node::Perlvar>

=cut

# If you have a mailing list set up for your module, mention it here.

# If you have a web site set up for your module, mention it here.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself .

=cut

