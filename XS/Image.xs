#############################################################################
## Name:        Image.xs
## Purpose:     XS for Wx::Image
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/image.h>
#include "cpp/streams.h"

MODULE=Wx PACKAGE=Wx::Image

Wx_Image*
newNull()
  CODE:
    RETVAL = new wxImage();
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_LE( 2, 3, 2 ) || WXWIN_COMPATIBILITY_2_2

Wx_Image*
newBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    RETVAL = new wxImage( *bitmap );
  OUTPUT:
    RETVAL

Wx_Image*
newIcon( icon )
    Wx_Icon* icon
  CODE:
#if defined( __WXMSW__ )
    RETVAL = new wxImage( wxBitmap( *icon ) );
#else
    //FIXME// it compiles: does it work, too?
    RETVAL = new wxImage( (wxBitmap&) *icon );
#endif
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_Image::ConvertToBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->ConvertToBitmap() );
  OUTPUT:
    RETVAL

#endif

Wx_Image*
newWH( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( width, height );
  OUTPUT:
    RETVAL

Wx_Image*
newData( width, height, dt )
    int width
    int height
    SV* dt
  PREINIT:
    STRLEN len;
    unsigned char* data = (unsigned char*)SvPV( dt, len );
    unsigned char* newdata;
  CODE:
    if( len != (STRLEN) width * height * 3 )
    {
        croak( "too few data" );
    }
    newdata = (unsigned char*)malloc( width * height * 3 );
    memcpy( newdata, data, width * height * 3 );

    RETVAL = new wxImage( width, height, newdata );
  OUTPUT:
    RETVAL

Wx_Image*
newNameType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = new wxImage( name, type );
  OUTPUT:
    RETVAL

Wx_Image*
newNameMIME( name, mimetype )
    wxString name
    wxString mimetype
  CODE:
    RETVAL = new wxImage( name, mimetype );
  OUTPUT:
    RETVAL

Wx_Image*
newStreamType( stream, type )
    wxPliInputStream stream
    long type
  CODE:
    RETVAL = new wxImage( stream, type );
  OUTPUT:
    RETVAL

Wx_Image*
newStreamMIME( stream, mime )
    wxPliInputStream stream
    wxString mime
  CODE:
    RETVAL = new wxImage( stream, mime );
  OUTPUT:
    RETVAL

## XXX threads
void
Wx_Image::DESTROY()

void
AddHandler( handler )
    Wx_ImageHandler* handler
  CODE:
    wxImage::AddHandler( handler );

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_Image*
Wx_Image::ConvertToMono( r, g, b )
    unsigned char r
    unsigned char g
    unsigned char b
  CODE:
    RETVAL = new wxImage( THIS->ConvertToMono( r, g, b ) );
  OUTPUT:
    RETVAL

#endif

Wx_Image*
Wx_Image::Copy()
  CODE:
    RETVAL = new wxImage( THIS->Copy() );
  OUTPUT:
    RETVAL

void
Wx_Image::Create( width, height )
    int width
    int height

void
Wx_Image::Destroy()

Wx_ImageHandler*
FindHandlerName( name )
    wxString name
  CODE:
    RETVAL = wxImage::FindHandler( name );
  OUTPUT:
    RETVAL

Wx_ImageHandler*
FindHandlerExtType( extension, type )
    wxString extension
    long type
  CODE:
    RETVAL = wxImage::FindHandler( extension, type );
  OUTPUT:
    RETVAL

Wx_ImageHandler*
FindHandlerType( type )
    long type
  CODE:
    RETVAL = wxImage::FindHandler( type );
  OUTPUT:
    RETVAL

Wx_ImageHandler*
FindHandlerMime( mime )
   wxString mime
  CODE:
    RETVAL = wxImage::FindHandlerMime( mime );
  OUTPUT:
    RETVAL

SV*
Wx_Image::GetData()
  CODE:
    STRLEN len = THIS->GetWidth() * THIS->GetHeight() * 3;
    RETVAL = newSVpvn( (char*)THIS->GetData(), len );
  OUTPUT:
    RETVAL

unsigned char
Wx_Image::GetBlue( x, y )
    int x
    int y

unsigned char
Wx_Image::GetGreen( x, y )
    int x
    int y

unsigned char
Wx_Image::GetRed( x, y )
    int x
    int y

int
Wx_Image::GetHeight()

unsigned char
Wx_Image::GetMaskBlue()

unsigned char
Wx_Image::GetMaskGreen()

unsigned char
Wx_Image::GetMaskRed()

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

wxString
Wx_Image::GetOption( name )
    wxString name

int
Wx_Image::GetOptionInt( name )
    wxString name

Wx_Palette*
Wx_Image::GetPalette()
  CODE:
    RETVAL = new wxPalette( THIS->GetPalette() );
  OUTPUT:
    RETVAL

#endif

Wx_Image*
Wx_Image::GetSubImage( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = new wxImage( THIS->GetSubImage( *rect ) );
  OUTPUT:
    RETVAL

int
Wx_Image::GetWidth()

bool
Wx_Image::HasMask()

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

bool
Wx_Image::HasOption( name )
    wxString name

bool
Wx_Image::HasPalette()

#endif

void
InsertHandler( handler )
    Wx_ImageHandler* handler
  CODE:
    wxImage::InsertHandler( handler );

bool
Wx_Image::LoadFileType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = THIS->LoadFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadFileMIME( name, type )
    wxString name
    wxString type
  CODE:
    RETVAL = THIS->LoadFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadStreamType( stream, type )
    wxPliInputStream stream
    long type
  CODE:
    RETVAL = THIS->LoadFile( stream, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadStreamMIME( stream, type )
    wxPliInputStream stream
    wxString type
  CODE:
    RETVAL = THIS->LoadFile( stream, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::Ok()

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

bool
Wx_Image::SaveFileOnly( name )
    wxString name
  CODE:
    RETVAL = THIS->SaveFile( name );
  OUTPUT:
    RETVAL

#endif

bool
Wx_Image::SaveFileType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = THIS->SaveFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::SaveFileMIME( name, type )
    wxString name
    wxString type
  CODE:
    RETVAL = THIS->SaveFile( name, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::SaveStreamType( stream, type )
    wxPliOutputStream stream
    long type
  CODE:
    RETVAL = THIS->SaveFile( stream, type );
  OUTPUT:
    RETVAL

bool
Wx_Image::SaveStreamMIME( stream, type )
    wxPliOutputStream stream
    wxString type
  CODE:
    RETVAL = THIS->SaveFile( stream, type );
  OUTPUT:
    RETVAL

void
Wx_Image::Mirror( horizontally = TRUE )
    bool horizontally

void
Wx_Image::Replace( r1, g1, b1, r2, g2, b2 )
    unsigned char r1
    unsigned char g1
    unsigned char b1
    unsigned char r2
    unsigned char g2
    unsigned char b2

Wx_Image*
Wx_Image::Rescale( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( THIS->Rescale( width, height ) );
  OUTPUT:
    RETVAL

void
Wx_Image::Rotate( angle, centre, interpolating = TRUE )
    double angle
    Wx_Point centre
    bool interpolating
  PREINIT:
    wxPoint after;
    wxImage* result;
  PPCODE:
    result = new wxImage( THIS->Rotate( angle, centre, interpolating, &after ) );
    XPUSHs( wxPli_object_2_sv( sv_newmortal(), result ) );
    if( GIMME_V == G_ARRAY ) {
      PUSHs( wxPli_non_object_2_sv( sv_newmortal(), 
             new wxPoint( after ), wxPlPointName ) );
    }

Wx_Image*
Wx_Image::Rotate90( clockwise = TRUE )
    bool clockwise
  CODE:
    RETVAL = new wxImage( THIS->Rotate90( clockwise ) );
  OUTPUT:
    RETVAL

Wx_Image*
Wx_Image::Scale( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( THIS->Scale( width, height ) );
  OUTPUT:
    RETVAL

void
Wx_Image::SetData( d )
    SV* d
  CODE:
    STRLEN len;
    unsigned char* data = (unsigned char*)SvPV( d, len );
    STRLEN imglen = THIS->GetWidth() * THIS->GetHeight() * 3;
    unsigned char* data_copy = (unsigned char*)malloc( imglen );
    memcpy( data_copy, data, len );
    THIS->SetData( data_copy );

void
Wx_Image::SetMask( hasMask = TRUE )
    bool hasMask

void
Wx_Image::SetMaskColour( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

void
Wx_Image::SetOption( name, value )
    wxString name
    wxString value

void
Wx_Image::SetOptionInt( name, value )
    wxString name
    int value
  CODE:
    THIS->SetOption( name, value );

void
Wx_Image::SetPalette( palette )
    Wx_Palette* palette
  CODE:
    THIS->SetPalette( *palette );

#endif

void
Wx_Image::SetRGB( x, y, red, green, blue )
    int x
    int y
    unsigned char red
    unsigned char green
    unsigned char blue

MODULE=Wx PACKAGE=Wx::ImageHandler

void
Wx_ImageHandler::Destroy()
  CODE:
    delete THIS;

int
Wx_ImageHandler::GetImageCount( stream )
    wxPliInputStream stream

wxString
Wx_ImageHandler::GetName()

wxString
Wx_ImageHandler::GetExtension()

long
Wx_ImageHandler::GetType()

wxString
Wx_ImageHandler::GetMimeType()

bool
Wx_ImageHandler::LoadFile( image, stream, verbose = TRUE, index = 0 )
    Wx_Image* image
    wxPliInputStream stream
    bool verbose
    int index

bool
Wx_ImageHandler::SaveFile( image, stream )
    Wx_Image* image
    wxPliOutputStream stream

void
Wx_ImageHandler::SetName( name )
    wxString name

void
Wx_ImageHandler::SetExtension( ext )
    wxString ext

void
Wx_ImageHandler::SetMimeType( type )
    wxString type

void
Wx_ImageHandler::SetType( type )
    long type

MODULE=Wx PACKAGE=Wx::GIFHandler

Wx_GIFHandler*
Wx_GIFHandler::new()

MODULE=Wx PACKAGE=Wx::BMPHandler

Wx_BMPHandler*
Wx_BMPHandler::new()

MODULE=Wx PACKAGE=Wx::PNMHandler

Wx_PNMHandler*
Wx_PNMHandler::new()

MODULE=Wx PACKAGE=Wx::PCXHandler

Wx_PCXHandler*
Wx_PCXHandler::new()

MODULE=Wx PACKAGE=Wx::PNGHandler

Wx_PNGHandler*
Wx_PNGHandler::new()

MODULE=Wx PACKAGE=Wx::JPEGHandler

Wx_JPEGHandler*
Wx_JPEGHandler::new()

MODULE=Wx PACKAGE=Wx::TIFFHandler

Wx_TIFFHandler*
Wx_TIFFHandler::new()

MODULE=Wx PACKAGE=Wx::XPMHandler

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_XPMHandler*
Wx_XPMHandler::new()

#endif

MODULE=Wx PACKAGE=Wx::IFFHandler

#if wxPERL_USE_IFF

Wx_IFFHandler*
Wx_IFFHandler::new()

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

void
wxInitAllImageHandlers()
