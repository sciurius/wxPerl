#############################################################################
## Name:        ext/filesys/XS/FileSystem.xs
## Purpose:     XS for Wx::FileSystem
## Author:      Mattia Barbon
## Modified by:
## Created:     28/04/2001
## RCS-ID:      $Id: FileSystem.xs,v 1.4 2004/03/01 21:24:10 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>

MODULE=Wx PACKAGE=Wx::FileSystem

wxFileSystem*
wxFileSystem::new()

## XXX threads
void
wxFileSystem::DESTROY()

void
AddHandler( handler )
    wxFileSystemHandler* handler
  CODE:
    wxFileSystem::AddHandler( handler );

void
wxFileSystem::ChangePathTo( location, is_dir = FALSE )
    wxString location
    bool is_dir

wxString
wxFileSystem::GetPath()

wxString
wxFileSystem::FindFirst( wildcard, flags = 0 )
    wxString wildcard
    int flags

wxString
wxFileSystem::FindNext()

wxFSFile*
wxFileSystem::OpenFile( location )
    wxString location
