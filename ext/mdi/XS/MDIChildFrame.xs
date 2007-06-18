#############################################################################
## Name:        ext/mdi/XS/MDIChildFrame.xs
## Purpose:     XS for Wx::MDIChildFrame
## Author:      Mattia Barbon
## Modified by:
## Created:     06/09/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2002, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_MDI_ARCHITECTURE

#include "cpp/mdi.h"

MODULE=Wx PACKAGE=Wx::MDIChildFrame

wxMDIChildFrame*
wxMDIChildFrame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE, name = wxFrameNameStr )
    wxMDIParentFrame* parent
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliMDIChildFrame( CLASS, parent, id, title, pos, size,
        style, name );
  OUTPUT:
    RETVAL

void
wxMDIChildFrame::Activate()

#if !defined(__WXGTK__) || defined(__WXPERL_FORCE__)

void
wxMDIChildFrame::Maximize()

#endif

void
wxMDIChildFrame::Restore()

#endif
