package PNI::Error;
use strict;

my $verbose = 1;

sub verbose_off { return not $verbose = 0; }

sub verbose_on { return $verbose = 1; }

my $say = sub {
    my ( $package, $filename, $line ) = caller 1;
    if ($verbose) {
        my $message = shift;
        warn "[PNI::Error] message: $message\n"
          . "[PNI::Error] from package $package "
          . "in file $filename at line $line\n";
    }
};

sub attribute_does_not_exists {
    $say->('attribute does not exists');
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

sub overridden_attribute_name {
    $say->('overridden attribute name');
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

=head2 C<generic>

=head2 C<invalid_argument_type>

=head2 C<missing_required_argument>

=head2 C<overridden_attribute_name>

=head2 C<unable_to_create_item>

=head2 C<unable_to_init_node>

=head2 C<unable_to_load_node>

=head2 C<unable_to_run_task>

=head2 C<unimplemented_abstract_method>

=cut

