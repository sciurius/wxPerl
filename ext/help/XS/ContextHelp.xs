#############################################################################
## Name:        ContextHelp.xs
## Purpose:     XS for Wx::ContextHelp, Wx::ContextHelpButton
## Author:      Mattia Barbon
## Modified by:
## Created:     21/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

#include <wx/cshelp.h>

MODULE=Wx PACKAGE=Wx::ContextHelp

Wx_ContextHelp*
Wx_ContextHelp::new( window = NULL, beginHelp = TRUE )
    Wx_Window* window
    bool beginHelp
  CODE:
    RETVAL = new wxContextHelp( window, beginHelp );
  OUTPUT:
    RETVAL

void
Wx_ContextHelp::DESTROY()

bool
Wx_ContextHelp::BeginContextHelp( window )
    Wx_Window* window

bool
Wx_ContextHelp::EndContextHelp()

void
Wx_ContextHelp::SetStatus( status )
    bool status

MODULE=Wx PACKAGE=Wx::ContextHelpButton

Wx_ContextHelpButton*
Wx_ContextHelpButton::new( parent, id = wxID_CONTEXT_HELP, pos = wxDefaultPosition, size = wxDefaultSize, style = wxBU_AUTODRAW )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
  CODE:
    RETVAL = new wxContextHelpButton( parent, id, pos, size, style );
  OUTPUT:
    RETVAL

#endif
