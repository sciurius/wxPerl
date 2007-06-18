#############################################################################
## Name:        XS/StaticLine.xs
## Purpose:     XS for Wx::StaticLine
## Author:      Mattia Barbon
## Modified by:
## Created:     10/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2003, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StaticLine

#include <wx/statline.h>

wxStaticLine*
wxStaticLine::new( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLI_HORIZONTAL, name = wxStaticTextNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxStaticLine( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxStaticLine::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLI_HORIZONTAL, name = wxStaticTextNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

bool
wxStaticLine::IsVertical()

int
wxStaticLine::GetDefaultSize()
