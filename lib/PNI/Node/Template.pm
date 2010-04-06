package PNI::Node::Template;
our $VERSION = '0.0.1';
BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

sub init {
    my $node = shift;
    
    $node->has_input( 'input1' => 0 );
    $node->has_output( 'output1' => 0 );
    
    $node->has_input( 'input2' => [] );
    $node->has_output( 'output2' => [] );

    $node->has_input( 'input3' => {} );
    $node->has_output( 'output3' => {} );
}

sub task {
    my $node = shift;
    
    $node->output->{output1} = $node->input->{input1};
    $node->output->{output2} = $node->input->{input2};
    $node->output->{output3} = $node->input->{input3};
}

1;
__END__

=head1 NAME

PNI::Node::Template

=head1 DESCRIPTION

=head1 AUTHOR

Gianluca Casati

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

PNI::Node

=cut
