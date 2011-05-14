package PNI::Edge;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Item';
use PNI::Error 0.14;

sub new {
    my $class = shift;
    my $arg   = {@_};

    # source arg is required and it must be a PNI::Slot::Out
    my $source = $arg->{source} or return PNI::Error::missing_required_argument;
    $source->isa('PNI::Slot::Out') or return PNI::Error::invalid_argument_type;

    # target arg is required and it must be a PNI::Slot::In
    my $target = $arg->{target} or return PNI::Error::missing_required_argument;
    $target->isa('PNI::Slot::In') or return PNI::Error::invalid_argument_type;

    my $self = $class->SUPER::new;

    $self->add( source => $source );
    $self->add( target => $target );

    $source->add_edge($self);
    $target->add_edge($self);

    return $self;
}

sub get_source { return shift->get('source'); }

sub get_source_node { return shift->get_source->get_node; }

sub get_target { return shift->get('target'); }

sub get_target_node { return shift->get_target->get_node; }

1;

=head1 NAME

PNI::Edge - is used to connect two slots




=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
