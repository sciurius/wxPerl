#############################################################################
## Name:        Icon.xs
## Purpose:     XS for Wx::Icon
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Icon.xs,v 1.19 2003/05/05 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/icon.h>

MODULE=Wx PACKAGE=Wx

#if !defined( __WXMSW__ )
#include "wxpl.xpm"
#endif

Wx_Icon*
GetWxPerlIcon( small = FALSE )
    bool small
  CODE:
#if defined( __WXMSW__ )
    int sz = small ? 16 : 32;
    RETVAL = new wxIcon( wxT("wxplicon"), wxBITMAP_TYPE_ICO_RESOURCE, -1, -1 );
    if( !RETVAL->Ok() )
        croak( "Unable to load icon" );
#else
    char** image = small ? wxpl16_xpm : wxpl32_xpm;
    RETVAL = new wxIcon( image );
#endif
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::Icon

void
Wx_Icon::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newNull )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_s_n_n_n, newFile, 2 )
    END_OVERLOAD( Wx::Icon::new )

Wx_Icon*
newNull( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxIcon();
  OUTPUT:
    RETVAL

Wx_Icon*
newFile( CLASS, name, type, desW = -1, desH = -1 )
    SV* CLASS
    wxString name
    long type
    int desW
    int desH
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 0 ) && defined(__WXMOTIF__)
    RETVAL = new wxIcon( name, wxBitmapType(type), desW, desH );
#else
    RETVAL = new wxIcon( name, type, desW, desH );
#endif
  OUTPUT:
    RETVAL

#if defined( __WXGTK__ ) || defined( __WXPERL_FORCE__ )

##Wx_Icon*
##newFromBits( bits, width, height, depth = 1 )
##    SV* bits
##    int width
##    int height
##    int depth
##  PREINIT:
##    void* buffer = SvPV_nolen( bits );
##  CODE:
##    RETVAL = new wxIcon( buffer, width, height, depth );
##  OUTPUT:
##    RETVAL

#endif

Wx_Icon*
newFromXPM( CLASS, data )
    SV* CLASS
    SV* data
  PREINIT:
    char** xpm_data;
    size_t i, n = wxPli_av_2_charparray( aTHX_ data, &xpm_data );
  CODE:
    RETVAL = new wxIcon( xpm_data );
    for( i = 0; i < n; ++i )
        free( xpm_data[i] );
  OUTPUT:
    RETVAL

## XXX threads
void
Wx_Icon::DESTROY()

bool
Wx_Icon::LoadFile( name, type )
    wxString name
    long type
  CODE:
#ifdef __WXMOTIF__
#if WXPERL_W_VERSION_GE( 2, 5, 0 )
        RETVAL = THIS->LoadFile( name, wxBitmapType(type), -1, -1 );
#else
        RETVAL = THIS->LoadFile( name, type, -1, -1 );
#endif
#else
    RETVAL = THIS->LoadFile( name, type );
#endif
  OUTPUT:
    RETVAL

bool
Wx_Icon::Ok()

#if defined( __WXMSW__ ) || \
    ( defined( __WXGTK__ ) ) || \
    ( defined( __WXMOTIF__ ) ) || \
    defined( __WXPERL_FORCE__ )

void
Wx_Icon::CopyFromBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->CopyFromBitmap( *bitmap );

#endif

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_Icon::GetDepth()

int
Wx_Icon::GetHeight()

int
Wx_Icon::GetWidth()

void
Wx_Icon::SetDepth( depth )
    int depth

void
Wx_Icon::SetHeight( height )
    int height

void
Wx_Icon::SetWidth( width )
    int width

#endif
