#############################################################################
## Name:        ext/mdi/XS/MDIParentFrame.xs
## Purpose:     XS for Wx::MDIParentFrame
## Author:      Mattia Barbon
## Modified by:
## Created:     06/09/2001
## RCS-ID:      $Id: MDIParentFrame.xs,v 1.10 2005/04/03 09:12:44 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_MDI_ARCHITECTURE

#include <wx/menu.h>
#include "cpp/mdi.h"

MODULE=Wx PACKAGE=Wx::MDIParentFrame

wxMDIParentFrame*
wxMDIParentFrame::new( parent, id, title, pos = wxDefaultPosition, size = wxDefaultSize, style = wxDEFAULT_FRAME_STYLE|wxVSCROLL|wxHSCROLL, name = wxT("frame") )
    wxWindow* parent
    wxWindowID id
    wxString title
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliMDIParentFrame( CLASS );
    RETVAL->Create( parent, id, title, pos, size, style, name );
  OUTPUT:
    RETVAL

void
wxMDIParentFrame::ActivateNext()

void
wxMDIParentFrame::ActivatePrevious()

void
wxMDIParentFrame::ArrangeIcons()

void
wxMDIParentFrame::Cascade()

wxMDIChildFrame*
wxMDIParentFrame::GetActiveChild()

#ifdef __WXUNIVERSAL__

wxGenericMDIClientWindow*
wxMDIParentFrame::GetClientWindow()

#else

wxMDIClientWindow*
wxMDIParentFrame::GetClientWindow()

#endif

#if ( !defined(__WXGTK__) && !defined(__WXMAC__) && !defined(__WXMOTIF__) ) \
    || defined(__WXPERL_FORCE__)

wxMenu*
wxMDIParentFrame::GetWindowMenu()

void
wxMDIParentFrame::SetWindowMenu( menu )
    wxMenu* menu

#endif

#if WXPERL_W_VERSION_GE( 2, 5, 4 )

void
wxMDIParentFrame::Tile( orient = wxHORIZONTAL )
    wxOrientation orient

#else


void
wxMDIParentFrame::Tile()

#endif

#endif
