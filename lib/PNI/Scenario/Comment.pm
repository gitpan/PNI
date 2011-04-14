package PNI::Scenario::Comment;
use strict;
use warnings;
our $VERSION = '0.12';
use base 'PNI::Scenario::Item';
use PNI::Error;

sub new {
    my $class = shift;
    my $arg   = {@_};

    # text arg is required
    my $text = $arg->{text} or return PNI::Error::missing_required_argument;

    # center arg is required
    # center represents a point and is a reference to an array with two elements
    my $center = $arg->{center} or return PNI::Error::missing_required_argument;

    my $self = $class->SUPER::new(@_)
      or return PNI::Error::unable_to_create_item;

    return $self;
}

1;

=head1 NAME

PNI::Scenario::Comment


=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
