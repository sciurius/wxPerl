#############################################################################
## Name:        DropSource.xs
## Purpose:     XS for Wx::DropSource
## Author:      Mattia Barbon
## Modified by:
## Created:     16/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dnd.h>
#include "cpp/dropsource.h"

MODULE=Wx PACKAGE=Wx::DropSource

#if defined( __WXMSW__ )

Wx_DropSource*
newCursorEmpty( CLASS, win = 0, cursorCopy = (wxCursor*)&wxNullCursor, cursorMove = (wxCursor*)&wxNullCursor, cursorStop = (wxCursor*)&wxNullCursor )
    SV* CLASS 
    Wx_Window* win
    Wx_Cursor* cursorCopy
    Wx_Cursor* cursorMove
    Wx_Cursor* cursorStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), win,
                                  *cursorCopy, *cursorMove,
        *cursorStop );
  OUTPUT:
    RETVAL

Wx_DropSource*
newCursorData( CLASS, data, win = 0, cursorCopy = (wxCursor*)&wxNullCursor, cursorMove = (wxCursor*)&wxNullCursor, cursorStop = (wxCursor*)&wxNullCursor )
    SV* CLASS
    Wx_DataObject* data
    Wx_Window* win
    Wx_Cursor* cursorCopy
    Wx_Cursor* cursorMove
    Wx_Cursor* cursorStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), *data, win,
                                  *cursorCopy, *cursorMove,
        *cursorStop );
  OUTPUT:
    RETVAL

#else

Wx_DropSource*
newIconEmpty( CLASS, win = 0, iconCopy = (wxIcon*)&wxNullIcon, iconMove = (wxIcon*)&wxNullIcon, iconStop = (wxIcon*)&wxNullIcon )
    SV* CLASS
    Wx_Window* win
    Wx_Icon* iconCopy
    Wx_Icon* iconMove
    Wx_Icon* iconStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), win,
                                  *iconCopy, *iconMove, *iconStop );
  OUTPUT:
    RETVAL

Wx_DropSource*
newIconData( CLASS, data, win = 0, iconCopy = (wxIcon*)&wxNullIcon, iconMove = (wxIcon*)&wxNullIcon, iconStop = (wxIcon*)&wxNullIcon )
    SV* CLASS
    Wx_DataObject* data
    Wx_Window* win
    Wx_Icon* iconCopy
    Wx_Icon* iconMove
    Wx_Icon* iconStop
  CODE:
    RETVAL = new wxPliDropSource( wxPli_get_class( aTHX_ CLASS ), *data, win,
                                  *iconCopy, *iconMove, *iconStop );
  OUTPUT:
    RETVAL

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

wxDragResult
Wx_DropSource::DoDragDrop( flags = wxDrag_CopyOnly )
    int flags

#else

wxDragResult
Wx_DropSource::DoDragDrop( allowMove = FALSE )
    bool allowMove

#endif

void
Wx_DropSource::SetData( data )
    Wx_DataObject* data
  CODE:
    THIS->SetData( *data );

Wx_DataObject*
Wx_DropSource::GetDataObject()
  CODE:
    RETVAL = THIS->GetDataObject();
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

void
Wx_DropSource::SetCursor( res, cursor )
    wxDragResult res
    Wx_Cursor* cursor
  CODE:
    THIS->SetCursor( res, *cursor );
