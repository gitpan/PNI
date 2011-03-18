package PNI::Scenario;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Item';
use PNI::Hierarchy;
use PNI::Scenario::Link;
use PNI::Scenario::Node;

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new;

    my $hierarchy = PNI::Hierarchy->new;
    $self->add( 'hierarchy' => $hierarchy );

    $self->add( 'nodes' => {} );
    $self->add( 'links' => {} );
    $self->add( 'name'  => 'Untitled' );
    return $self;
}

sub add_link {
    my $self = shift;
    my $link = PNI::Scenario::Link->new( @_, scenario => $self ) or return;
    $self->get('links')->{ $link->id } = $link;
    return $link;
}

sub add_node {
    my $self = shift;
    my $node = PNI::Scenario::Node->new( @_, scenario => $self ) or return;
    $self->get('nodes')->{ $node->id } = $node;
    return $node;
}

sub get_hierarchy { return shift->get('hierarchy'); }

1;
