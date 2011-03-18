package PNI::Scenario::Link;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Scenario::Item';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};

    # link arg is required and it must be a PNI::Link
    my $link = $arg->{link} or return PNI::Error::missing_required_argument;
    $link->isa('PNI::Link') or return PNI::Error::invalid_argument_type;

    # start arg is required
    # start represents a point
    # and is a reference to an array with two elements
    my $start = $arg->{start} or return PNI::Error::missing_required_argument;

    # end arg is required
    # end represents a point
    # and is a reference to an array with two elements
    my $end = $arg->{end} or return PNI::Error::missing_required_argument;

    my $self = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add( end   => $end );
    $self->add( link  => $link );
    $self->add( start => $start );

    return $self;
}

sub get_end { return shift->get('end'); }

sub get_start { return shift->get('start'); }

sub set_end {
    my $self = shift;
    my $end = shift or return PNI::Error::missing_required_argument;
    $self->set( end => $end );
    return 1;
}

sub set_start {
    my $self = shift;
    my $start = shift or return PNI::Error::missing_required_argument;
    $self->set( start => $start );
    return 1;
}

1;

