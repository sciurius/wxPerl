#############################################################################
## Name:        XS/StaticBitmap.xs
## Purpose:     XS for Wx::StaticBitmap
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id: StaticBitmap.xs,v 1.9 2004/10/19 20:28:05 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include "cpp/overload.h"
#include <wx/statbmp.h>

MODULE=Wx PACKAGE=Wx::StaticBitmap

void
wxStaticBitmap::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_n_wico, newIcon )
        MATCH_REDISP( wxPliOvl_wwin_n_wbmp, newBitmap )
    END_OVERLOAD( Wx::StaticBitmap::new )

wxStaticBitmap*
newBitmap( cls, parent, id, bitmap, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBitmapNameStr )
    SV* cls
    wxWindow* parent
    wxWindowID id
    wxBitmap* bitmap
    wxPoint pos
    wxSize size
    long style
    wxString name
  PREINIT:
    const char* CLASS = wxPli_get_class( aTHX_ cls );
  CODE:
    RETVAL = new wxStaticBitmap( parent, id, *bitmap, pos, size,
         style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

#if !defined(__WXUNIVERSAL__) || defined(__WXPERL_FORCE__)

wxStaticBitmap*
newIcon( cls, parent, id, icon, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxStaticBitmapNameStr )
    SV* cls
    wxWindow* parent
    wxWindowID id
    wxIcon* icon
    wxPoint pos
    wxSize size
    long style
    wxString name
  PREINIT:
    const char* CLASS = wxPli_get_class( aTHX_ cls );
  CODE:
    RETVAL = new wxStaticBitmap( parent, id, *icon, pos, size,
         style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

#endif

wxBitmap*
wxStaticBitmap::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

void
wxStaticBitmap::SetBitmap( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

#if !defined(__WXUNIVERSAL__) || defined(__WXPERL_FORCE__)

wxIcon*
wxStaticBitmap::GetIcon()
  CODE:
    RETVAL = new wxIcon( THIS->GetIcon() );
  OUTPUT:
    RETVAL

void
wxStaticBitmap::SetIcon( icon )
    wxIcon* icon
  C_ARGS: *icon

#endif
