#############################################################################
## Name:        ext/dnd/XS/DropTarget.xs
## Purpose:     XS for Wx::*DropTarget
## Author:      Mattia Barbon
## Modified by:
## Created:     16/08/2001
## RCS-ID:      $Id: DropTarget.xs,v 1.6 2004/03/02 21:12:35 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dnd.h>
#include "cpp/droptarget.h"

MODULE=Wx PACKAGE=Wx::DropTarget

SV*
wxDropTarget::new( data = 0 )
    wxDataObject* data
  CODE:
    wxPliDropTarget* retval = new wxPliDropTarget( CLASS, data );
    RETVAL = retval->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL

## XXX threads
void
DESTROY( THIS )
    wxDropTarget* THIS
  CODE:
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;
  
void
wxDropTarget::GetData()

void
wxDropTarget::SetDataObject( data )
    wxDataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), FALSE );
    THIS->SetDataObject( data );

# callbacks

# wxDragResult
# wxDropTarget::OnData( x, y, def )
#     wxCoord x
#     wxCoord y
#     wxDragResult def
#   CODE:
#     RETVAL = THIS->wxDropTarget::OnData( x, y, def );
#   OUTPUT:
#     RETVAL

wxDragResult
wxDropTarget::OnEnter( x, y, def )
    wxCoord x
    wxCoord y
    wxDragResult def
  CODE:
    RETVAL = THIS->wxDropTarget::OnEnter( x, y, def );
  OUTPUT:
    RETVAL

wxDragResult
wxDropTarget::OnDragOver( x, y, def )
    wxCoord x
    wxCoord y
    wxDragResult def
  CODE:
    RETVAL = THIS->wxDropTarget::OnDragOver( x, y, def );
  OUTPUT:
    RETVAL

bool
wxDropTarget::OnDrop( x, y )
    wxCoord x
    wxCoord y
  CODE:
    RETVAL = THIS->wxDropTarget::OnDrop( x, y );
  OUTPUT:
    RETVAL

void
wxDropTarget::OnLeave()
  CODE:
    THIS->wxDropTarget::OnLeave();

MODULE=Wx PACKAGE=Wx::TextDropTarget

SV*
wxTextDropTarget::new()
  CODE:
    wxPliTextDropTarget* retval = new wxPliTextDropTarget( CLASS );
    RETVAL = retval->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::FileDropTarget

SV*
wxFileDropTarget::new()
  CODE:
    wxPliFileDropTarget* retval = new wxPliFileDropTarget( CLASS );
    RETVAL = retval->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL
