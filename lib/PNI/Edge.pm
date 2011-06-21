package PNI::Edge;
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

    # $source is not required but should be a PNI::Slot::Out
    my $source = $arg->{source};
    if ( defined $source ) {
        $source->isa('PNI::Slot::Out')
          or return PNI::Error::invalid_argument_type;
    }
    $self->add( source => $source );

    # $target is not required but should be a PNI::Slot::In
    my $target = $arg->{target};
    if ( defined $target ) {
        $target->isa('PNI::Slot::In')
          or return PNI::Error::invalid_argument_type;
    }
    $self->add( target => $target );

    $source->add_edge($self);
    $target->add_edge($self);

    return $self;
}

sub get_source { return shift->get('source') }

sub get_source_node { return shift->get_source->get_node; }

sub get_target { return shift->get('target') }

sub get_target_node { return shift->get_target->get_node; }

1;
__END__

=head1 NAME

PNI::Edge - is used to connect two slots


=head1 METHODS

=head2 C<get_source>

=head2 C<get_source_node>

=head2 C<get_target>

=head2 C<get_target_node>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
