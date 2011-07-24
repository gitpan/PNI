package PNI::File;
use strict;
use base 'PNI::Item';
use File::Spec;
use File::Temp;
use JSON;
use PNI::Error;

my $extension = 'pni';

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    $self->add('path');
    $self->set( path => $arg->{path} );

    return $self;
}

# return \%content
sub get_content {
    my $self = shift;

    # return content stored in $path
    my $path = $self->get_path;
    local $/;
    ### TODO don't want to die but raise exception and fix the problem at runtime
    open my $fh, '<', $path;
    my $text    = <$fh>;
    my $content = decode_json($text);
    close $fh;

    return $content;
}

# return $path
sub get_path { shift->get('path') }

sub set_content {
    my $self    = shift;
    my $content = shift
      or return PNI::Error::missing_required_argument;
    my $fh;
    my $path = $self->get_path;

    if ( defined $path ) {
        open $fh, '>', $path;
    }
    else {
        ( $fh, $path ) = File::Temp::tempfile;
    }
    print $fh encode_json($content);

    close $fh;

    return 1;
}

sub set_path {
    my $self = shift;
    my $path = shift
      or return PNI::Error::missing_required_argument;

    $self->set( path => $path );
}

1;
__END__

=head1 NAME

PNI::File - stores a scenario in a .pni file

=head1 SYNOPSIS

    my $file = PNI::File->new( path => '/path/to/my/file.pni' );

=head1 METHODS

=head2 C<get_content>

=head2 C<get_path>

=head2 C<set_content>

=head2 C<set_path>

=cut
