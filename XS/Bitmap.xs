#############################################################################
## Name:        XS/Bitmap.xs
## Purpose:     XS for Wx::Bitmap and Wx::Mask
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Bitmap.xs,v 1.28 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2002, 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/bitmap.h>

MODULE=Wx PACKAGE=Wx::Mask

void
wxMask::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wbmp_wcol, newBitmapColour )
        MATCH_REDISP( wxPliOvl_wbmp_n, newBitmapIndex )
        MATCH_REDISP( wxPliOvl_wbmp, newBitmap )
    END_OVERLOAD( Wx::Mask::new )

wxMask*
newBitmap( CLASS, bitmap )
    SV* CLASS
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxMask( *bitmap );
  OUTPUT:
    RETVAL

wxMask*
newBitmapColour( CLASS, bitmap, colour )
    SV* CLASS
    wxBitmap* bitmap
    wxColour* colour
  CODE:
    RETVAL = new wxMask( *bitmap, *colour );
  OUTPUT:
    RETVAL

wxMask*
newBitmapIndex( CLASS, bitmap, index )
    SV* CLASS
    wxBitmap* bitmap
    int index
  CODE:
    RETVAL = new wxMask( *bitmap, index );
  OUTPUT:
    RETVAL

void
wxMask::Destroy()
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
        wxBitmap* bitmap1 = (wxBitmap*)_sv_2_object( bmp1, "Wx::Bitmap" );
        wxBitmap* bitmap2 = (wxBitmap*)_sv_2_object( bmp2, "Wx::Bitmap" );

        RETVAL = *bitmap1 == *bitmap2 ? 0 : 1;
    } else
      RETVAL = 1;
  OUTPUT:
    RETVAL

#endif

void
wxBitmap::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n, newEmpty, 2 )
        MATCH_REDISP( wxPliOvl_s_n, newFile )
        MATCH_REDISP( wxPliOvl_wico, newIcon )
        MATCH_REDISP( wxPliOvl_wimg, newImage )
    END_OVERLOAD( Wx::Bitmap::new )

wxBitmap*
newEmpty( CLASS, width, height, depth = -1 )
    SV* CLASS
    int width
    int height
    int depth
  CODE:
    RETVAL = new wxBitmap( width, height, depth );
  OUTPUT:
    RETVAL

wxBitmap*
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

wxBitmap*
newIcon( CLASS, icon )
    SV* CLASS
    wxIcon* icon
  CODE:
    RETVAL = new wxBitmap( *icon );
  OUTPUT:
    RETVAL

wxBitmap*
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

wxBitmap*
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

wxBitmap*
newImage( CLASS, image )
    SV* CLASS
    wxImage* image
  CODE:
    RETVAL = new wxBitmap( *image );
  OUTPUT:
    RETVAL

static void
wxBitmap::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxBitmap::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Bitmap", THIS, ST(0) );
    delete THIS;

wxImage*
wxBitmap::ConvertToImage()
  CODE:
    RETVAL = new wxImage( THIS->ConvertToImage() );
  OUTPUT:
    RETVAL

void
wxBitmap::CopyFromIcon( icon )
    wxIcon* icon
  CODE:
    THIS->CopyFromIcon( *icon );

#if defined( __WXMOTIF__ ) || \
    defined( __WXMSW__ ) || \
    defined( __WXPERL_FORCE__ )

void
AddHandler( handler )
    wxBitmapHandler* handler
  CODE:
    wxBitmap::AddHandler( handler );

# void
# CleanUpHandlers()
#   CODE:
#     wxBitmap::CleanUpHandlers();

#endif

#if defined( __WXMOTIF__ ) || defined( __WXPERL_FORCE__ )

wxBitmapHandler*
FindHandlerName( name )
    wxString name
  CODE:
    RETVAL = wxBitmap::FindHandler( name );
  OUTPUT:
    RETVAL

wxBitmapHandler*
FindHandlerExtType( extension, type )
    wxString extension
    long type
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 ) && defined(__WXMOTIF__)
    RETVAL = wxBitmap::FindHandler( extension, wxBitmapType(type) );
#else
    RETVAL = wxBitmap::FindHandler( extension, type );
#endif
  OUTPUT:
    RETVAL

wxBitmapHandler*
FindHandlerType( type )
    long type
  CODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 ) && defined(__WXMOTIF__)
    RETVAL = wxBitmap::FindHandler( wxBitmapType(type) );
#else
    RETVAL = wxBitmap::FindHandler( type );
#endif
  OUTPUT:
    RETVAL

#endif

int
wxBitmap::GetDepth()

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
wxBitmap::GetHeight()

wxPalette*
wxBitmap::GetPalette()
  CODE:
    RETVAL = new wxPalette( *THIS->GetPalette() );
  OUTPUT:
    RETVAL

wxMask*
wxBitmap::GetMask()

int
wxBitmap::GetWidth()

wxBitmap*
wxBitmap::GetSubBitmap( rect )
    wxRect* rect
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
    wxBitmapHandler* handler
  CODE:
    wxBitmap::InsertHandler( handler );

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

bool
wxBitmap::LoadFile( name, type )
    wxString name
    wxBitmapType type

#else

bool
wxBitmap::LoadFile( name, type )
    wxString name
    long type

#endif

bool
wxBitmap::Ok()

#if defined( __WXMOTIF__ ) || defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

bool
RemoveHandler( name )
    wxString name
  CODE:
    RETVAL = wxBitmap::RemoveHandler( name );
  OUTPUT: RETVAL

#endif

bool
wxBitmap::SaveFile( name, type, palette = 0 )
    wxString name
    wxBitmapType type
    wxPalette* palette

void
wxBitmap::SetDepth( depth )
    int depth

void
wxBitmap::SetHeight( height )
    int height

void
wxBitmap::SetMask( mask )
    wxMask* mask
  CODE:
    THIS->SetMask( mask );

#if defined( __WXMOTIF__ ) || defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxBitmap::SetPalette( palette )
    wxPalette* palette
  CODE:
    THIS->SetPalette( *palette );

#endif

void
wxBitmap::SetWidth( width )
    int width
