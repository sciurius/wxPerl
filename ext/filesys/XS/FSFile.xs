#############################################################################
## Name:        FS.xs
## Purpose:     XS for Wx::FileSystem
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 4/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>

MODULE=Wx PACKAGE=Wx::FSFile

## XXX threads
void
Wx_FSFile::DESTROY()

wxString
Wx_FSFile::GetAnchor()

wxString
Wx_FSFile::GetLocation()

wxString
Wx_FSFile::GetMimeType()

# wxDateTime
# Wx_FSFile::GetModificationTime()

wxInputStream*
Wx_FSFile::GetStream()

MODULE=Wx PACKAGE=Wx::FSFile

#include "cpp/fshandler.h"

Wx_PlFSFile*
Wx_PlFSFile::new( fh, loc, mimetype, anchor )
    SV* fh
    wxString loc
    wxString mimetype
    wxString anchor
  CODE:
    RETVAL = new wxPlFSFile( fh, loc, mimetype, anchor );
  OUTPUT:
    RETVAL
