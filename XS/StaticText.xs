#############################################################################
## Name:        XS/StaticText.xs
## Purpose:     XS for Wx::StaticText
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: StaticText.xs,v 1.4 2003/06/04 20:38:43 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/stattext.h>

MODULE=Wx PACKAGE=Wx::StaticText

wxStaticText*
wxStaticText::new( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticTextNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxStaticText( parent, id, label,
        pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxStaticText::Create( parent, id, label, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticTextNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint pos
    wxSize size
    long style
    wxString name
