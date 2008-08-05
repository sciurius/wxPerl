#############################################################################
## Name:        XS/ScrollBar.xs
## Purpose:     XS for Wx::ScrollBar
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2001, 2003-2004, 2006-2008 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/scrolbar.h>

MODULE=Wx PACKAGE=Wx::ScrollBar

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ScrollBar::new" )

wxScrollBar*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxScrollBar();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxScrollBar*
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSB_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxScrollBarNameStr )
    PlClassName CLASS
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

bool
wxScrollBar::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSB_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxScrollBarNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, pos, size, style, *validator, name

int
wxScrollBar::GetRange()

int
wxScrollBar::GetPageSize()

int
wxScrollBar::GetThumbPosition()

int
wxScrollBar::GetThumbSize()

# int
# wxScrollBar::GetThumbLength()

void
wxScrollBar::SetThumbPosition( viewStart )
    int viewStart

#if !defined(__WXMAC__) && !defined(__WXMOTIF__)

void
wxScrollBar::SetPageSize( size )
    int size

#endif

void
wxScrollBar::SetScrollbar( position, thumbSize, range, pageSize, refresh = true )
    int position
    int thumbSize
    int range
    int pageSize
    bool refresh
