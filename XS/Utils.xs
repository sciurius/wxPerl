#############################################################################
## Name:        Utils.xs
## Purpose:     XS for some utility classes
## Author:      Mattia Barbon
## Modified by:
## Created:      9/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::CaretSuspend

#if WXPERL_W_VERSION_GE( 2, 3 )

Wx_CaretSuspend*
Wx_CaretSuspend::new( window )
    Wx_Window* window

void
Wx_CaretSuspend::DESTROY()

#endif

MODULE=Wx PACKAGE=Wx::WindowDisabler

Wx_WindowDisabler*
Wx_WindowDisabler::new( skip = 0 )
    Wx_Window* skip

void
Wx_WindowDisabler::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyCursor

Wx_BusyCursor*
Wx_BusyCursor::new( cursor = wxHOURGLASS_CURSOR )
    Wx_Cursor* cursor

void
Wx_BusyCursor::DESTROY()

MODULE=Wx PACKAGE=Wx::BusyInfo

Wx_BusyInfo*
Wx_BusyInfo::new( message )
    wxString message

void
Wx_BusyInfo::DESTROY()



