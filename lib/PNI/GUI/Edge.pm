package PNI::GUI::Edge;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Item';
use PNI::Error 0.15;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    # $edge is required
    my $edge = $arg->{edge} or return PNI::Error::missing_required_argument;

    # $edge must be a PNI::Edge
    $edge->isa('PNI::Edge') or return PNI::Error::invalid_argument_type;

    $self->add( edge => $edge );

    return $self;
}

sub get_edge { return shift->get('edge') }

1;
__END__

=head1 NAME

PNI::GUI::Edge - is an edge abstract view


=head1 METHODS

=head2 C<get_edge>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
