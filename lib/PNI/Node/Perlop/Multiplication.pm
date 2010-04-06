package PNI::Node::Perlop::Multiplication;
our $VERSION = '0.0.1';
BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

sub init {
    my $node = shift;
    
    $node->has_input( 'input1' => 0 );
    $node->has_input( 'input2' => 0 );
    $node->has_output( 'output' => 0 );
}

sub task {
    my $node = shift;
    
    $node->output->{output} = $node->input->{input1} * $node->input->{input1};
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Multiplication

=head1 DESCRIPTION

=head1 AUTHOR

Gianluca Casati

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

PNI::Node

=cut


