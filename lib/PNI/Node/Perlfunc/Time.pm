package PNI::Node::Perlfunc::Time;

extends 'PNI::Node';

sub init {
    my $self = shift;
    PNI::Output->new( node_ref => $self , name => 'timestamp' , type => 'SCALAR' );

}

sub task {
    my $self = shift;
    if( $self->output->{output1}->is_connected ) {
        $self->output->{output1}->content( time );
        print $self->output->{output1}->content , "\n";
    }
}

1;
__END__
