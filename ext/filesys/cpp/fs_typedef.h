/////////////////////////////////////////////////////////////////////////////
// Name:        fs_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     28/ 4/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_FS_TYPEDEF_H
#define _WXPERL_FS_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

FD_TD( FileSystem );
FD_TD( FileSystemHandler );
FD_TD( FSFile );

FD_TD( InternetFSHandler );
FD_TD( ZipFSHandler );
FD_TD( MemoryFSHandler );

FD_TD( PlFileSystemHandler );
FD_TD( PlFSFile );

#undef FD_TD

#endif
  // _WXPERL_FS_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //


