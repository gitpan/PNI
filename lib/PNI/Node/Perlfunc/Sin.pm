package PNI::Node::Perlfunc::Sin;

BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

sub init {
    my $node = shift;
    $node->has_input( 'radians' );
    $node->has_output( 'output' );
}

sub task {
    my $node = shift;
    return unless defined $node->input->{radians};
    $node->output->{output} = sin( $node->input->{radians} );
}

1;
__END__

=head1 NAME 

PNI::Node::Perlfunc::Sin;

=head1 SEE ALSO

PNI::Node::Perlfunc::Cos;

=cut

