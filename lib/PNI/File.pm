package PNI::File;
use strict;
use base 'PNI::Item';
use File::Spec;
use File::Temp;
use JSON;
use PNI::Error;

my $empty_content = { edges => {}, nodes => {}, };
my $extension = 'pni';

sub new {
    my $class = shift;
    my $arg   = {@_};
    my $self  = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    my $path = $arg->{path};

    if ( defined $path ) {

        $self->add( path => $path );
    }

    # if arg path is not defined,
    else {

        # create a temporary file, and
        my ( $fh, $path ) = File::Temp::tempfile( SUFFIX => '.pni' );
        close $fh;

        $self->add( path => $path );

        # fill it with empty content.
        $self->set_content($empty_content);
    }

    return $self;
}

# return \%content
sub get_content {
    my $self = shift;
    my $content;

    # return content stored in $path
    my $path = $self->get_path;
    local $/;
    ### TODO don't want to die but raise exception and fix the problem at runtime
    open my $fh, '<', $path;
    my $text = <$fh>;
    $content = decode_json($text);
    close $fh;

    return $content;
}

# return $path
sub get_path { shift->get('path') }

sub set_content {
    my $self    = shift;
    my $content = shift
      or return PNI::Error::missing_required_argument;

    my $path = $self->get_path;

    open my $fh, '>', $path;
    ### TODO don't want to die but raise exception and fix the problem at runtime

    print $fh encode_json($content);

    close $fh;

    return 1;
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

=cut

