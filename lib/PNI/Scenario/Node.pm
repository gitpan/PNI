package PNI::Scenario::Node;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Scenario::Item';
use PNI::Error;

my $border_width = 10;

sub new {
    my $class = shift;
    my $arg = {@_} or return;

    # center arg is required
    # center represents a point and is a reference to an array with two elements
    my $center = $arg->{center} or return PNI::Error::missing_required_argument;

    # node arg defaults to an empty PNI::Node
    my $node = $arg->{node} || PNI::Node->new;

    # default label is last part of node package
    my $node_package = ref $node;
    my $label        = $node_package;
    $label =~ s/.*::(.*)$/$1/;

    # default height
    my $height = 20;

    # default width = border width + defualt character width * label length
    my $width = $border_width + 6 * length $label;

    my $self = $class->SUPER::new(@_) or return;

    $self->add( center => $center );
    $self->add( height => $height );
    $self->add( label  => $label );
    $self->add( node   => $node );
    $self->add( width  => $width );

    # add node to hierarchy
    $self->get_hierarchy->add_node($node) or return;

    return $self;
}

sub get_center { return shift->get('center'); }

sub get_center_x { return shift->get_center->[0]; }

sub get_center_y { return shift->get_center->[1]; }

sub get_height { return shift->get('height'); }

sub get_label { return shift->get('label'); }

sub get_node { return shift->get('node'); }

sub get_width { return shift->get('width'); }

sub set_height {
    my $self   = shift;
    my $height = shift;
    return $self->set( height => $height );
}

sub set_width {
    my $self  = shift;
    my $width = shift;
    return $self->set( width => $width );
}

sub set_center {
    my $self = shift;
    my $center = shift or return PNI::Error::missing_required_argument;
    $self->set( center => $center );
    return 1;
}

1;

