package PNI::Node::Perlfunc::Print;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('list');
    $node->add_input( 'do_print', data => 0 );

    return 1;
}

sub task {
    my $node = shift;

    my $do_print      = $node->get_input('do_print');
    my $do_print_data = $do_print->get_data;

    if ($do_print_data) {

        my $list_data = $node->get_input('list')->get_data;

        if ( defined $list_data ) {

            my $list_data_type = ref $list_data;
            if ( $list_data_type eq '' ) {
                my $rv = print STDOUT $list_data;
            }
            elsif ( $list_data_type eq 'ARRAY' ) {
                my @list_data = @{$list_data};
                my $rv        = print STDOUT @list_data;
            }
        }
    }

    # reset do_print flag
    $do_print->set_data(0);

    return 1;
}

1;
