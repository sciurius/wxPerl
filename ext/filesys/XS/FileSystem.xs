#############################################################################
## Name:        FS.xs
## Purpose:     XS for Wx::FileSystem
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 4/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>

MODULE=Wx PACKAGE=Wx::FileSystem

Wx_FileSystem*
Wx_FileSystem::new()

void
Wx_FileSystem::DESTROY()

void
AddHandler( handler )
    Wx_FileSystemHandler* handler
  CODE:
    wxFileSystem::AddHandler( handler );

void
Wx_FileSystem::ChangePathTo( location, is_dir = FALSE )
    wxString location
    bool is_dir

wxString
Wx_FileSystem::GetPath()

wxString
Wx_FileSystem::FindFirst( wildcard, flags = 0 )
    wxString wildcard
    int flags

wxString
Wx_FileSystem::FindNext()

Wx_FSFile*
Wx_FileSystem::OpenFile( location )
    wxString location
