#############################################################################
## Name:        XS/StaticBox.xs
## Purpose:     XS for Wx::StaticBox
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id: StaticBox.xs,v 1.7 2004/10/19 20:28:05 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/statbox.h>

MODULE=Wx PACKAGE=Wx::StaticBox

wxStaticBox*
wxStaticBox::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxStaticBox( parent, id, label, pos, 
        size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxStaticBox::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxString name
