#############################################################################
## Name:        DropTarget.xs
## Purpose:     XS for Wx::*DropTarget
## Author:      Mattia Barbon
## Modified by:
## Created:     16/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dnd.h>
#include "cpp/droptarget.h"

MODULE=Wx PACKAGE=Wx::DropTarget

SV*
Wx_DropTarget::new( data = 0 )
    Wx_DataObject* data
  CODE:
    wxPliDropTarget* retval = new wxPliDropTarget( CLASS, data );
    RETVAL = retval->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL

## XXX threads
void
DESTROY( THIS )
    Wx_DropTarget* THIS
  CODE:
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;
  
void
Wx_DropTarget::GetData()

void
Wx_DropTarget::SetDataObject( data )
    Wx_DataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), FALSE );
    THIS->SetDataObject( data );

# callbacks

# wxDragResult
# Wx_DropTarget::OnData( x, y, def )
#     wxCoord x
#     wxCoord y
#     wxDragResult def
#   CODE:
#     RETVAL = THIS->wxDropTarget::OnData( x, y, def );
#   OUTPUT:
#     RETVAL

wxDragResult
Wx_DropTarget::OnEnter( x, y, def )
    wxCoord x
    wxCoord y
    wxDragResult def
  CODE:
    RETVAL = THIS->wxDropTarget::OnEnter( x, y, def );
  OUTPUT:
    RETVAL

wxDragResult
Wx_DropTarget::OnDragOver( x, y, def )
    wxCoord x
    wxCoord y
    wxDragResult def
  CODE:
    RETVAL = THIS->wxDropTarget::OnDragOver( x, y, def );
  OUTPUT:
    RETVAL

bool
Wx_DropTarget::OnDrop( x, y )
    wxCoord x
    wxCoord y
  CODE:
    RETVAL = THIS->wxDropTarget::OnDrop( x, y );
  OUTPUT:
    RETVAL

void
Wx_DropTarget::OnLeave()
  CODE:
    THIS->wxDropTarget::OnLeave();

MODULE=Wx PACKAGE=Wx::TextDropTarget

SV*
Wx_TextDropTarget::new()
  CODE:
    wxPliTextDropTarget* retval = new wxPliTextDropTarget( CLASS );
    RETVAL = retval->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::FileDropTarget

SV*
Wx_FileDropTarget::new()
  CODE:
    wxPliFileDropTarget* retval = new wxPliFileDropTarget( CLASS );
    RETVAL = retval->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL
