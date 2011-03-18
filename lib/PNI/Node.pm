package PNI::Node;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Item';
use PNI::Slot::In;
use PNI::Slot::Out;

sub new {

    # ignore the first parameter since the node class depends
    # on type parameter, see below
    shift;    # my $class

    # $arg can be empty if you want an empty node
    my $arg = {@_};

    # type parameter is optional
    my $type = $arg->{type};
    my $class;

    # if a type is specified, try to require the corresponding class
    if ( defined $type ) {
        $class = __PACKAGE__ . '::' . $type;
        ( my $path = $class . '.pm' ) =~ s=::=/=g;
        eval { require $path } or return;
    }

    # otherwise build a generic empty node you can decorate later
    else {
        $class = __PACKAGE__;
    }

    # seems better than $class->SUPER::new
    my $self = PNI::Item::new($class);

    $self->add( 'inputs'  => {} );
    $self->add( 'outputs' => {} );

    # at this point the node is created, so you can initialize it
    $self->init or return;

    return $self;
}

sub add_input {
    my $self = shift;
    my $input_name = shift or return;

    # cannot have two inputs with the same name
    exists $self->get('inputs')->{$input_name} and return;

    my $input = PNI::Slot::In->new( node => $self, name => $input_name, @_ )
      or return;
    $self->get('inputs')->{ $input->get_name } = $input;
    return $input;
}

sub add_output {
    my $self = shift;
    my $output_name = shift or return;

    # cannot have two outputs with the same name
    exists $self->get('outputs')->{$output_name} and return;

    my $output = PNI::Slot::Out->new( node => $self, name => $output_name, @_ )
      or return;
    $self->get('outputs')->{ $output->get_name } = $output;
    return $output;
}

sub del_input  { return 1; }
sub del_output { return 1; }

sub get_input {
    my $self = shift;
    my $input_name = shift or return;
    return $self->get('inputs')->{$input_name};
}

sub get_output {
    my $self = shift;
    my $output_name = shift or return;
    return $self->get('outputs')->{$output_name};
}

sub get_inputs {
    return values %{ shift->get('inputs') };
}

sub get_outputs {
    return values %{ shift->get('outputs') };
}

sub get_input_links {
    my $self        = shift;
    my @input_links = ();
    for my $input ( $self->get_inputs ) {
        my $link = $input->get_link;
        if ( defined $link ) {
            push @input_links, $link;
        }
    }
    return @input_links;
}

sub get_output_links {
    my $self         = shift;
    my @output_links = ();
    for my $output ( $self->get_outputs ) {
        my @links = $output->get_links;
        if (@links) {
            push @output_links, @links;
        }
    }
    return @output_links;
}

sub init { return 1; }
sub task { return 1; }

1;

