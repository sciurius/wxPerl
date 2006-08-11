#############################################################################
## Name:        ext/filesys/XS/FSFile.xs
## Purpose:     XS for Wx::FileSystem
## Author:      Mattia Barbon
## Modified by:
## Created:     28/04/2001
## RCS-ID:      $Id: FSFile.xs,v 1.8 2006/08/11 19:54:59 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>

MODULE=Wx PACKAGE=Wx::FSFile

static void
wxFSFile::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxFSFile::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ), THIS, ST(0) );
    delete THIS;

wxString
wxFSFile::GetAnchor()

wxString
wxFSFile::GetLocation()

wxString
wxFSFile::GetMimeType()

# wxDateTime
# wxFSFile::GetModificationTime()

wxInputStream*
wxFSFile::GetStream()

MODULE=Wx PACKAGE=Wx::FSFile

#include "cpp/fshandler.h"

wxPlFSFile*
wxPlFSFile::new( fh, loc, mimetype, anchor )
    SV* fh
    wxString loc
    wxString mimetype
    wxString anchor
  CODE:
    RETVAL = new wxPlFSFile( fh, loc, mimetype, anchor );
  OUTPUT:
    RETVAL
