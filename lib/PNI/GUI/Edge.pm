package PNI::GUI::Edge;
use strict;
use warnings;
use base 'PNI::Item';
use PNI::Edge;
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    my $edge = PNI::Edge->new;
    $self->add( edge => $edge );

    return $self;
}

sub get_edge { return shift->get('edge') }

sub get_end_y { return PNI::Error::unimplemented_abstract_method; }

sub get_end_x { return PNI::Error::unimplemented_abstract_method; }

sub get_start_y { return PNI::Error::unimplemented_abstract_method; }

sub get_start_x { return PNI::Error::unimplemented_abstract_method; }

sub set_end_y { return PNI::Error::unimplemented_abstract_method; }

sub set_end_x { return PNI::Error::unimplemented_abstract_method; }

sub set_start_y { return PNI::Error::unimplemented_abstract_method; }

sub set_start_x { return PNI::Error::unimplemented_abstract_method; }

1;
__END__

=head1 NAME

PNI::GUI::Edge - is an edge abstract view


=head1 METHODS

=head2 C<get_edge>

=head2 C<get_end_x>

=head2 C<get_end_y>

=head2 C<get_start_x>

=head2 C<get_start_y>

=head2 C<set_end_y>

=head2 C<set_end_x>

=head2 C<set_start_y>

=head2 C<set_start_x>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
