package PNI::GUI::Node;
use strict;
use warnings;
use base 'PNI::Item';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    my $center_y = $arg->{center_y};
    $self->add( center_y => $center_y );

    my $center_x = $arg->{center_x};
    $self->add( center_x => $center_x );

    my $height = $arg->{height};
    $self->add( height => $height );

    # $node is not required but should be a PNI::Node
    my $node = $arg->{node};
    if ( defined $node and not $node->isa('PNI::Node') ) {
        return PNI::Error::invalid_argument_type;
    }
    $self->add( node => $node );

    # type is delegated to node

    # $label defaults to $self->get_node->get_type
    my $label = $arg->{label} || $self->get_node->get_type;

    $self->add( label => $label );

    my $width = $arg->{width};
    $self->add( width => $width );

    return $self;
}

sub get_center_y { return shift->get('center_y') }

sub get_center_x { return shift->get('center_x') }

sub get_height { return shift->get('height') }

sub get_label { return shift->get('label') }

sub get_node { return shift->get('node') }

sub get_width { return shift->get('width') }

# return 1
sub move { return PNI::Error::unimplemented_abstract_method; }

sub set_center_y {
    my $self = shift;
    my $center_y = shift or return PNI::Error::missing_required_argument;
    return $self->set( center_y => $center_y );
}

sub set_center_x {
    my $self = shift;
    my $center_x = shift or return PNI::Error::missing_required_argument;
    return $self->set( center_x => $center_x );
}

sub set_height {
    my $self = shift;
    my $height = shift or return PNI::Error::missing_required_argument;
    return $self->set( height => $height );
}

sub set_label {
    my $self = shift;
    my $label = shift or return PNI::Error::missing_required_argument;
    return $self->set( label => $label );
}

sub set_node {
    my $self = shift;
    my $node = shift or return PNI::Error::missing_required_argument;
    return $self->set( node => $node );
}

sub set_width {
    my $self = shift;
    my $width = shift or return PNI::Error::missing_required_argument;
    return $self->set( width => $width );
}

1;
__END__

=head1 NAME

PNI::GUI::Node - is a node abstract view


=head1 METHODS

=head2 C<get_center_x>

=head2 C<get_center_y>

=head2 C<get_height>

=head2 C<get_label>

=head2 C<get_node>

=head2 C<get_width>

=head2 C<move>

=head2 C<set_center_x>

=head2 C<set_center_y>

=head2 C<set_height>

=head2 C<set_label>

=head2 C<set_node>

=head2 C<set_width>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
