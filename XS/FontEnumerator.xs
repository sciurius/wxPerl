#############################################################################
## Name:        XS/FontEnumerator.xs
## Purpose:     XS for Wx::FontEnumerator
## Author:      Mattia Barbon
## Modified by:
## Created:     13/09/2002
## RCS-ID:      $Id: FontEnumerator.xs,v 1.2 2004/08/04 20:13:54 mbarbon Exp $
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
wxFontEnumerator::EnumerateFacenames( encoding = wxFONTENCODING_SYSTEM, fixedWidth = false )
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
