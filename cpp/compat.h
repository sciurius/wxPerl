/////////////////////////////////////////////////////////////////////////////
// Name:        compat.h
// Purpose:     some compatibility macros
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <patchlevel.h>

// < 5.6 does not define PERL_
#ifdef PERL_REVISION
#define WXPERL_P_VERSION_EQ( V, S ) \
 ( ( PERL_REVISION == (V) ) && ( PERL_VERSION == (S) ) )
#define WXPERL_P_VERSION_GE( V, S ) \
 ( ( PERL_REVISION >= (V) ) || \
   ( PERL_REVISION == (V) && PERL_VERSION >= (S) ) )
#else
#define WXPERL_P_VERSION_EQ( V, S ) \
 ( ( 5 == (V) ) && ( PATCHLEVEL == (S) ) )
#define WXPERL_P_VERSION_GE( V, S ) \
 ( ( 5 >= (V) ) || \
   ( 5 == (V) && PATCHLEVEL >= (S) ) )
#endif

#define WXPERL_W_VERSION_EQ( V, S ) \
 ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION == (S) )
#define WXPERL_W_VERSION_GE( V, S ) \
 ( ( wxMAJOR_VERSION > (V) ) || \
   ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION >= (S) ) )
#define WXPERL_W_VERSION_LE( V, S ) \
 ( ( wxMAJOR_VERSION < (V) ) || \
   ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION <= (S) ) )

#if WXPERL_P_VERSION_EQ( 5, 4 )

// some functions have changed from char* to const char*, and I want
// a stronger type check (under Perl 5.6 CHAR_P is defined to
// an empty string)
#define CHAR_P      (char*)
#define get_sv      perl_get_sv
#define get_av      perl_get_av
#define call_sv     perl_call_sv

#define PL_sv_undef sv_undef
#define PL_sv_yes   sv_yes
#define PL_sv_no    sv_no

#define PL_na       na

#define newSVuv( val ) ( newSViv( (IV)(UV)( val ) ) )
#define SvPV_nolen( s ) SvPV( (s), PL_na )

#endif

#if WXPERL_P_VERSION_EQ( 5, 5 )

#define CHAR_P (char*)
#define get_sv perl_get_sv
#define get_av perl_get_av
#define call_sv perl_call_sv

#define newSVuv( val ) newSViv( (IV)(UV)val )
#define SvPV_nolen( s ) SvPV( (s), PL_na )

#endif

#if WXPERL_P_VERSION_EQ( 5, 6 )

#define CHAR_P

#endif

// Win32 dll stuff
#if __WXMSW__
#  if defined( WXPL_EXT )
#    define WXPLDLL __declspec( dllimport )
#  else
#    define WXPLDLL __declspec( dllexport )
#  endif
#else
#define WXPLDLL
#endif
