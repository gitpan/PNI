package PNI::GUI::Scenario;
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

    # $scenario is required
    my $scenario = $arg->{scenario}
      or return PNI::Error::missing_required_argument;

    # $scenario must be a PNI::Scenario
    $scenario->isa('PNI::Scenario') or return PNI::Error::invalid_argument_type;

    $self->add( scenario => $scenario );

    return $self;
}

# return $edge: PNI::GUI::Edge
sub add_edge { return PNI::Error::unimplemented_abstract_method; }

# return $node: PNI::GUI::Node
sub add_node { return PNI::Error::unimplemented_abstract_method; }

sub get_scenario { return shift->get('scenario') }

1;
__END__

=head1 NAME

PNI::GUI::Scenario - is a scenario abstract view


=head1 METHODS

=head2 C<add_edge>

=head2 C<add_node>

=head2 C<add_scenario>

=head2 C<get_scenario>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
