#############################################################################
## Name:        ext/filesys/XS/FileSystemHandler.xs
## Purpose:     XS for Wx::FileSystemhandler
## Author:      Mattia Barbon
## Modified by:
## Created:     28/04/2001
## RCS-ID:      $Id: FileSystemHandler.xs,v 1.7 2004/03/01 21:24:10 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/filesys.h>
#include <wx/fs_inet.h>
#include <wx/fs_zip.h>
#include <wx/fs_mem.h>

#undef THIS

MODULE=Wx PACKAGE=Wx::FileSystemHandler

#if 0

wxString
wxFileSystemHandler::GetAnchor( location )
    wxString location

wxString
wxFileSystemHandler::GetLeftLocation( location )
    wxString location

wxString
wxFileSystemHandler::GetMimeTypeFromExt( location )
    wxString location

wxString
wxFileSystemHandler::GetProtocol( location )
    wxString location

wxString
wxFileSystemHandler::GetRightLocation( location )
    wxString location

#endif

MODULE=Wx PACKAGE=Wx::InternetFSHandler

#if wxUSE_PROTOCOL_HTTP || wxUSE_PROTOCOL_FTP

wxInternetFSHandler*
wxInternetFSHandler::new()

#endif

MODULE=Wx PACKAGE=Wx::ZipFSHandler

wxZipFSHandler*
wxZipFSHandler::new()

MODULE=Wx PACKAGE=Wx::MemoryFSHandler

wxMemoryFSHandler*
wxMemoryFSHandler::new()

void
AddImageFile( name, image, type )
    wxString name
    wxImage* image
    long type
  CODE:
    wxMemoryFSHandler::AddFile( name, *image, type );

void
AddBitmapFile( name, bitmap, type )
    wxString name
    wxBitmap* bitmap
    long type
  CODE:
    wxMemoryFSHandler::AddFile( name, *bitmap, type );

void
AddTextFile( name, string )
    wxString name
    wxString string
  CODE:
    wxMemoryFSHandler::AddFile( name, string );

void
AddBinaryFile( name, scalar )
    wxString name
    SV* scalar
  PREINIT:
    STRLEN len;
    char* data = SvPV( scalar, len );
  CODE:
    wxMemoryFSHandler::AddFile( name, data, len );

void
RemoveFile( name )
    wxString name
  CODE:
    wxMemoryFSHandler::RemoveFile( name );

MODULE=Wx PACKAGE=Wx::PlFileSystemHandler

#include "cpp/fshandler.h"

wxPlFileSystemHandler*
wxPlFileSystemhandler::new()
  CODE:
    RETVAL = new wxPlFileSystemHandler( CLASS );
  OUTPUT:
    RETVAL

