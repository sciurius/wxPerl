#############################################################################
## Name:        MDIParentFrame.xs
## Purpose:     XS for Wx::MDIParentFrame
## Author:      Mattia Barbon
## Modified by:
## Created:      6/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_MDI_ARCHITECTURE

#include <wx/menu.h>
#include "cpp/mdi.h"

MODULE=Wx PACKAGE=Wx::MDIParentFrame

Wx_MDIParentFrame*
Wx_MDIParentFrame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE|wxVSCROLL|wxHSCROLL, name = wxT("frame") )
    Wx_Window* parent
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliMDIParentFrame( CLASS );
    RETVAL->Create( parent, id, title, pos, size, style, name );
  OUTPUT:
    RETVAL

void
Wx_MDIParentFrame::ActivateNext()

void
Wx_MDIParentFrame::ActivatePrevious()

void
Wx_MDIParentFrame::ArrangeIcons()

void
Wx_MDIParentFrame::Cascade()

Wx_MDIChildFrame*
Wx_MDIParentFrame::GetActiveChild()

Wx_MDIClientWindow*
Wx_MDIParentFrame::GetClientWindow()

#if ( !defined(__WXGTK__) && !defined(__WXMAC__) ) || defined(__WXPERL_FORCE__)

Wx_Menu*
Wx_MDIParentFrame::GetWindowMenu()

void
Wx_MDIParentFrame::SetWindowMenu( menu )
    Wx_Menu* menu

#endif

void
Wx_MDIParentFrame::Tile()

#endif
