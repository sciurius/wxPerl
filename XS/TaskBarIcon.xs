#############################################################################
## Name:        XS/TaskBarIcon.xs
## Purpose:     XS for Wx::TaskBarIcon
## Author:      Mattia Barbon
## Modified by:
## Created:     03/12/2001
## RCS-ID:      $Id: TaskBarIcon.xs,v 1.5 2005/01/09 23:56:51 mbarbon Exp $
## Copyright:   (c) 2001, 2004-2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::TaskBarIcon

#if defined(__WXMSW__) || \
    ( WXPERL_W_VERSION_GE( 2, 5, 2 ) && defined( wxHAS_TASK_BAR_ICON ) )

#include <wx/taskbar.h>

wxTaskBarIcon*
wxTaskBarIcon::new()

void
wxTaskBarIcon::Destroy()
  CODE:
    delete THIS;

bool
wxTaskBarIcon::IsIconInstalled()

bool
wxTaskBarIcon::SetIcon( icon, tooltip = wxEmptyString )
    wxIcon* icon
    wxString tooltip
  CODE:
    RETVAL = THIS->SetIcon( *icon, tooltip );
  OUTPUT:
    RETVAL

bool
wxTaskBarIcon::RemoveIcon()

bool
wxTaskBarIcon::PopupMenu( menu )
    wxMenu* menu

#endif
