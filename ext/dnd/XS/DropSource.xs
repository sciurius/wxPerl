#############################################################################
## Name:        ext/dnd/XS/DropSource.xs
## Purpose:     XS for Wx::DropSource
## Author:      Mattia Barbon
## Modified by:
## Created:     16/08/2001
## RCS-ID:      $Id: DropSource.xs,v 1.6 2004/03/02 21:12:35 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dnd.h>
#include "cpp/dropsource.h"

MODULE=Wx PACKAGE=Wx::DropSource

#if defined( __WXMSW__ )

wxDropSource*
newCursorEmpty( CLASS, win = 0, cursorCopy = (wxCursor*)&wxNullCursor, cursorMove = (wxCursor*)&wxNullCursor, cursorStop = (wxCursor*)&wxNullCursor )
    SV* CLASS 
    wxWindow* win
    wxCursor* cursorCopy
    wxCursor* cursorMove
    wxCursor* cursorStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), win,
                                  *cursorCopy, *cursorMove,
        *cursorStop );
  OUTPUT:
    RETVAL

wxDropSource*
newCursorData( CLASS, data, win = 0, cursorCopy = (wxCursor*)&wxNullCursor, cursorMove = (wxCursor*)&wxNullCursor, cursorStop = (wxCursor*)&wxNullCursor )
    SV* CLASS
    wxDataObject* data
    wxWindow* win
    wxCursor* cursorCopy
    wxCursor* cursorMove
    wxCursor* cursorStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), *data, win,
                                  *cursorCopy, *cursorMove,
        *cursorStop );
  OUTPUT:
    RETVAL

#else

wxDropSource*
newIconEmpty( CLASS, win = 0, iconCopy = (wxIcon*)&wxNullIcon, iconMove = (wxIcon*)&wxNullIcon, iconStop = (wxIcon*)&wxNullIcon )
    SV* CLASS
    wxWindow* win
    wxIcon* iconCopy
    wxIcon* iconMove
    wxIcon* iconStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), win,
                                  *iconCopy, *iconMove, *iconStop );
  OUTPUT:
    RETVAL

wxDropSource*
newIconData( CLASS, data, win = 0, iconCopy = (wxIcon*)&wxNullIcon, iconMove = (wxIcon*)&wxNullIcon, iconStop = (wxIcon*)&wxNullIcon )
    SV* CLASS
    wxDataObject* data
    wxWindow* win
    wxIcon* iconCopy
    wxIcon* iconMove
    wxIcon* iconStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), *data, win,
                                  *iconCopy, *iconMove, *iconStop );
  OUTPUT:
    RETVAL

#endif

wxDragResult
wxDropSource::DoDragDrop( flags = wxDrag_CopyOnly )
    int flags

void
wxDropSource::SetData( data )
    wxDataObject* data
  CODE:
    THIS->SetData( *data );

wxDataObject*
wxDropSource::GetDataObject()
  CODE:
    RETVAL = THIS->GetDataObject();
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

void
wxDropSource::SetCursor( res, cursor )
    wxDragResult res
    wxCursor* cursor
  CODE:
    THIS->SetCursor( res, *cursor );
