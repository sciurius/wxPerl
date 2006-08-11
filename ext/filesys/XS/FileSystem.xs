#############################################################################
## Name:        ext/filesys/XS/FileSystem.xs
## Purpose:     XS for Wx::FileSystem
## Author:      Mattia Barbon
## Modified by:
## Created:     28/04/2001
## RCS-ID:      $Id: FileSystem.xs,v 1.7 2006/08/11 19:38:45 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>

MODULE=Wx PACKAGE=Wx::FileSystem

wxFileSystem*
wxFileSystem::new()

static void
wxFileSystem::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxFileSystem::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::FileSystem", THIS, ST(0) );
    delete THIS;

void
AddHandler( handler )
    wxFileSystemHandler* handler
  CODE:
    wxFileSystem::AddHandler( handler );

void
wxFileSystem::ChangePathTo( location, is_dir = false )
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
