package PNI::Node::Perlop::Quote;
our $VERSION = '0.0.1';
BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

sub init {
    my $node = shift;
    
    $node->has_input( 'input' => 0 );
    $node->has_output( 'output' => 0 );
}

sub task {
    my $node = shift;
    
    $node->output->{output} = qq{ $node->input->{input} };
}

1;
__END__

=head1 NAME

PNI::Node::Perlop::Quote

=head1 DESCRIPTION

=head1 AUTHOR

Gianluca Casati

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

PNI::Node

=cut


