#############################################################################
## Name:        XS/ScrollBar.xs
## Purpose:     XS for Wx::ScrollBar
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: ScrollBar.xs,v 1.4 2003/05/31 15:36:56 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/scrolbar.h>

MODULE=Wx PACKAGE=Wx::ScrollBar

wxScrollBar*
wxScrollBar::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSB_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxScrollBarNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxScrollBar( parent, id, pos, size, style, 
        *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

int
wxScrollBar::GetRange()

int
wxScrollBar::GetPageSize()

int
wxScrollBar::GetThumbPosition()

# int
# wxScrollBar::GetThumbLength()

void
wxScrollBar::SetThumbPosition( viewStart )
    int viewStart

void
wxScrollBar::SetScrollbar( position, thumbSize, range, pageSize, refresh = TRUE )
    int position
    int thumbSize
    int range
    int pageSize
    bool refresh
