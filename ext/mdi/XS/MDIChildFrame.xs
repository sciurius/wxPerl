#############################################################################
## Name:        MDIChildFrame.xs
## Purpose:     XS for Wx::MDIChildFrame
## Author:      Mattia Barbon
## Modified by:
## Created:      6/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_MDI_ARCHITECTURE

#include "cpp/mdi.h"

MODULE=Wx PACKAGE=Wx::MDIChildFrame

Wx_MDIChildFrame*
Wx_MDIChildFrame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxT("frame") )
    Wx_MDIParentFrame* parent
    wxWindowID id
    wxString title
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliMDIChildFrame( CLASS, parent, id, title, pos, size,
        style, name );
  OUTPUT:
    RETVAL

void
Wx_MDIChildFrame::Activate()

#if !defined(__WXGTK__) || defined(__WXPERL_FORCE__)

void
Wx_MDIChildFrame::Maximize()

#endif

void
Wx_MDIChildFrame::Restore()

#endif
