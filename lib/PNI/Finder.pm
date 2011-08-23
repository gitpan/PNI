package PNI::Finder;
use strict;
use Module::Pluggable search_path => 'PNI::Node', require => 1, inner => 0;

# this class is a singleton
my $self;

# return $self : PNI::Finder
sub instance {
    if ( not defined $self ) {
        # it was 
        # $self = bless \__PACKAGE__, __PACKAGE__;
        # but it is not supported by perl 5.8, see bug id=69733
        $self = bless \my $singleton, __PACKAGE__;
    }
    return $self;
}

# return @nodes: PNI::Node
sub nodes {
    my @nodes = grep { $_->isa('PNI::Node') } shift->plugins;
    s/^PNI::Node::// foreach (@nodes);
    return @nodes;
}

1;
__END__

=head1 NAME

PNI::Finder - searches for available nodes

=head1 SYNOPSIS

    my $find = PNI::Finder->instance;
    my @node_list = $find->nodes;

=head1 METHODS

=head2 C<instance>

    my $find = PNI::Finder->instance

Returns the only instance of this class.

=head2 C<nodes>

    $find->nodes

Returns a list of available PNI nodes, i.e. every package under the PNI::Node
namespace that is a valid PNI::Node, minus the leading 'PNI::Node::' string.

=cut

