package PNI::Error;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;

my $verbose = 1;

sub verbose_off { $verbose = 0; return 1; }

sub verbose_on { $verbose = 1; return 1; }

my $say = sub {
    my ( $package, $filename, $line ) = caller 2;
    if ($verbose) {
        my $message = shift;
        warn "[PNI::Error] message: $message\n";
        warn
"[PNI::Error] from package $package in file $filename at line $line\n";
    }
    return 1;
};

sub attribute_does_not_exists {
    $say->('attribute does not exists');
    return;
}

sub check_data_failed {
    $say->('check data failed');
    return;
}

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

sub unable_to_init_node {
    $say->('unable to init node');
    return;
}

sub unable_to_load_node {
    $say->('unable to load node');
    return;
}

sub unable_to_run_task {
    $say->('unable to run task');
    return;
}

sub unimplemented_abstract_method {
    $say->('unimplemented abstract method');
    return;
}

1;
__END__

=head1 NAME

PNI::Error - PNI errors catalogue


=head1 METHODS

=head2 C<verbose_off>

=head2 C<verbose_on>

=head1 ERRORS

=head2 C<attribute_does_not_exists>

=head2 C<check_data_failed>

=head2 C<generic>

=head2 C<invalid_argument_type>

=head2 C<missing_required_argument>

=head2 C<unable_to_create_item>

=head2 C<unable_to_init_node>

=head2 C<unable_to_load_node>

=head2 C<unable_to_run_task>

=head2 C<unimplemented_abstract_method>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
