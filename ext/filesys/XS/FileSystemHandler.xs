#############################################################################
## Name:        FS.xs
## Purpose:     XS for Wx::FileSystemhandler
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 4/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>
#include <wx/fs_inet.h>
#include <wx/fs_zip.h>
#include <wx/fs_mem.h>

#undef THIS

MODULE=Wx PACKAGE=Wx::FileSystemHandler

MODULE=Wx PACKAGE=Wx::InternetFSHandler

Wx_InternetFSHandler*
Wx_InternetFSHandler::new()

MODULE=Wx PACKAGE=Wx::ZipFSHandler

Wx_ZipFSHandler*
Wx_ZipFSHandler::new()

MODULE=Wx PACKAGE=Wx::MemoryFSHandler

MODULE=Wx PACKAGE=Wx::PlFileSystemHandler

#include "cpp/fshandler.h"

Wx_PlFileSystemHandler*
Wx_PlFileSystemhandler::new()
  CODE:
    RETVAL = new wxPlFileSystemHandler( CLASS );
  OUTPUT:
    RETVAL

