package PNI::Node::Tk::MainWindow;

BEGIN { require PNI::Node , @ISA = ( 'PNI::Node' ) }

use Tk;
my $responsiveness = 10;
my $main_window;

sub init {
    my $node = shift;
    $node->has_output( 'main_window' );
    $main_window = new MainWindow;
    $node->output->{main_window} = $main_window;
}

sub task {
    my $node = shift;
    &DoOneEvent for ( 0 .. $responsiveness );
}

1;
__END__


