#############################################################################
## Name:        Icon.xs
## Purpose:     XS for Wx::Icon
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
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
    RETVAL = new wxIcon( "wxplicon", wxBITMAP_TYPE_ICO_RESOURCE, -1, -1 );
    if( !RETVAL->Ok() )
        croak( "Unable to load icon" );
#else
    char** image = small ? wxpl16_xpm : wxpl32_xpm;
    RETVAL = new wxIcon( image );
#endif
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::Icon

Wx_Icon*
newNull()
  CODE:
    RETVAL = new wxIcon();
  OUTPUT:
    RETVAL

#if ( !defined( __WXMOTIF__ ) && !defined( __WXMSW__ ) && !defined( __WXGTK__ ) ) || defined( __WXPERL_FORCE__ )

Wx_Icon*
newEmpty( width, height, depth = -1 )
    int width
    int height
    int depth
  CODE:
    RETVAL = new wxIcon( width, height, depth );
  OUTPUT:
    RETVAL

#endif

Wx_Icon*
newFile( name, type, desW = -1, desH = -1 )
    wxString name
    long type
    int desW
    int desH
  CODE:
    RETVAL = new wxIcon( name, type, desW, desH );
  OUTPUT:
    RETVAL

void
Wx_Icon::DESTROY()

bool
Wx_Icon::LoadFile( name, type )
    wxString name
    long type
  CODE:
#ifdef __WXMOTIF__
    RETVAL = THIS->LoadFile( name, type, -1, -1 );
#else
    RETVAL = THIS->LoadFile( name, type );
#endif

bool
Wx_Icon::Ok()

void
Wx_Icon::CopyFromBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->CopyFromBitmap( *bitmap );

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
