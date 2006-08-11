#############################################################################
## Name:        ext/help/XS/ContextHelp.xs
## Purpose:     XS for Wx::ContextHelp, Wx::ContextHelpButton
## Author:      Mattia Barbon
## Modified by:
## Created:     21/03/2001
## RCS-ID:      $Id: ContextHelp.xs,v 1.7 2006/08/11 19:38:46 mbarbon Exp $
## Copyright:   (c) 2001, 2003, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cshelp.h>

#undef THIS

MODULE=Wx PACKAGE=Wx::ContextHelp

wxContextHelp*
wxContextHelp::new( window = NULL, beginHelp = true )
    wxWindow* window
    bool beginHelp
  CODE:
    RETVAL = new wxContextHelp( window, beginHelp );
  OUTPUT:
    RETVAL

## // thread KO
void
wxContextHelp::DESTROY()

bool
wxContextHelp::BeginContextHelp( window )
    wxWindow* window

bool
wxContextHelp::EndContextHelp()

void
wxContextHelp::SetStatus( status )
    bool status

MODULE=Wx PACKAGE=Wx::ContextHelpButton

wxContextHelpButton*
wxContextHelpButton::new( parent, id = wxID_CONTEXT_HELP, pos = wxDefaultPosition, size = wxDefaultSize, style = wxBU_AUTODRAW )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
  CODE:
    RETVAL = new wxContextHelpButton( parent, id, pos, size, style );
  OUTPUT:
    RETVAL
