#############################################################################
## Name:        StaticLine.xs
## Purpose:     XS for Wx::StaticLine
## Author:      Mattia Barbon
## Modified by:
## Created:     10/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StaticLine

Wx_StaticLine*
Wx_StaticLine::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLI_HORIZONTAL, name = wxT("staticLine") )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliStaticLine( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

bool
Wx_StaticLine::IsVertical()

int
Wx_StaticLine::GetDefaultSize()
