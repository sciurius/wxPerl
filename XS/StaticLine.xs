#############################################################################
## Name:        StaticLine.xs
## Purpose:     XS for Wx::StaticLine
## Author:      Mattia Barbon
## Modified by:
## Created:     10/11/2000
## RCS-ID:      $Id: StaticLine.xs,v 1.5 2003/05/26 20:33:05 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StaticLine

#include <wx/statline.h>

wxStaticLine*
wxStaticLine::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxLI_HORIZONTAL, name = wxT("staticLine") )
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
wxStaticLine::IsVertical()

int
wxStaticLine::GetDefaultSize()
