#############################################################################
## Name:        ScrollBar.xs
## Purpose:     XS for Wx::ScrollBar
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ScrollBar

Wx_ScrollBar*
Wx_ScrollBar::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSB_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxScrollBarNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new wxPliScrollBar( CLASS, parent, id, pos, size, style, 
        *validator, name );
  OUTPUT:
    RETVAL

int
Wx_ScrollBar::GetRange()

int
Wx_ScrollBar::GetPageSize()

int
Wx_ScrollBar::GetThumbPosition()

# int
# Wx_ScrollBar::GetThumbLength()

void
Wx_ScrollBar::SetThumbPosition( viewStart )
    int viewStart

void
Wx_ScrollBar::SetScrollbar( position, thumbSize, range, pageSize, refresh = TRUE )
    int position
    int thumbSize
    int range
    int pageSize
    bool refresh
