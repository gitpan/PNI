package PNI::Finder;
use strict;
use warnings;
our $VERSION = '0.15';
### use Smart::Comments;
use Module::Pluggable search_path => 'PNI::Node', require => 1, inner => 0;

# singleton
my $self;

sub new {
    if ( not defined $self ) {
        $self = bless \__PACKAGE__, __PACKAGE__;
    }
    return $self;
}

sub nodes {

    my @nodes;
    for my $module ( $self->plugins ) {
        if ( $module->isa('PNI::Node') ) {
            $module =~ s/^PNI::Node:://;
            push @nodes, $module;
        }
    }
    return @nodes;
}

1;
__END__

=head1 NAME

PNI::Finder - searches for available nodes


=head1 DESCRIPTION

This module is used internally by PNI::node_list method. 

=head1 SYNOPSIS

    my $find = PNI::Finder->new; # it is a singleton
    my @nodes = $find->nodes;

=head1 METHODS

=head2 C<nodes>

Returns a list of available PNI nodes, i.e. every package under the PNI::Node
namespace that is a valid PNI::Node, minus the leading 'PNI::Node::' string.

=head1 SEE ALSO

L<Module::Pluggable>

L<PNI>



=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0 .

=cut
