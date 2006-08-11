#############################################################################
## Name:        ext/dnd/XS/DropTarget.xs
## Purpose:     XS for Wx::*DropTarget
## Author:      Mattia Barbon
## Modified by:
## Created:     16/08/2001
## RCS-ID:      $Id: DropTarget.xs,v 1.10 2006/08/11 19:54:58 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004, 2006 Mattia Barbon
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
    RETVAL = newRV_noinc( SvRV( retval->m_callback.GetSelf() ) );
    wxPli_thread_sv_register( aTHX_ "Wx::DropTarget", retval, RETVAL );
  OUTPUT:
    RETVAL

static void
wxDropTarget::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
DESTROY( THIS )
    wxDropTarget* THIS
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::DropTarget", THIS, ST(0) );
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;
  
void
wxDropTarget::GetData()

void
wxDropTarget::SetDataObject( data )
    wxDataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    SvREFCNT_inc( SvRV( ST(1) ) ); // at this point the scalar must not go away
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
