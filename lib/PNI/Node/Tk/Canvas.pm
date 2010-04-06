package PNI::Node::Tk::Canvas;

BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

my $created = 0;

sub init {
    my $node = shift;
    $node->has_input( 'window' );
    # TODO togli l' input height e lascia solo il configure
    $node->has_input( height => 100 );
    $node->has_input( configure => {} );

    $node->has_output( 'canvas' );
}

sub task {
    my $node = shift;

    if( defined $node->input->{window} and not $created ) {
        $node->output->{canvas} = $node->input->{window}->Canvas();
        	       	
        $node->output->{canvas}->configure( 
			-confine => 0,
			-height => $node->input->{height},
	      		-width => 900,
	      		-scrollregion => [ 0 , 0 , 1000 , 1000 ],
	      		-xscrollincrement => 1,
	      		-background => 'white',
		);
        $node->output->{canvas}->pack( -expand => 1 , -fill => 'both' );
        $created = 1;
    }
}

1;
__END__
