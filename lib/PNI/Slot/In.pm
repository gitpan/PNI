package PNI::Slot::In;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Slot';
use PNI::Edge 0.15;
use PNI::Error 0.15;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

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

# return 0 or 1
sub is_connected {
    my $self = shift;
    my $edge = $self->get_edge;
    if   ( defined $edge ) { return 1 }
    else                   { return 0; }
}

# return $edge
sub join_to {
    my $self = shift;

    # output_slot arg is required
    my $output_slot = shift or return PNI::Error::missing_required_argument;

    return PNI::Edge->new( target => $self, source => $output_slot );
}

1;
__END__

=head1 NAME

PNI::Slot::In - input slot


=head1 METHODS

=head2 C<add_edge>

=head2 C<get_edge>

=head2 C<is_connected>

=head2 C<join_to>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
