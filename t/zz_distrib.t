#!/usr/bin/perl -w

use strict;
use Test::More;
eval "use YAML 0.35";
plan skip_all => "YAML 0.35 required for testing META.yml" if $@;
eval "use Module::Info";
plan skip_all => "Module::Info required for testing META.yml" if $@;

plan 'tests' => 1;

my $meta = YAML::LoadFile( 'META.yml' );
my $wx = Module::Info->new_from_file( 'Wx.pm' );

is( $meta->{version}, $wx->version, 'META.yml == Wx.pm' );
