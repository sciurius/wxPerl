#############################################################################
## Name:        StatusBar.xs
## Purpose:     XS for Wx::StatusBar
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/statusbr.h>

MODULE=Wx PACKAGE=Wx::StatusBar

Wx_StatusBar*
Wx_StatusBar::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxEmptyString )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxStatusBar( parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

int
Wx_StatusBar::GetFieldsCount()

wxString
Wx_StatusBar::GetStatusText( ir = 0 )
    int ir

void
Wx_StatusBar::SetFieldsCount( number = 1 )
    int number

void
Wx_StatusBar::SetMinHeight( height )
    int height

void
Wx_StatusBar::SetStatusText( text, i = 0 )
    wxString text
    int i

void
Wx_StatusBar::SetStatusWidths( ... )
  PREINIT:
    int* widths;
    int i;
  CODE:
    widths = new int[items-1];
    for( i = 1; i < items; ++i )
    {
      widths[i-1] = SvIV( ST(i) );
    }
    THIS->SetStatusWidths( items-1, widths );

    delete[] widths;