#############################################################################
## Name:        XS/Wave.xs
## Purpose:     XS for Wx::Wave
## Author:      Mattia Barbon
## Modified by:
## Created:     01/01/2003
## RCS-ID:      $Id: Wave.xs,v 1.3 2004/08/04 20:13:55 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxPERL_USE_WAVE

#include <wx/wave.h>

MODULE=Wx PACKAGE=Wx::Wave

wxWave*
wxWave::new( fileName )
    wxString fileName

bool
wxWave::IsOk()

bool
wxWave::Play( async = true, looped = false )
    bool async
    bool looped

#endif
