#############################################################################
## Name:        Bitmap.xs
## Purpose:     XS for Wx::Bitmap and Wx::Mask
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Mask

Wx_Mask*
newBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    RETVAL = new wxMask( *bitmap );
  OUTPUT:
    RETVAL

Wx_Mask*
newBitmapColour( bitmap, colour )
    Wx_Bitmap* bitmap
    Wx_Colour* colour
  CODE:
    RETVAL = new wxMask( *bitmap, *colour );
  OUTPUT:
    RETVAL

Wx_Mask*
newBitmapIndex( bitmap, index )
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
        sv_derived_from( bmp1, wxPlBitmapName ) &&
        sv_derived_from( bmp2, wxPlBitmapName ) )
    {
        Wx_Bitmap* bitmap1 = (Wx_Bitmap*)_sv_2_object( bmp1, wxPlBitmapName );
        Wx_Bitmap* bitmap2 = (Wx_Bitmap*)_sv_2_object( bmp2, wxPlBitmapName );

        RETVAL = *bitmap1 == *bitmap2 ? 0 : 1;
    } else
      RETVAL = 1;
  OUTPUT:
    RETVAL

#endif

Wx_Bitmap*
newEmpty( width, height, depth = -1 )
    int width
    int height
    int depth
  CODE:
    RETVAL = new wxBitmap( width, height, depth );
  OUTPUT:
    RETVAL

Wx_Bitmap*
newFile( name, type )
    wxString name
    long type
  CODE:
    RETVAL = new wxBitmap( name, type );
  OUTPUT:
    RETVAL

Wx_Bitmap*
newIcon( icon )
    Wx_Icon* icon
  CODE:
    RETVAL = new wxBitmap( *icon );
  OUTPUT:
    RETVAL

void
Wx_Bitmap::DESTROY()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

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

#if defined( __WXPERL_FORCE__ )

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
    RETVAL = wxBitmap::FindHandler( extension, type );
  OUTPUT:
    RETVAL

Wx_BitmapHandler*
FindHandlerType( type )
    long type
  CODE:
    RETVAL = wxBitmap::FindHandler( type );
  OUTPUT:
    RETVAL

#endif

int
Wx_Bitmap::GetDepth()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
GetHandlers()
  PPCODE:
    const wxList& list = wxBitmap::GetHandlers();
    wxNode* node;
    
    EXTEND( SP, list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( _object_2_sv( sv_newmortal(), node->GetData() ) );

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

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

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

bool
Wx_Bitmap::LoadFile( name, type )
    wxString name
    long type

bool
Wx_Bitmap::Ok()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

bool
RemoveHandler( name )
    wxString name
  CODE:
    wxBitmap::RemoveHandler( name );

#endif

bool
Wx_Bitmap::SaveFile( name, type, palette = 0 )
    wxString name
    long type
    Wx_Palette* palette

void
Wx_Bitmap::SetDepth( depth )
    int depth

void
Wx_Bitmap::SetHeight( height )
    int height
    
void
Wx_Bitmap::SetMask( mask )
    Wx_Mask* mask
  CODE:
    THIS->SetMask( new wxMask( *mask ) );

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Bitmap::SetPalette( palette )
    Wx_Palette* palette
  CODE:
    THIS->SetPalette( *palette );

#endif

void
Wx_Bitmap::SetWidth( width )
    int width
