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

void
Wx_Mask::Destroy()
  CODE:
    delete THIS;

MODULE=Wx PACKAGE=Wx::Bitmap

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

#ifdef __WXMSW__

void
AddHandler( handler )
    Wx_BitmapHandler* handler
  CODE:
    wxBitmap::AddHandler( handler );

void
CleanUpHandlers()
  CODE:
    wxBitmap::CleanUpHandlers();

#endif

#if 0

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

#ifdef __WXMSW__

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

#ifdef __WXMSW__

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

#ifdef __WXMSW__

bool
RemoveHandler( name )
    wxString name
  CODE:
    wxBitmap::RemoveHandler( name );

#endif

bool
Wx_Bitmap::SaveFile( name, type, palette = NULL )
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

#ifdef __WXMSW__

void
Wx_Bitmap::SetPalette( palette )
    Wx_Palette* palette
  CODE:
    THIS->SetPalette( *palette );

#endif

void
Wx_Bitmap::SetWidth( width )
    int width
