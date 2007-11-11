#############################################################################
## Name:        XS/ToolTip.xs
## Purpose:     XS for Wx::ToolTip
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2002, 2004, 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_TOOLTIPS

#include <wx/tooltip.h>

MODULE=Wx PACKAGE=Wx::ToolTip

void
Enable( enable )
    bool enable
  CODE:
    wxToolTip::Enable( enable );

void
SetDelay( msecs )
    long msecs
  CODE:
    wxToolTip::SetDelay( msecs );

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

void
SetAutoPop( msecs )
    long msecs
  CODE:
    wxToolTip::SetAutoPop( msecs );

void
SetReshow( msecs )
    long msecs
  CODE:
    wxToolTip::SetReshow( msecs );

#endif

wxToolTip*
wxToolTip::new( string )
    wxString string

void
wxToolTip::SetTip( tip )
    wxString tip

wxString
wxToolTip::GetTip()

wxWindow*
wxToolTip::GetWindow()

#endif
