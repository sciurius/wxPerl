#############################################################################
## Name:        FontEnumerator.xs
## Purpose:     XS for Wx::FontEnumerator
## Author:      Mattia Barbon
## Modified by:
## Created:     13/ 9/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/fontenum.h>

MODULE=Wx PACKAGE=Wx::FontEnumerator

wxFontEnumerator*
wxFontEnumerator::new()

void
wxFontEnumerator::DESTROY()

bool
wxFontEnumerator::EnumerateFacenames( encoding = wxFONTENCODING_SYSTEM, fixedWidth = FALSE )
    wxFontEncoding encoding
    bool fixedWidth

bool
wxFontEnumerator::EnumerateEncodings( font = wxEmptyString )
    wxString font

void
wxFontEnumerator::GetEncodings()
  PREINIT:
    wxArrayString* enc;
  PPCODE:
    enc = THIS->GetEncodings();
    if( enc )
    {
        PUTBACK;
        wxPli_stringarray_push( aTHX_ *enc );
        SPAGAIN;
    }

void
wxFontEnumerator::GetFacenames()
  PREINIT:
    wxArrayString* enc;
  PPCODE:
    enc = THIS->GetFacenames();
    if( enc )
    {
        PUTBACK;
        wxPli_stringarray_push( aTHX_ *enc );
        SPAGAIN;
    }
