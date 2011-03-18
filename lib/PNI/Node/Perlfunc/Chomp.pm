package PNI::Node::Perlfunc::Chomp;
use strict;
use warnings;
our $VERSION = '0.11';
use base 'PNI::Node';

sub init {
    my $node = shift;

    $node->add_input('in');
    $node->add_output('out');

    return 1;
}

sub task {
    my $node = shift;

    my $in_data = $node->get_input('in')->get_data;
    my $out     = $node->get_output('out');

    if ( defined $in_data ) {

        my $in_data_type = ref $in_data;

        # if input data is a scalar
        if ( $in_data_type eq '' ) {
            chomp $in_data;
            $out->set_data($in_data);
        }

        # otherwise if it is an array reference
        elsif ( $in_data_type eq 'ARRAY' ) {
            chomp @{$in_data};
            $out->set_data($in_data);
        }
    }
    else {
        $out->set_data(undef);
    }

    return 1;
}

1;
