#!/usr/bin/perl -w
#############################################################################
## Name:        script/make_v_cback.pl
## Purpose:     Create the v_cback_def.h include
## Author:      Mattia Barbon
## Modified by:
## Created:     19/08/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Data::Dumper;

my @macros =
  qw(DEC_V_CBACK_BOOL__BOOL
     DEF_V_CBACK_BOOL__BOOL

     DEC_V_CBACK_BOOL__INT
     DEF_V_CBACK_BOOL__INT
     DEF_V_CBACK_BOOL__INT_pure

     DEC_V_CBACK_BOOL__SIZET
     DEF_V_CBACK_BOOL__SIZET
     DEF_V_CBACK_BOOL__SIZET_pure

     DEC_V_CBACK_BOOL__SIZET_SIZET
     DEF_V_CBACK_BOOL__SIZET_SIZET
     DEF_V_CBACK_BOOL__SIZET_SIZET_pure

     DEC_V_CBACK_BOOL__VOID
     DEC_V_CBACK_BOOL__VOID_const
     DEF_V_CBACK_BOOL__VOID
     DEF_V_CBACK_BOOL__VOID_const
     DEF_V_CBACK_BOOL__VOID_pure

     DEC_V_CBACK_BOOL__INT_INT
     DEC_V_CBACK_BOOL__INT_INT_const
     DEF_V_CBACK_BOOL__INT_INT
     DEF_V_CBACK_BOOL__INT_INT_pure
     DEF_V_CBACK_BOOL__INT_INT_const
     DEF_V_CBACK_BOOL__INT_INT_const_pure

     DEC_V_CBACK_DOUBLE__INT_INT
     DEC_V_CBACK_DOUBLE__INT_INT_const
     DEF_V_CBACK_DOUBLE__INT_INT
     DEF_V_CBACK_DOUBLE__INT_INT_pure
     DEF_V_CBACK_DOUBLE__INT_INT_const
     DEF_V_CBACK_DOUBLE__INT_INT_const_pure

     DEC_V_CBACK_INT__LONG_LONG
     DEC_V_CBACK_INT__LONG_LONG_const
     DEF_V_CBACK_INT__LONG_LONG
     DEF_V_CBACK_INT__LONG_LONG_pure
     DEF_V_CBACK_INT__LONG_LONG_const

     DEC_V_CBACK_INT__VOID
     DEF_V_CBACK_INT__VOID
     DEF_V_CBACK_INT__VOID_pure

     DEC_V_CBACK_LONG__INT_INT
     DEC_V_CBACK_LONG__INT_INT_const
     DEF_V_CBACK_LONG__INT_INT
     DEF_V_CBACK_LONG__INT_INT_pure
     DEF_V_CBACK_LONG__INT_INT_const
     DEF_V_CBACK_LONG__INT_INT_const_pure

     DEC_V_CBACK_VOID__INT_INT_LONG
     DEF_V_CBACK_VOID__INT_INT_LONG
     DEF_V_CBACK_VOID__INT_INT_LONG_pure

     DEC_V_CBACK_WXCOORD__VOID_const
     DEF_V_CBACK_WXCOORD__VOID_const
     DEF_V_CBACK_WXCOORD__VOID_const_pure

     DEC_V_CBACK_WXCOORD__SIZET
     DEC_V_CBACK_WXCOORD__SIZET_const
     DEF_V_CBACK_WXCOORD__SIZET
     DEF_V_CBACK_WXCOORD__SIZET_const
     DEF_V_CBACK_WXCOORD__SIZET_pure
     DEF_V_CBACK_WXCOORD__SIZET_const_pure
     );
my %type_map =
  ( BOOL    => [ 'bool',    'SvTRUE( ret )', 'return false',
                 'bool p%d', 'b', 'p%d', ],
    SIZET   => [ 'size_t',  'SvIV( ret )', 'return 0',
                 'size_t p%d', 'L', 'p%d', ],
    LONG    => [ 'long',    'SvIV( ret )', 'return 0',
                 'long p%d', 'l', 'p%d', ],
    INT     => [ 'int',     'SvIV( ret )', 'return 0',
                 'int p%d', 'i', 'p%d', ],
    WXCOORD => [ 'wxCoord', 'SvIV( ret )', 'return 0',
                 'wxCoord p%d', 'l', 'p%d', ],
    DOUBLE  => [ 'double',  'SvNV( ret )', 'return 0.0', ],
    VOID    => [ 'void',    ';',         , 'return',
                 ],
    );
my %const_map =
  ( 0       => 'wxPli_NOCONST',
    1       => 'wxPli_CONST',
    );

my %emitted;
my @todo = map [ parse_macro( $_, \%type_map ) ], @macros;

print <<'EOT';
// GENERATED FILE, DO NOT EDIT

#ifndef _WXPERL_V_CBACK_DEF_H
#define _WXPERL_V_CBACK_DEF_H

EOT

foreach my $todo ( @todo ) {
    my $args = join '_', @{$todo->[2]};
    my( $c_args, $p_args, $tymap ) = macro_call_args( $todo );

    if( $todo->[0] eq 'DEC' ) {
        my $name = sprintf 'DEC_V_CBACK_ANY__%s_', $args;
        next if $emitted{$name};
        $emitted{$name} = 1;

        printf <<'EOT',
#define %s( RET, METHOD, CONST ) \
    RET METHOD(%s) CONST

EOT
        $name, $c_args;
    } elsif( $todo->[0] eq 'DEF' ) {
        my $name = sprintf 'DEF_V_CBACK_ANY__%s_', $args;
        next if $emitted{$name};
        $emitted{$name} = 1;

        printf <<'EOT',
#define %s( RET, CVT, CLASS, CALLBASE, METHOD, CONST ) \
    RET CLASS::METHOD(%s) CONST                           \
    {                                                                         \
        dTHX;                                                                 \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                       \
        {                                                                     \
            wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,     \
                                             %s%s ) );                      \
            return CVT;                                                       \
        }                                                                     \
        else                                                                  \
            CALLBASE;                                                         \
    }

EOT
            $name, $c_args, $tymap, ( $p_args ? ", $p_args" : '' );
    }
}

foreach my $todo ( @todo ) {
    my $args = join '_', @{$todo->[2]};
    my( $c_args, $p_args, $tymap ) = macro_call_args( $todo );

    my $const = $todo->[3]->{const} ? '_const' : '';
    my $pure = $todo->[3]->{pure} ? '_pure' : '';

    die 'No type name for ', $todo->[1]
        unless $type_map{$todo->[1]}[0];
    die 'No type conversion for ', $todo->[1]
        unless $type_map{$todo->[1]}[1];

    if( $todo->[0] eq 'DEC' ) {
        printf <<'EOT',
#define DEC_V_CBACK_%s__%s%s( METHOD ) \
    DEC_V_CBACK_ANY__%s_( %s, METHOD, %s )

EOT
            $todo->[1], $args, $const, $args, $type_map{$todo->[1]}[0],
            $const_map{$todo->[3]->{const}};
    } elsif( $todo->[0] eq 'DEF' ) {
        my $void = $todo->[1] eq 'VOID';
        my $callbase = sprintf '%sBASE::METHOD(%s)',
                               ( $void ? '' : 'return ' ), $p_args;
        die 'No default value for pure function ', $todo->[1]
            if $todo->[3]{pure} && !$type_map{$todo->[1]}[2];

        printf <<'EOT',
#define DEF_V_CBACK_%s__%s%s%s( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_ANY__%s_( %s, %s, CLASS, %s, METHOD, %s )

EOT
            $todo->[1], $args, $const, $pure, $args, $type_map{$todo->[1]}[0],
            $type_map{$todo->[1]}[1],
            ( $todo->[3]{pure} ? $type_map{$todo->[1]}[2] : $callbase ),
            $const_map{$todo->[3]->{const}};
    }
}

print <<'EOT';

#endif

EOT

sub parse_macro {
    my( $macro, $types ) = @_;
    my( $type, $ret, @args, %flags );

    $flags{$_} = 0 foreach qw(const pure);

    my $tmp = $macro;
    $tmp =~ s/_const// and $flags{const} = 1;
    $tmp =~ s/_pure//  and $flags{pure} = 1;

    $tmp =~ s/^DE([CF])_V_CBACK// and $type = 'DE' . $1;
    $tmp =~ s/^_([A-Za-z]+)__//   and $ret = $1;

    @args = split '_', $tmp;

    die "Unable to parse '$macro'" unless @args && $ret;
    $types->{$_} or die "invalid type $_ in '$macro'" foreach $ret, @args;

    return ( $type, $ret, \@args, \%flags );
}

sub macro_call_args {
    my( $todo ) = @_;

    my( $c_args, $p_args, $tymap );
    if( $todo->[2][0] eq 'VOID' ) {
        $c_args = $p_args = '';
        $tymap = 'NULL';
    } else {
        my $c = 0;
        my( @cargs, @pargs );
        foreach my $idx ( 0 .. $#{$todo->[2]} ) {
            my $type = $todo->[2][$idx];
            die 'Incomplete type definition for ', $type
              unless    $type_map{$type}[3]
                     && $type_map{$type}[4]
                     && $type_map{$type}[5];
            $cargs[$idx] = sprintf $type_map{$type}[3], $idx + 1;
            $tymap .= $type_map{$type}[4];
            $pargs[$idx] = sprintf $type_map{$type}[5], $idx + 1;
        }
        $c_args = ' ' . join( ', ', @cargs ) . ' ';
        $p_args = join( ', ', @pargs );
        $tymap  = qq{"$tymap"};
    }

    return ( $c_args, $p_args, $tymap );
}
