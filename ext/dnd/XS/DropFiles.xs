#############################################################################
## Name:        ext/dnd/XS/DropFiles.xs
## Purpose:     XS for Wx::DropFilesEvent
## Author:      Mattia Barbon
## Modified by:
## Created:     15/08/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001, 2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/event.h>

MODULE=wxEvt PACKAGE=Wx::DropFilesEvent

void
wxDropFilesEvent::GetFiles()
  PPCODE:
    wxString* files = THIS->GetFiles();
    int i, max = THIS->GetNumberOfFiles();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i )
    {
#if wxUSE_UNICODE
      SV* tmp = sv_2mortal( newSVpv( CHAR_P files[i].mb_str(wxConvUTF8), 0 ) );
      SvUTF8_on( tmp );
      PUSHs( tmp );
#else
      PUSHs( sv_2mortal( newSVpv( CHAR_P files[i].c_str(), 0 ) ) );
#endif
    }

int
wxDropFilesEvent::GetNumberOfFiles()

wxPoint*
wxDropFilesEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

