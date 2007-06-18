#############################################################################
## Name:        XS/FontEnumerator.xs
## Purpose:     XS for Wx::FontEnumerator
## Author:      Mattia Barbon
## Modified by:
## Created:     13/09/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/fontenum.h>

MODULE=Wx PACKAGE=Wx::FontEnumerator

wxFontEnumerator*
wxFontEnumerator::new()

static void
wxFontEnumerator::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxFontEnumerator::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::FontEnumerator", THIS, ST(0) );
    delete THIS;

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
#if WXPERL_W_VERSION_LT( 2, 7, 0 )
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
#if WXPERL_W_VERSION_LT( 2, 7, 0 )
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
