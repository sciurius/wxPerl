#############################################################################
## Name:        XS/Icon.xs
## Purpose:     XS for Wx::Icon
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Icon.xs,v 1.23 2004/07/10 21:49:46 mbarbon Exp $
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/icon.h>

MODULE=Wx PACKAGE=Wx

#if !defined( __WXMSW__ )
#include "wxpl.xpm"
#endif

wxIcon*
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
wxIcon::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newNull )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_s_n_n_n, newFile, 2 )
    END_OVERLOAD( Wx::Icon::new )

wxIcon*
newNull( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxIcon();
  OUTPUT:
    RETVAL

wxIcon*
newFile( CLASS, name, type, desW = -1, desH = -1 )
    SV* CLASS
    wxString name
    long type
    int desW
    int desH
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 ) && \
    ( defined( __WXMOTIF__ ) || defined( __WXX11__ ) )
    RETVAL = new wxIcon( name, wxBitmapType(type), desW, desH );
#else
    RETVAL = new wxIcon( name, type, desW, desH );
#endif
  OUTPUT:
    RETVAL

#if defined( __WXGTK__ ) || defined( __WXPERL_FORCE__ )

##wxIcon*
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

wxIcon*
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
wxIcon::DESTROY()

bool
wxIcon::LoadFile( name, type )
    wxString name
    long type
  CODE:
#if defined( __WXMOTIF__ )
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
        RETVAL = THIS->LoadFile( name, wxBitmapType(type), -1, -1 );
#else
        RETVAL = THIS->LoadFile( name, type, -1, -1 );
#endif
#else
#if ( defined( __WXX11__ ) || defined( __WXMAC__ ) ) \
    && WXPERL_W_VERSION_GE( 2, 5, 1 )
    RETVAL = THIS->LoadFile( name, wxBitmapType(type) );
#else
    RETVAL = THIS->LoadFile( name, type );
#endif
#endif
  OUTPUT:
    RETVAL

bool
wxIcon::Ok()

void
wxIcon::CopyFromBitmap( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
wxIcon::GetDepth()

int
wxIcon::GetHeight()

int
wxIcon::GetWidth()

void
wxIcon::SetDepth( depth )
    int depth

void
wxIcon::SetHeight( height )
    int height

void
wxIcon::SetWidth( width )
    int width

#endif
