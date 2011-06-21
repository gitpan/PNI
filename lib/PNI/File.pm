package PNI::File;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use base 'PNI::Item';
use Cwd;
use File::Spec;
use PNI::Error 0.15;

my $extension = 'pni';

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    # $dir defaults to getcwd
    my $dir = $arg->{dir} || getcwd;

    $self->add( dir => $dir );

    # $name defaults to 'Untitled'
    my $name = $arg->{name} || 'Untitled';

    $self->add( name => $name );

    # $scenario is not required but should be a PNI::Scenario
    my $scenario = $arg->{scenario};
    if ( defined $scenario ) {
        $scenario->isa('PNI::Scenario')
          or return PNI::Error::invalid_argument_type;
    }
    $self->add( scenario => $scenario );

    return $self;
}

sub get_dir { return shift->get('dir') }

sub get_name { return shift->get('name') }

sub get_scenario { return shift->get('scenario') }

# return \%edges
sub get_edges {
    my $self    = shift;
    my $content = do $self->path;

    return $content->{edges};
}

# return \%nodes
sub get_nodes {
    my $self    = shift;
    my $content = do $self->path;

    return $content->{nodes};
}

# return $path
sub path {
    my $self = shift;

    my @dir  = @{ $self->get('dir') };
    my $name = $self->get('name');

    my $path = File::Spec->catfile( @dir, $name . '.' . $extension );

    return $path;
}

# input $dir = [ qw( path of my dir ) ]
# return 1
sub set_dir {
    my $self = shift;
    my $dir = shift or return PNI::Error::missing_required_argument;
    ref($dir) eq 'ARRAY' or return PNI::Error::invalid_argument_type;
    return $self->set( dir => $dir );
}

sub set_name {
    my $self = shift;
    my $name = shift or return PNI::Error::missing_required_argument;
    return $self->set( name => $name );
}

1;
__END__

=head1 NAME

PNI::File - 


=head1 METHODS

=head2 C<get_dir>

=head2 C<get_edges>

=head2 C<get_name>

=head2 C<get_nodes>

=head2 C<get_scenario>

=head2 C<path>

=head2 C<set_dir>

=head2 C<set_name>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
