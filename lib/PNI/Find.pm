package PNI::Find;
use strict;
use warnings;
our $VERSION = '0.12';
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
