#############################################################################
## Name:        StaticText.xs
## Purpose:     XS for Wx::StaticText
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StaticText

Wx_StaticText*
Wx_StaticText::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticTextNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString label
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliStaticText( CLASS, parent, id, label,
        pos, size, style, name );
  OUTPUT:
    RETVAL
