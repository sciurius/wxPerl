#############################################################################
## Name:        XS/FontDialog.xs
## Purpose:     XS for Wx::FontDialog and Wx::FontData
## Author:      Mattia Barbon
## Modified by:
## Created:     14/02/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_FONTDLG

#include <wx/fontdlg.h>

MODULE=Wx PACKAGE=Wx::FontData

wxFontData*
wxFontData::new()

static void
wxFontData::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxFontData::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::FontData", THIS, ST(0) );
    delete THIS;

void
wxFontData::EnableEffects( enable )
    bool enable

bool
wxFontData::GetAllowSymbols()

wxColour*
wxFontData::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

wxFont*
wxFontData::GetChosenFont()
  CODE:
    RETVAL = new wxFont( THIS->GetChosenFont() );
  OUTPUT:
    RETVAL

bool
wxFontData::GetEnableEffects()

wxFont*
wxFontData::GetInitialFont()
  CODE:
    RETVAL = new wxFont( THIS->GetInitialFont() );
  OUTPUT:
    RETVAL

bool
wxFontData::GetShowHelp()

void
wxFontData::SetAllowSymbols( allow )
    bool allow

void
wxFontData::SetChosenFont( font )
    wxFont* font
  CODE:
    THIS->SetChosenFont( *font );

void
wxFontData::SetColour( colour )
    wxColour colour

void
wxFontData::SetInitialFont( font )
    wxFont* font
  CODE:
    THIS->SetInitialFont( *font );

void
wxFontData::SetRange( min, max )
    int min
    int max

void
wxFontData::SetShowHelp( show )
    bool show

MODULE=Wx PACKAGE=Wx::FontDialog

wxFontDialog*
wxFontDialog::new( parent, data = 0 )
    wxWindow* parent
    wxFontData* data
  CODE:
    RETVAL = new wxFontDialog( parent, *data );
  OUTPUT:
    RETVAL

wxFontData*
wxFontDialog::GetFontData()
  CODE:
    RETVAL = new wxFontData( THIS->GetFontData() );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx PREFIX=wx

wxFont*
wxGetFontFromUser( parent = 0, fontInit = (wxFont*)&wxNullFont )
    wxWindow* parent
    wxFont* fontInit
  CODE:
    RETVAL = new wxFont( wxGetFontFromUser( parent, *fontInit ) );
  OUTPUT:
    RETVAL

#endif
