#############################################################################
## Name:        FontDialog.xs
## Purpose:     XS for Wx::FontDialog and Wx::FontData
## Author:      Mattia Barbon
## Modified by:
## Created:     14/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_FONTDLG

#include <wx/fontdlg.h>

MODULE=Wx PACKAGE=Wx::FontData

Wx_FontData*
Wx_FontData::new()

void
Wx_FontData::DESTROY()

void
Wx_FontData::EnableEffects( enable )
    bool enable

bool
Wx_FontData::GetAllowSymbols()

Wx_Colour*
Wx_FontData::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_FontData::GetChosenFont()
  CODE:
    RETVAL = new wxFont( THIS->GetChosenFont() );
  OUTPUT:
    RETVAL

bool
Wx_FontData::GetEnableEffects()

Wx_Font*
Wx_FontData::GetInitialFont()
  CODE:
    RETVAL = new wxFont( THIS->GetInitialFont() );
  OUTPUT:
    RETVAL

bool
Wx_FontData::GetShowHelp()

void
Wx_FontData::SetAllowSymbols( allow )
    bool allow

void
Wx_FontData::SetChosenFont( font )
    Wx_Font* font
  CODE:
    THIS->SetChosenFont( *font );

void
Wx_FontData::SetColour( colour )
    Wx_Colour colour

void
Wx_FontData::SetInitialFont( font )
    Wx_Font* font
  CODE:
    THIS->SetInitialFont( *font );

void
Wx_FontData::SetRange( min, max )
    int min
    int max

void
Wx_FontData::SetShowHelp( show )
    bool show

MODULE=Wx PACKAGE=Wx::FontDialog

Wx_FontDialog*
Wx_FontDialog::new( parent, data = 0 )
    Wx_Window* parent
    Wx_FontData* data

Wx_FontData*
Wx_FontDialog::GetFontData()
  CODE:
    RETVAL = new wxFontData( THIS->GetFontData() );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx PREFIX=wx

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

Wx_Font*
wxGetFontFromUser( parent = 0, fontInit = (wxFont*)&wxNullFont )
    Wx_Window* parent
    Wx_Font* fontInit
  CODE:
    RETVAL = new wxFont( wxGetFontFromUser( parent, *fontInit ) );
  OUTPUT:
    RETVAL

#endif

#endif
