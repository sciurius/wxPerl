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

#define WXPERL_P_VERSION ( PERL_REVISION * 1000 + PERL_VERSION )

#if WXPERL_P_VERSION == 5004

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

#endif // WXPERL_P_VERSION

#if WXPERL_P_VERSION == 5005 

#define CHAR_P (char*)
#define get_sv perl_get_sv
#define get_av perl_get_av
#define call_sv perl_call_sv

#endif // WXPERL_P_VERSION

#if WXPERL_P_VERSION == 5006

#define CHAR_P

#endif // WXPERL_P_VERSION
