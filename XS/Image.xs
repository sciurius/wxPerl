#############################################################################
## Name:        Image.xs
## Purpose:     XS for Wx::Image
## Author:      Mattia Barbon
## Modified by:
## Created:      2/12/2000
## RCS-ID:      $Id: Image.xs,v 1.28 2003/05/05 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/image.h>
#include "cpp/streams.h"
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::Image

void
wxImage::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newNull )
        MATCH_REDISP( wxPliOvl_wico, newIcon )
        MATCH_REDISP( wxPliOvl_wbmp, newBitmap )
        MATCH_REDISP( wxPliOvl_wist_n, newStreamType )
        MATCH_REDISP( wxPliOvl_wist_s, newStreamMIME )
        MATCH_REDISP_COUNT( wxPliOvl_n_n, newWH, 2 )
        MATCH_REDISP( wxPliOvl_n_n_s, newData )
        MATCH_REDISP( wxPliOvl_s_n, newNameType )
        MATCH_REDISP( wxPliOvl_s_s, newNameMIME )
    END_OVERLOAD( Wx::Image::new )

Wx_Image*
newNull( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxImage();
  OUTPUT:
    RETVAL

Wx_Image*
newWH( CLASS, width, height )
    SV* CLASS
    int width
    int height
  CODE:
    RETVAL = new wxImage( width, height );
  OUTPUT:
    RETVAL

Wx_Image*
newData( CLASS, width, height, dt )
    SV* CLASS
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
        croak( "too few data in image constructor" );
    }
    newdata = (unsigned char*)malloc( width * height * 3 );
    memcpy( newdata, data, width * height * 3 );

    RETVAL = new wxImage( width, height, newdata );
  OUTPUT:
    RETVAL

Wx_Image*
newNameType( CLASS, name, type, index = -1 )
    SV* CLASS
    wxString name
    long type
    int index
  CODE:
    RETVAL = new wxImage( name, type, index );
  OUTPUT:
    RETVAL

Wx_Image*
newNameMIME( CLASS, name, mimetype, index = -1 )
    SV* CLASS
    wxString name
    wxString mimetype
    int index
  CODE:
    RETVAL = new wxImage( name, mimetype, index );
  OUTPUT:
    RETVAL

Wx_Image*
newStreamType( CLASS, stream, type, index = -1 )
    SV* CLASS
    wxPliInputStream stream
    long type
    int index
  CODE:
    RETVAL = new wxImage( stream, type, index );
  OUTPUT:
    RETVAL

Wx_Image*
newStreamMIME( CLASS, stream, mime, index = -1 )
    SV* CLASS
    wxPliInputStream stream
    wxString mime
    int index
  CODE:
    RETVAL = new wxImage( stream, mime, index );
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

Wx_Image*
Wx_Image::ConvertToMono( r, g, b )
    unsigned char r
    unsigned char g
    unsigned char b
  CODE:
    RETVAL = new wxImage( THIS->ConvertToMono( r, g, b ) );
  OUTPUT:
    RETVAL

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

bool
Wx_Image::HasOption( name )
    wxString name

bool
Wx_Image::HasPalette()

void
InsertHandler( handler )
    Wx_ImageHandler* handler
  CODE:
    wxImage::InsertHandler( handler );

void
wxImage::LoadFile( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wist_n, LoadStreamType )
        MATCH_REDISP( wxPliOvl_wist_s, LoadStreamMIME )
        MATCH_REDISP( wxPliOvl_s_n, LoadFileType )
        MATCH_REDISP( wxPliOvl_s_s, LoadFileMIME )
    END_OVERLOAD( Wx::Image::LoadFile )

bool
Wx_Image::LoadFileType( name, type, index = -1 )
    wxString name
    long type
    int index
  CODE:
    RETVAL = THIS->LoadFile( name, type, index );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadFileMIME( name, type, index = -1 )
    wxString name
    wxString type
    int index
  CODE:
    RETVAL = THIS->LoadFile( name, type, index );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadStreamType( stream, type, index = -1 )
    wxPliInputStream stream
    long type
    int index
  CODE:
    RETVAL = THIS->LoadFile( stream, type, index );
  OUTPUT:
    RETVAL

bool
Wx_Image::LoadStreamMIME( stream, type, index = -1 )
    wxPliInputStream stream
    wxString type
    int index
  CODE:
    RETVAL = THIS->LoadFile( stream, type, index );
  OUTPUT:
    RETVAL

bool
Wx_Image::Ok()

void
wxImage::SaveFile( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wost_n, SaveFileSType )
        MATCH_REDISP( wxPliOvl_wost_s, SaveFileSMIME )
        MATCH_REDISP( wxPliOvl_s_n, SaveFileType )
        MATCH_REDISP( wxPliOvl_s_s, SaveFileMIME )
        MATCH_REDISP( wxPliOvl_s, SaveFileOnly )
    END_OVERLOAD( Wx::Image::SaveFile )

bool
Wx_Image::SaveFileOnly( name )
    wxString name
  CODE:
    RETVAL = THIS->SaveFile( name );
  OUTPUT:
    RETVAL

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
    XPUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), result ) );
    if( GIMME_V == G_ARRAY ) {
      PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(), 
             new wxPoint( after ), "Wx::Point" ) );
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

Wx_XPMHandler*
Wx_XPMHandler::new()

MODULE=Wx PACKAGE=Wx::IFFHandler

#if wxPERL_USE_IFF

Wx_IFFHandler*
Wx_IFFHandler::new()

#endif

#if wxPERL_USE_ICO_CUR

MODULE=Wx PACKAGE=Wx::ICOHandler

Wx_ICOHandler*
Wx_ICOHandler::new()

MODULE=Wx PACKAGE=Wx::CURHandler

Wx_CURHandler*
Wx_CURHandler::new()

MODULE=Wx PACKAGE=Wx::ANIHandler

Wx_ANIHandler*
Wx_ANIHandler::new()

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

void
wxInitAllImageHandlers()
