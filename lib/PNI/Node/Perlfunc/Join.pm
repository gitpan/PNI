package PNI::Node::Perlfunc::Join;

BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

sub init {
    my $node = shift;
    $node->has_input( 'input1' => 0 ); #TODO fai il metodo has_input_list
    $node->has_output( 'output1' );
}

sub task {
    my $node = shift;
    
}

1;
__END__

=head1 NAME

PNI::Node::Perlfunc::Join


=cut

