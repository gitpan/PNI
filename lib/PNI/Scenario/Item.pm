package PNI::Scenario::Item;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Item';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg = {@_} or return;

    # scenario arg is required and it must be a PNI::Scenario
    my $scenario = $arg->{scenario}
      or return PNI::Error::missing_required_argument;
    $scenario->isa('PNI::Scenario') or return PNI::Error::invalid_argument_type;

    my $self = $class->SUPER::new;
    $self->add( 'scenario' => $scenario );

    return $self;
}

sub get_hierarchy { return shift->get_scenario->get_hierarchy; }

sub get_scenario { return shift->get('scenario'); }

1;

