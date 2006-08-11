#############################################################################
## Name:        XS/Cursor.xs
## Purpose:     XS for Wx::Cursor
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Cursor.xs,v 1.14 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/cursor.h>

MODULE=Wx PACKAGE=Wx::Cursor

void
wxCursor::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n, newId )
        MATCH_REDISP( wxPliOvl_wimg, newImage )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_s_n_n_n, newFile, 2 )
    END_OVERLOAD( Wx::Cursor::new )
        
#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxCursor*
newFile( CLASS, name, type, hsx = -1, hsy = -1 )
    SV* CLASS
    wxString name
    long type
    int hsx
    int hsy
  CODE:
    RETVAL = new wxCursor( name, type, hsx, hsy );
  OUTPUT:
    RETVAL

#endif

wxCursor*
newId( CLASS, id )
    SV* CLASS
    wxStockCursor id
  CODE:
    RETVAL = new wxCursor( id );
  OUTPUT:
    RETVAL

#if !defined(__WXMAC__)

wxCursor*
newImage( CLASS, img )
    SV* CLASS
    wxImage* img
  CODE:
    RETVAL = new wxCursor( *img );
  OUTPUT:
    RETVAL

#endif

#if !defined( __WXGTK__ )

wxCursor*
newData( CLASS, bits, width, height, hotSpotX = -1, hotSpotY = -1, maskBits = 0 )
    SV* CLASS
    SV* bits
    int width
    int height
    int hotSpotX
    int hotSpotY
    SV* maskBits
  PREINIT:
    char* data = SvPV_nolen( bits );
    char* mask = maskBits ? SvPV_nolen( maskBits ) : 0;
  CODE:
    RETVAL = new wxCursor( data, width, height, hotSpotX, hotSpotY, mask );
  OUTPUT:
    RETVAL

#endif

static void
wxCursor::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxCursor::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Cursor", THIS, ST(0) );
    delete THIS;

bool
wxCursor::Ok()
