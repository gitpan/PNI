package PNI::Slot::In;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Slot';
use PNI::Error 0.14;

sub new {
    my $class = shift;
    my $arg   = {@_};

    # call the Slot constructor and check result
    my $self = $class->SUPER::new(@_) or return;
    $self->add('edge');

    return $self;
}

sub add_edge {
    my $self = shift;
    my $edge = shift or return PNI::Error::missing_required_argument;
    $edge->isa('PNI::Edge') or return PNI::Error::invalid_argument_type;
    return $self->set( edge => $edge );
}

sub get_edge { return shift->get('edge'); }

sub is_connected {
    my $self = shift;
    my $edge = $self->get_edge;
    if   ( defined $edge ) { return 1 }
    else                   { return 0; }
}

1;

=head1 NAME

PNI::Slot::In - input slot




=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
