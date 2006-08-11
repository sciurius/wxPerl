#############################################################################
## Name:        XS/FontEnumerator.xs
## Purpose:     XS for Wx::FontEnumerator
## Author:      Mattia Barbon
## Modified by:
## Created:     13/09/2002
## RCS-ID:      $Id: FontEnumerator.xs,v 1.5 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2002, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/fontenum.h>

MODULE=Wx PACKAGE=Wx::FontEnumerator

wxFontEnumerator*
wxFontEnumerator::new()

## // thread KO
void
wxFontEnumerator::DESTROY()

bool
wxFontEnumerator::EnumerateFacenames( encoding = wxFONTENCODING_SYSTEM, fixedWidth = false )
    wxFontEncoding encoding
    bool fixedWidth

bool
wxFontEnumerator::EnumerateEncodings( font = wxEmptyString )
    wxString font

void
wxFontEnumerator::GetEncodings()
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 7, 0 )
    wxArrayString enc;
#else
    wxArrayString* enc;
#endif
  PPCODE:
    enc = THIS->GetEncodings();
#if !WXPERL_W_VERSION_GE( 2, 7, 0 )
    if( enc )
#endif
    {
        PUTBACK;
#if WXPERL_W_VERSION_GE( 2, 7, 0 )
        wxPli_stringarray_push( aTHX_ enc );
#else
        wxPli_stringarray_push( aTHX_ *enc );
#endif
        SPAGAIN;
    }

void
wxFontEnumerator::GetFacenames()
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 7, 0 )
    wxArrayString enc;
#else
    wxArrayString* enc;
#endif
  PPCODE:
    enc = THIS->GetFacenames();
#if !WXPERL_W_VERSION_GE( 2, 7, 0 )
    if( enc )
#endif
    {
        PUTBACK;
#if WXPERL_W_VERSION_GE( 2, 7, 0 )
        wxPli_stringarray_push( aTHX_ enc );
#else
        wxPli_stringarray_push( aTHX_ *enc );
#endif
        SPAGAIN;
    }
