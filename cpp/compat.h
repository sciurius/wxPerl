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

#if !defined( PERL_REVISION ) && !defined( PATCHLEVEL )
#include <patchlevel.h>
#endif

// < 5.6 does not define PERL_
#ifdef PERL_REVISION
#define WXPERL_P_VERSION_EQ( V, S, P ) \
 ( ( PERL_REVISION == (V) ) && ( PERL_VERSION == (S) ) && ( PERL_SUBVERSION == (P) ) )
#define WXPERL_P_VERSION_GE( V, S, P ) \
 ( ( PERL_REVISION > (V) ) || \
   ( PERL_REVISION == (V) && PERL_VERSION > (S) ) || \
   ( PERL_REVISION == (V) && PERL_VERSION == (S) && PERL_SUBVERSION >= (P) ) )

#else
#define WXPERL_P_VERSION_EQ( V, S, P ) \
 ( ( 5 == (V) ) && ( PATCHLEVEL == (S) ) && ( SUBVERSION == (P) ) )
#define WXPERL_P_VERSION_GE( V, S, P ) \
 ( ( 5 > (V) ) || \
   ( 5 == (V) && PATCHLEVEL > (S) ) || \
   ( 5 == (V) && PATCHLEVEL == (S) && SUBVERSION >= (P) ) )

#endif

#define WXPERL_W_VERSION_EQ( V, S, P ) \
 ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION == (S) && wxRELEASE_NUMBER == (P) )
#define WXPERL_W_VERSION_GE( V, S, P ) \
 ( ( wxMAJOR_VERSION > (V) ) || \
   ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION > (S) ) || \
   ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION == (S) && wxRELEASE_NUMBER >= (P) ) )
#define WXPERL_W_VERSION_LE( V, S, P ) \
 ( ( wxMAJOR_VERSION < (V) ) || \
   ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION < (S) ) || \
   ( wxMAJOR_VERSION == (V) && wxMINOR_VERSION == (S) && wxRELEASE_NUMBER <= (P) ) )

#if WXPERL_P_VERSION_GE( 5, 4, 0 ) && !WXPERL_P_VERSION_GE( 5, 5, 0 )

// some functions have changed from char* to const char*, and I want
// a stronger type check (under Perl 5.6 CHAR_P is defined to
// an empty string)
#define CHAR_P      (char*)
#define get_sv      perl_get_sv
#define get_av      perl_get_av
#define call_sv     perl_call_sv
#define eval_pv     perl_eval_pv

#define PL_sv_undef sv_undef
#define PL_sv_yes   sv_yes
#define PL_sv_no    sv_no

#define PL_na       na

#define newSVuv( val ) ( newSViv( (IV)(UV)( val ) ) )
#define SvPV_nolen( s ) SvPV( (s), PL_na )

#endif

#if WXPERL_P_VERSION_GE( 5, 5, 0 ) && !WXPERL_P_VERSION_GE( 5, 6, 0 )

#define CHAR_P (char*)
#define get_sv perl_get_sv
#define get_av perl_get_av
#define call_sv perl_call_sv
#define eval_pv perl_eval_pv

#define newSVuv( val ) newSViv( (IV)(UV)val )
#define SvPV_nolen( s ) SvPV( (s), PL_na )

#endif

#if WXPERL_P_VERSION_GE( 5, 6, 0 )

#define CHAR_P

#else

#define pTHX
#define aTHX
#define dTHX
#define pTHX_
#define aTHX_

#endif

#define WXINTL_NO_GETTEXT_MACRO 1

// Win32 dll stuff
#if defined(__WXMSW__) && WXPL_USE_DLLEXPORT
#define WXPL_MSW_EXPORTS 1
#else
#define WXPL_MSW_EXPORTS 0
#endif

#if defined(WIN32) || defined(__CYGWIN__)
#  if WXPERL_P_VERSION_GE( 5, 6, 0 )
#    define WXXS( name ) __declspec(dllexport) void name( pTHXo_ CV* cv )
#  else
#    ifdef PERL_OBJECT
#      define WXXS( name ) __declspec( dllexport ) void name(CV* cv, CPerlObj* pPerl)
#    else
#      define WXXS( name ) __declspec( dllexport ) void name(CV* cv)
#    endif
#  endif
#endif

#if WXPL_MSW_EXPORTS
#  if defined( WXPL_EXT )
#    define WXPLDLL __declspec( dllimport )
#  else
#    define WXPLDLL __declspec( dllexport )
#  endif
#  define FUNCPTR( name ) name
#else
#  define WXPLDLL
#  if defined( WXPL_EXT ) && !defined( WXPL_STATIC )
#    define FUNCPTR( name ) ( * name )
#  else
#    define FUNCPTR( name ) name
#  endif
#endif

// puts extern "C" around perl headers
#if defined(__CYGWIN__)
#define WXPL_EXTERN_C_START extern "C" {
#define WXPL_EXTERN_C_END   }
#else
#define WXPL_EXTERN_C_START
#define WXPL_EXTERN_C_END
#endif

