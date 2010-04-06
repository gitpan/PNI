package PNI::Node::Perlfunc::Cos;

BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

sub init {
    my $node = shift;
    $node->has_input( 'radians' );
    $node->has_output( 'output' );
}

sub task {
    my $node = shift;
    return unless defined $node->input->{radians};
    $node->output->{output} = cos( $node->input->{radians} );
}

1;
__END__

=head1 NAME 

PNI::Node::Perlfunc::Cos;

=head1 SEE ALSO

PNI::Node::Perlfunc::Sin;

=cut


