#! perl

use strict;
use warnings;
use utf8;

package Alien::wxWidgets;

our $VERSION = "1.001";

use Text::ParseWords qw(shellwords);
use Carp;

my %sel = ( version => "3.3" );
my %cache;

sub new {
    %sel = ( %sel, @_ );
    %cache = ();
}

sub config {
    $cache{_config} //= do {
	my $res = { static => '', unicode => 1, debug => 0, mslu => 0
		  };
	$res->{$_} = _w("--query-$_")
	  for qw( toolkit );
	$res->{toolkit} = 'gtk' if $res->{toolkit} =~ /^gtk/i;
	$res;
    };
#    {toolkit}
#    {unicode}
#    {mslu}
#    {debug}
#    {static}
}

sub load {
    new();
}

sub key {
    shift;
    "DUMMY";
}

sub prefix {
    _w("--prefix");
}

sub linker {
    # --ld => g++ -o
    (shellwords( _w("--ld") ))[0];
}

sub basename {
    shift;
    _w("__basename");
}

sub c_flags {
    shift;
    # --cflags => -I... -D... -pthread
    # --cxxflags base => -I... -D... -DwxUSE_GUI=0 -pthread
    # --cxxflags => -I... -D... -pthread
    # --cppflags => -I... -D...
    # --cppflags base => -I... -D... -DwxUSE_GUI=0
    my $b = "@_" || "all";
    _w("--cxxflags $b");
}

sub link_flags {
    shift;
    my $b = "@_" || "all";
    _w("--libs $b");
}

sub defines {
    join( " ", grep { !/^-I/ } shellwords( _w("--cxxflags") ) );
}

sub include_path {
    join( " ", grep { /^-I/ } shellwords( _w("--cxxflags") ) );
}

sub compiler {
   (shellwords( _w("--cxx") ))[0];
}

sub wx_base_directory {		# msw only
}

sub version {
    my $res = _w("--release");		# 3.2
#    my $res = _w("--version");		# 3.2.8
#    my $res = _w("--version-full");	# 3.2.8.0
    $res =~ /^(\d+)\.(\d+)/;
    sprintf("%d.%03d%03d", $1, $2, 0 );
}

sub shared_libraries {
    shift;
    my $b = "@_" || "all";
    _w("--libs $b");
}

sub libraries {
    shift;
    # --libs all => -pthread -lwx_... -lwx_baseu-3.2
    my $b = "@_" || "all";
    my $res = _w("--libs $b");
    $res =~ s/-pthread/-lpthread/;
    $res;
}

sub link_libraries {
    grep { /^-l/ } shellwords( libraries(@_) );
}

sub _w {
    my $wxcfg = "wx-config";
    $wxcfg = $ENV{WXDIR} . "/build/wx-config" if $ENV{WXDIR};
    my $cmd = "$wxcfg";
    $cmd .= " --version=$sel{version} " if $sel{version};
    $cmd .= " @_";
    return $cache{$cmd} //= do {
	my $result = `$cmd`;
	chomp($result);
	warn("AWX: \"$cmd\" => \"$result\"\n");
	croak("Unparsable result from $wxcfg: \"$result\"\n")
	  if $result =~ /[\n\r]/;
	$result =~ s/\s+/ /g;
	$result;
    };
}


=head1 LICENSE

Copyright (C) 2025, Johan Vromans

This module is free software. You can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=cut

1;
