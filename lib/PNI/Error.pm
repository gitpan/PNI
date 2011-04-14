package PNI::Error;
use strict;
use warnings;
our $VERSION = '0.12';

my $verbose = 1;

sub verbose_off { $verbose = 0; return 1; }

sub verbose_on { $verbose = 1; return 1; }

my $say = sub {
    my ( $package, $filename, $line ) = caller 1;
    if ($verbose) {
        my $message = shift;
        warn "PNI::Error message: $message\n";
        warn "from package $package in file $filename at line $line\n";
    }
    return 1;
};

sub generic {
    $say->('generic');
    return;
}

sub invalid_argument_type {
    $say->('invalid argument type');
    return;
}

sub missing_required_argument {
    $say->('missing required argument');
    return;
}

sub unable_to_create_item {
    $say->('unable to create item');
    return;
}

sub unable_to_run_task {
    $say->('unable to run task');
    return;
}

sub unimplemented_abstract_method {
    $say->('unable to run task');
    return;
}

1;
