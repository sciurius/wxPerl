#############################################################################
## Name:        App.xs
## Purpose:     XS for Wx::ToolTip
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
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

Wx_ToolTip*
Wx_ToolTip::new( string )
    wxString string

void
Wx_ToolTip::SetTip( tip )
    wxString tip

wxString
Wx_ToolTip::GetTip()

Wx_Window*
Wx_ToolTip::GetWindow()

#endif
