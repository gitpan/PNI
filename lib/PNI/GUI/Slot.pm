package PNI::GUI::Slot;
use strict;
use base 'PNI::Item';
use PNI::Error;

sub new {
    my $self = shift->SUPER::new;
    my $arg  = {@_};

    # arg node is required
    my $node = $arg->{node}
      or return PNI::Error::missing_required_argument;

    $self->add( node => $node );

    # TODO aggiusta qui, lo slot dovrebbe starre qui non nelle sotto classi
    #      e forse dovrebbe chiamarsi model
    #$self->add(slot=>$arg->{slot});

    return $self;
}

sub get_node { shift->get('node') }

1;
__END__

=head1 NAME

PNI::GUI::Slot -

=cut

