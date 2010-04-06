package PNI::Node::Perlfunc::Localtime;

extends 'PNI::Node';
# #  0    1    2     3     4    5     6     7     8
# ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
#                                             localtime(time);

sub init {
    my $node = shift;
    $node->has_output( );
}

sub task {
    my $node = shift;
}

1;
__END__

