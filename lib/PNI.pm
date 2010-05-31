package PNI;

use 5.8.8;
use strict;
use warnings;

our $VERSION = '0.03';

use PNI::Tree;
use PNI::Node;

use File::Find;
use Time::HiRes( 'usleep' );

my $PNI_is_running = 0;
my $num_of_runs = 0;

sub LINK { return PNI::Tree::add_link( @_ ) }

sub NODE { return PNI::Tree::add_node( @_ ) }

sub NODECOLLECTION { 
    my $node_collection = {};
    # prima cerco le PNI/Node
    #&find( , @INC );

    # poi nelle cartelle che trovo cerco i .pod, ognuno dei quali è
    # una categoria
    
    # poi per ogni categoria cerco i .pm, ognuno dei quali è un nodo
    # quindi aggiungo all hash $node_collection

    for my $dir ( @INC ) {

        # TODO ci vorrebbe qualche modulo per gestire i path
        #      in maniera portabile. L' ho trovato, è File::Spec
        my $pni_node_dir = $dir . '/PNI/Node';
        next unless -d $pni_node_dir;
        &find( { 
                wanted => sub { 
                    return unless s/\.pod$//; 
                    $node_collection->{$_} = [] ;
                    #print; 
                } , 
                follow => 1 
            } , ($pni_node_dir) );
        for my $category ( keys %{ $node_collection } ) {

            &find( {
                wanted => sub {
                    return unless s/\.pm$//;

                    # TODO gestisco per ora solo 1 + 1 livello
                    push @{ $node_collection->{$category} } , $_;

                }
                } , ($pni_node_dir . '/' . $category ) )
        }
    }

    return $node_collection
}

sub OBJECT {
    #PER ORA NON DOCUMENTATA NE IMPLEMENTATA

    #TODO dalla 0.04 qui metti
    # ID++ , bless della classe al riferimento dell' id
    # poi forse in futuro controlli sul caller (sia file che package) 
    # e su quali classi instanziano quali oggetti
    # ad esempio Tree non puo instanziare Slot, Node lo puo fare.
    # documenta nel diagramma PNI.dia o vedi se si puo fare con il plugin
    # di vi per disegnare in ascii.
    #

    # pensa anche a fare una classe contenitrice di oggetti, ci sarà un pattern

}

sub RUN { 
    # prevent PNI::RUN is called inside a PNI::Node task method.
    return if $PNI_is_running;
    $PNI_is_running = 1;

    $num_of_runs++;

    PNI::Tree::update_hierarchy;
    PNI::Tree::do_tasks;
    usleep( 1 );
    
    $PNI_is_running = 0;

    return $num_of_runs
}

sub LOOP {
    # prevent PNI::LOOP is called inside a PNI::Node task method.
    return if $PNI_is_running;

    while( 1 ) { RUN }

    # never reach here
    exit
}

1;
__END__

=head1 NAME

PNI - Perl Node Interface

=head1 SYNOPSIS

  use PNI;

  my $node = PNI::NODE 'Perlfunc::Print';
  $node->input->{message} = 'Hello World !';
  $node->input->{do_print} = 1;

  PNI::RUN
  
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
or even "regular expression" and that makes them proud, but they don't care about inheritance.

They want things working and they need Perl ... 
but if you say Strawberry they think about yogurth, not about Windows.

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

=head2 SUBS

=over

=item PNI::LINK

Connects an output of a node to an input of another node.
Delegates to PNI::Tree::add_link.

=item PNI::NODE

Creates a node by its pni type. If you write

=over 4

  PNI::Node 'Some::Node'

=back

PNI do the following steps:

=over 4

=item 1

requires the PNI/Node/Some/Node.pm module.

=item 2

creates a new PNI::Node assigns it an id 
and bless it as a PNI::Node::Some::Node.

=item 3

calls the init method as implemented in the 
PNI::Node::Some::Node package.

=back

Delegates to PNI::Tree::add_node.

=item PNI::NODECOLLECTION

Returns available nodes in an hash reference like this:

=over4

$node_collection = {
    node_category1 => [ qw( /node/path1 , /node/path2 , ... ) ],
    node_category2 => [ qw( /node/path1 , /node/path2 , ... ) ], 
    ...
}

=back

=item PNI::RUN

Updates the tree node hierarchy and calls 
the task method of every loaded node.

=item PNI::LOOP

Starts the PNI main loop, it keeps calling PNI::RUN as fast as it can.

=back

=head1 SEE ALSO

PNI::Node
PNI::Tree
PNI::Link
PNI::Node::Perlfunc
PNI::Node::Perlop

=cut

# If you have a mailing list set up for your module, mention it here.

# If you have a web site set up for your module, mention it here.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by G. Casati

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

