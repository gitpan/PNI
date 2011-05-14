package PNI::Node;
use strict;
use warnings;
our $VERSION = '0.14';
use base 'PNI::Item';
use PNI::Error 0.14;
use PNI::Slot::In 0.14;
use PNI::Slot::Out 0.14;

sub new {
    my $class = shift;
    my $arg   = {@_};

    my $self = PNI::Item::new($class);
    $self->add( inputs  => {} );
    $self->add( outputs => {} );

    return $self;
}

sub add_input {
    my $self = shift;
    my $input_name = shift or return PNI::Error::missing_required_argument;

    my $input = PNI::Slot::In->new( node => $self, name => $input_name, @_ )
      or return PNI::Error::unable_to_create_item;

    $self->get('inputs')->{ $input->get_name } = $input;

    return $input;
}

sub add_output {
    my $self = shift;
    my $output_name = shift or return PNI::Error::missing_required_argument;

    my $output = PNI::Slot::Out->new( node => $self, name => $output_name, @_ )
      or return PNI::Error::unable_to_create_item;

    $self->get('outputs')->{ $output->get_name } = $output;

    return $output;
}

sub get_input {
    my $self = shift;
    my $input_name = shift or return PNI::Error::missing_required_argument;
    return $self->get('inputs')->{$input_name};
}

sub get_output {
    my $self = shift;
    my $output_name = shift or return PNI::Error::missing_required_argument;
    return $self->get('outputs')->{$output_name};
}

sub get_inputs { return values %{ shift->get('inputs') }; }

sub get_outputs { return values %{ shift->get('outputs') }; }

sub get_input_edges {
    my $self        = shift;
    my @input_edges = ();
    for my $input ( $self->get_inputs ) {
        my $edge = $input->get_edge;
        if ( defined $edge ) {
            push @input_edges, $edge;
        }
    }
    return @input_edges;
}

sub get_output_edges {
    my $self         = shift;
    my @output_edges = ();
    for my $output ( $self->get_outputs ) {
        my @edges = $output->get_edges;
        if (@edges) {
            push @output_edges, @edges;
        }
    }
    return @output_edges;
}

sub init { return 1; }
sub task { return PNI::Error::unimplemented_abstract_method; }

1;

=head1 NAME

PNI::Node - is a basic unit of code



=head1 DESCRIPTION

This is an abstract class: it has an init method called after creation and a task method called at every PNI::step.

=head1 SEE ALSO

L<PNI::Link>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
