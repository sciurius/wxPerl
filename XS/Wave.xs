#############################################################################
## Name:        XS/Wave.xs
## Purpose:     XS for Wx::Wave
## Author:      Mattia Barbon
## Modified by:
## Created:      1/ 1/2003
## RCS-ID:      
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
wxWave::Play( async = TRUE, looped = FALSE )
    bool async
    bool looped

#endif
