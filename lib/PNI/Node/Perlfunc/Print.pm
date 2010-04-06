package PNI::Node::Perlfunc::Print;

BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

my $previous_message;

sub init {
    my $node = shift;
    #$node->has_input( 'FileHandle' => *STDOUT ); # come si fa?
    $node->has_input( 'message' => '' );
}

sub task {
    my $node = shift;
    return unless defined $node->input->{message};
    # dovrebbe essere un array ma per ora va bene un solo scalare;
    return unless $node->input->{message} eq $previous_message;
    $previous_message = $node->input->{message};
    print STDOUT $node->input->{message};
}

1;
__END__

=head1

PNI::Node::Perlfunc::Print;

=cut

