#############################################################################
## Name:        Bitmap.xs
## Purpose:     XS for Wx::Bitmap and Wx::Mask
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/bitmap.h>

MODULE=Wx PACKAGE=Wx::Mask

void
Wx_Mask::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wbmp_wcol, newBitmapColour )
        MATCH_REDISP( wxPliOvl_wbmp_n, newBitmapIndex )
        MATCH_REDISP( wxPliOvl_wbmp, newBitmap )
    END_OVERLOAD( Wx::Mask::new )

Wx_Mask*
newBitmap( CLASS, bitmap )
    SV* CLASS
    Wx_Bitmap* bitmap
  CODE:
    RETVAL = new wxMask( *bitmap );
  OUTPUT:
    RETVAL

Wx_Mask*
newBitmapColour( CLASS, bitmap, colour )
    SV* CLASS
    Wx_Bitmap* bitmap
    Wx_Colour* colour
  CODE:
    RETVAL = new wxMask( *bitmap, *colour );
  OUTPUT:
    RETVAL

Wx_Mask*
newBitmapIndex( CLASS, bitmap, index )
    SV* CLASS
    Wx_Bitmap* bitmap
    int index
  CODE:
    RETVAL = new wxMask( *bitmap, index );
  OUTPUT:
    RETVAL

void
Wx_Mask::Destroy()
  CODE:
    delete THIS;

MODULE=Wx PACKAGE=Wx::Bitmap

#if 0

int
bmp_spaceship( bmp1, bmp2, ... )
    SV* bmp1
    SV* bmp2
  CODE:
    // this is not a proper spaceship method
    // it just allows autogeneration of != and ==
    // anyway, comparing bitmaps is just useless
    RETVAL = -1;
    if( SvROK( bmp1 ) && SvROK( bmp2 ) &&
        sv_derived_from( bmp1, "Wx::Bitmap" ) &&
        sv_derived_from( bmp2, "Wx::Bitmap" ) )
    {
        Wx_Bitmap* bitmap1 = (Wx_Bitmap*)_sv_2_object( bmp1, "Wx::Bitmap" );
        Wx_Bitmap* bitmap2 = (Wx_Bitmap*)_sv_2_object( bmp2, "Wx::Bitmap" );

        RETVAL = *bitmap1 == *bitmap2 ? 0 : 1;
    } else
      RETVAL = 1;
  OUTPUT:
    RETVAL

#endif

void
Wx_Bitmap::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n, newEmpty, 2 )
        MATCH_REDISP( wxPliOvl_s_n, newFile )
        MATCH_REDISP( wxPliOvl_wico, newIcon )
        MATCH_REDISP( wxPliOvl_wimg, newImage )
    END_OVERLOAD( Wx::Bitmap::new )

Wx_Bitmap*
newEmpty( CLASS, width, height, depth = -1 )
    SV* CLASS
    int width
    int height
    int depth
  CODE:
    RETVAL = new wxBitmap( width, height, depth );
  OUTPUT:
    RETVAL

Wx_Bitmap*
newFile( CLASS, name, type )
    SV* CLASS
    wxString name
    long type
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 0 )
    RETVAL = new wxBitmap( name, wxBitmapType(type) );
#else
    RETVAL = new wxBitmap( name, type );
#endif
  OUTPUT:
    RETVAL

Wx_Bitmap*
newIcon( CLASS, icon )
    SV* CLASS
    Wx_Icon* icon
  CODE:
    RETVAL = new wxBitmap( *icon );
  OUTPUT:
    RETVAL

Wx_Bitmap*
newFromBits( CLASS, bits, width, height, depth = 1 )
    SV* CLASS
    SV* bits
    int width
    int height
    int depth
  PREINIT:
    char* buffer = SvPV_nolen( bits );
  CODE:
    RETVAL = new wxBitmap( buffer, width, height, depth );
  OUTPUT:
    RETVAL

Wx_Bitmap*
newFromXPM( CLASS, data )
    SV* CLASS
    SV* data
  PREINIT:
    char** xpm_data;
    size_t i, n = wxPli_av_2_charparray( aTHX_ data, &xpm_data );
  CODE:
    RETVAL = new wxBitmap( xpm_data );
    for( i = 0; i < n; ++i )
        free( xpm_data[i] );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_Bitmap*
newImage( CLASS, image )
    SV* CLASS
    Wx_Image* image
  CODE:
    RETVAL = new wxBitmap( *image );
  OUTPUT:
    RETVAL

#else

wxBitmap*
newImage( CLASS, image )
    SV* CLASS
    wxImage* image
  CODE:
    RETVAL = new wxBitmap( image->ConvertToBitmap() );
  OUTPUT: RETVAL

#endif

## XXX threads
void
Wx_Bitmap::DESTROY()

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_Image*
Wx_Bitmap::ConvertToImage()
  CODE:
    RETVAL = new wxImage( THIS->ConvertToImage() );
  OUTPUT:
    RETVAL

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

void
Wx_Bitmap::CopyFromIcon( icon )
    Wx_Icon* icon
  CODE:
    THIS->CopyFromIcon( *icon );

#endif

#if defined( __WXMOTIF__ ) || \
    defined( __WXMSW__ ) || \
    defined( __WXPERL_FORCE__ )

void
AddHandler( handler )
    Wx_BitmapHandler* handler
  CODE:
    wxBitmap::AddHandler( handler );

# void
# CleanUpHandlers()
#   CODE:
#     wxBitmap::CleanUpHandlers();

#endif

#if defined( __WXMOTIF__ ) || defined( __WXPERL_FORCE__ )

Wx_BitmapHandler*
FindHandlerName( name )
    wxString name
  CODE:
    RETVAL = wxBitmap::FindHandler( name );
  OUTPUT:
    RETVAL

Wx_BitmapHandler*
FindHandlerExtType( extension, type )
    wxString extension
    long type
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 0 ) && defined(__WXMOTIF__)
    RETVAL = wxBitmap::FindHandler( extension, wxBitmapType(type) );
#else
    RETVAL = wxBitmap::FindHandler( extension, type );
#endif
  OUTPUT:
    RETVAL

Wx_BitmapHandler*
FindHandlerType( type )
    long type
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 0 ) && defined(__WXMOTIF__)
    RETVAL = wxBitmap::FindHandler( wxBitmapType(type) );
#else
    RETVAL = wxBitmap::FindHandler( type );
#endif
  OUTPUT:
    RETVAL

#endif

int
Wx_Bitmap::GetDepth()

#if defined( __WXMOTIF__ ) || defined( __WXMSW__ ) \
    || defined( __WXPERL_FORCE__ )

void
GetHandlers()
  PPCODE:
    const wxList& list = wxBitmap::GetHandlers();
    wxNode* node;
    
    EXTEND( SP, list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );

#endif

int
Wx_Bitmap::GetHeight()

Wx_Palette*
Wx_Bitmap::GetPalette()
  CODE:
    RETVAL = new wxPalette( *THIS->GetPalette() );
  OUTPUT:
    RETVAL

Wx_Mask*
Wx_Bitmap::GetMask()

int
Wx_Bitmap::GetWidth()

Wx_Bitmap*
Wx_Bitmap::GetSubBitmap( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = new wxBitmap( THIS->GetSubBitmap( *rect ) );
  OUTPUT:
    RETVAL

#if defined( __WXMOTIF__ ) || defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
InitStandardHandlers()
  CODE:
    wxBitmap::InitStandardHandlers();

void
InsertHandler( handler )
    Wx_BitmapHandler* handler
  CODE:
    wxBitmap::InsertHandler( handler );

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

bool
Wx_Bitmap::LoadFile( name, type )
    wxString name
    wxBitmapType type

#else

bool
Wx_Bitmap::LoadFile( name, type )
    wxString name
    long type

#endif

bool
Wx_Bitmap::Ok()

#if defined( __WXMOTIF__ ) || defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

bool
RemoveHandler( name )
    wxString name
  CODE:
    RETVAL = wxBitmap::RemoveHandler( name );
  OUTPUT: RETVAL

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

bool
Wx_Bitmap::SaveFile( name, type, palette = 0 )
    wxString name
    wxBitmapType type
    Wx_Palette* palette

#else

bool
Wx_Bitmap::SaveFile( name, type, palette = 0 )
    wxString name
    long type
    Wx_Palette* palette

#endif

void
Wx_Bitmap::SetDepth( depth )
    int depth

void
Wx_Bitmap::SetHeight( height )
    int height

#if !defined(__WXMAC__)

void
Wx_Bitmap::SetMask( mask )
    Wx_Mask* mask
  CODE:
    THIS->SetMask( new wxMask( *mask ) );

#endif

#if defined( __WXMOTIF__ ) || defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Bitmap::SetPalette( palette )
    Wx_Palette* palette
  CODE:
    THIS->SetPalette( *palette );

#endif

void
Wx_Bitmap::SetWidth( width )
    int width
