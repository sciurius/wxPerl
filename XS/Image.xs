#############################################################################
## Name:        XS/Image.xs
## Purpose:     XS for Wx::Image
## Author:      Mattia Barbon
## Modified by:
## Created:     02/12/2000
## RCS-ID:      $Id: Image.xs,v 1.38 2006/07/24 19:27:55 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/image.h>
#include <wx/bitmap.h>
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
        MATCH_REDISP( wxPliOvl_n_n_s_s, newDataAlpha )
        MATCH_REDISP( wxPliOvl_s_n, newNameType )
        MATCH_REDISP( wxPliOvl_s_s, newNameMIME )
    END_OVERLOAD( Wx::Image::new )

wxImage*
newNull( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxImage();
  OUTPUT:
    RETVAL

wxImage*
newWH( CLASS, width, height )
    SV* CLASS
    int width
    int height
  CODE:
    RETVAL = new wxImage( width, height );
  OUTPUT:
    RETVAL

wxImage*
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
        croak( "not enough data in image constructor" );
    }
    newdata = (unsigned char*)malloc( width * height * 3 );
    memcpy( newdata, data, width * height * 3 );

    RETVAL = new wxImage( width, height, newdata );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxImage*
newDataAlpha( CLASS, width, height, dt, al )
    SV* CLASS
    int width
    int height
    SV* dt
    SV* al
  PREINIT:
    STRLEN len_data, len_alpha;
    unsigned char* data = (unsigned char*)SvPV( dt, len_data );
    unsigned char* alpha = (unsigned char*)SvPV( al, len_alpha );
  CODE:
    if( len_data != (STRLEN) width * height * 3 ||
        len_alpha != (STRLEN) width * height )
    {
        croak( "not enough data in image constructor" );
    }
    unsigned char* newdata = (unsigned char*) malloc( len_data );
    memcpy( newdata, data, len_data );
    unsigned char* newalpha = (unsigned char*) malloc( len_alpha );
    memcpy( newalpha, alpha, len_alpha );

    RETVAL = new wxImage( width, height, newdata, newalpha );
  OUTPUT:
    RETVAL

#endif

wxImage*
newNameType( CLASS, name, type, index = -1 )
    SV* CLASS
    wxString name
    long type
    int index
  CODE:
    RETVAL = new wxImage( name, type, index );
  OUTPUT:
    RETVAL

wxImage*
newNameMIME( CLASS, name, mimetype, index = -1 )
    SV* CLASS
    wxString name
    wxString mimetype
    int index
  CODE:
    RETVAL = new wxImage( name, mimetype, index );
  OUTPUT:
    RETVAL

wxImage*
newStreamType( CLASS, stream, type, index = -1 )
    SV* CLASS
    wxPliInputStream stream
    long type
    int index
  CODE:
    RETVAL = new wxImage( stream, type, index );
  OUTPUT:
    RETVAL

wxImage*
newStreamMIME( CLASS, stream, mime, index = -1 )
    SV* CLASS
    wxPliInputStream stream
    wxString mime
    int index
  CODE:
    RETVAL = new wxImage( stream, mime, index );
  OUTPUT:
    RETVAL

wxImage*
newBitmap( CLASS, bitmap )
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxImage( bitmap->ConvertToImage() );
  OUTPUT: RETVAL

wxImage*
newIcon( CLASS, icon )
    wxIcon* icon
  CODE:
    wxBitmap tmp; tmp.CopyFromIcon( *icon );
    RETVAL = new wxImage( tmp.ConvertToImage() );
  OUTPUT: RETVAL

## XXX threads
void
wxImage::DESTROY()

void
AddHandler( handler )
    wxImageHandler* handler
  CODE:
    wxImage::AddHandler( handler );

wxImage*
wxImage::ConvertToMono( r, g, b )
    unsigned char r
    unsigned char g
    unsigned char b
  CODE:
    RETVAL = new wxImage( THIS->ConvertToMono( r, g, b ) );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxImage::ConvertAlphaToMask( threshold = 128 )
    unsigned char threshold

#endif

#if WXPERL_W_VERSION_GE( 2, 5, 4 )

bool
wxImage::ConvertColourToAlpha( r, g, b )
    unsigned char r
    unsigned char g
    unsigned char b

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 0 )
 
wxImage*
wxImage::ConvertToGreyscale()
  CODE:
    RETVAL = new wxImage( THIS->ConvertToGreyscale() );
  OUTPUT:
    RETVAL
 
#endif

wxImage*
wxImage::Copy()
  CODE:
    RETVAL = new wxImage( THIS->Copy() );
  OUTPUT:
    RETVAL

void
wxImage::Create( width, height )
    int width
    int height

void
wxImage::Destroy()

wxImageHandler*
FindHandlerName( name )
    wxString name
  CODE:
    RETVAL = wxImage::FindHandler( name );
  OUTPUT:
    RETVAL

wxImageHandler*
FindHandlerExtType( extension, type )
    wxString extension
    long type
  CODE:
    RETVAL = wxImage::FindHandler( extension, type );
  OUTPUT:
    RETVAL

wxImageHandler*
FindHandlerType( type )
    long type
  CODE:
    RETVAL = wxImage::FindHandler( type );
  OUTPUT:
    RETVAL

wxImageHandler*
FindHandlerMime( mime )
   wxString mime
  CODE:
    RETVAL = wxImage::FindHandlerMime( mime );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxImage::GetAlpha( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( GetAlphaData )
        MATCH_REDISP( wxPliOvl_n_n, GetAlphaXY )
    END_OVERLOAD( Wx::Image::GetAlpha )

unsigned char
wxImage::GetAlphaXY( x, y )
    int x
    int y
  CODE:
    RETVAL = THIS->GetAlpha( x, y );
  OUTPUT: RETVAL

SV*
wxImage::GetAlphaData()
  CODE:
    unsigned char* alpha = THIS->GetAlpha();

    if( alpha == NULL )
        XSRETURN_UNDEF;

    RETVAL = newSVpvn( (char*) alpha, THIS->GetWidth() * THIS->GetHeight() );
  OUTPUT:
    RETVAL

#endif

SV*
wxImage::GetData()
  CODE:
    STRLEN len = THIS->GetWidth() * THIS->GetHeight() * 3;
    RETVAL = newSVpvn( (char*)THIS->GetData(), len );
  OUTPUT:
    RETVAL

unsigned char
wxImage::GetBlue( x, y )
    int x
    int y

unsigned char
wxImage::GetGreen( x, y )
    int x
    int y

unsigned char
wxImage::GetRed( x, y )
    int x
    int y

int
wxImage::GetHeight()

unsigned char
wxImage::GetMaskBlue()

unsigned char
wxImage::GetMaskGreen()

unsigned char
wxImage::GetMaskRed()

wxString
wxImage::GetOption( name )
    wxString name

int
wxImage::GetOptionInt( name )
    wxString name

wxPalette*
wxImage::GetPalette()
  CODE:
    RETVAL = new wxPalette( THIS->GetPalette() );
  OUTPUT:
    RETVAL

wxImage*
wxImage::GetSubImage( rect )
    wxRect* rect
  CODE:
    RETVAL = new wxImage( THIS->GetSubImage( *rect ) );
  OUTPUT:
    RETVAL

int
wxImage::GetWidth()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxImage::HasAlpha()

#endif

#if WXPERL_W_VERSION_GE( 2, 5, 4 )

void
wxImage::InitAlpha()

#endif

bool
wxImage::HasMask()

bool
wxImage::HasOption( name )
    wxString name

bool
wxImage::HasPalette()

void
InsertHandler( handler )
    wxImageHandler* handler
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
wxImage::LoadFileType( name, type, index = -1 )
    wxString name
    long type
    int index
  CODE:
    RETVAL = THIS->LoadFile( name, type, index );
  OUTPUT:
    RETVAL

bool
wxImage::LoadFileMIME( name, type, index = -1 )
    wxString name
    wxString type
    int index
  CODE:
    RETVAL = THIS->LoadFile( name, type, index );
  OUTPUT:
    RETVAL

bool
wxImage::LoadStreamType( stream, type, index = -1 )
    wxPliInputStream stream
    long type
    int index
  CODE:
    RETVAL = THIS->LoadFile( stream, type, index );
  OUTPUT:
    RETVAL

bool
wxImage::LoadStreamMIME( stream, type, index = -1 )
    wxPliInputStream stream
    wxString type
    int index
  CODE:
    RETVAL = THIS->LoadFile( stream, type, index );
  OUTPUT:
    RETVAL

bool
wxImage::Ok()

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
wxImage::SaveFileOnly( name )
    wxString name
  CODE:
    RETVAL = THIS->SaveFile( name );
  OUTPUT:
    RETVAL

bool
wxImage::SaveFileType( name, type )
    wxString name
    long type
  CODE:
    RETVAL = THIS->SaveFile( name, type );
  OUTPUT:
    RETVAL

bool
wxImage::SaveFileMIME( name, type )
    wxString name
    wxString type
  CODE:
    RETVAL = THIS->SaveFile( name, type );
  OUTPUT:
    RETVAL

bool
wxImage::SaveStreamType( stream, type )
    wxPliOutputStream stream
    long type
  CODE:
    RETVAL = THIS->SaveFile( stream, type );
  OUTPUT:
    RETVAL

bool
wxImage::SaveStreamMIME( stream, type )
    wxPliOutputStream stream
    wxString type
  CODE:
    RETVAL = THIS->SaveFile( stream, type );
  OUTPUT:
    RETVAL

wxImage*
wxImage::Mirror( horizontally = true )
    bool horizontally
  CODE:
    RETVAL = new wxImage( THIS->Mirror( horizontally ) );
  OUTPUT: RETVAL

void
wxImage::Replace( r1, g1, b1, r2, g2, b2 )
    unsigned char r1
    unsigned char g1
    unsigned char b1
    unsigned char r2
    unsigned char g2
    unsigned char b2

wxImage*
wxImage::Rescale( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( THIS->Rescale( width, height ) );
  OUTPUT:
    RETVAL

void
wxImage::Rotate( angle, centre, interpolating = true )
    double angle
    wxPoint centre
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

wxImage*
wxImage::Rotate90( clockwise = true )
    bool clockwise
  CODE:
    RETVAL = new wxImage( THIS->Rotate90( clockwise ) );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 4, 1 )

wxImage*
wxImage::ShrinkBy( xfactor, yfactor )
    int xfactor
    int yfactor
  CODE:
    RETVAL = new wxImage( THIS->ShrinkBy( xfactor, yfactor ) );
  OUTPUT: RETVAL

#endif

wxImage*
wxImage::Scale( width, height )
    int width
    int height
  CODE:
    RETVAL = new wxImage( THIS->Scale( width, height ) );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxImage::SetAlpha( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_s, SetAlphaData )
        MATCH_REDISP( wxPliOvl_n_n_n, SetAlphaXY )
    END_OVERLOAD( Wx::Image::SetAlpha )

void
wxImage::SetAlphaXY( x, y, alpha )
    int x
    int y
    unsigned char alpha
  CODE:
    THIS->SetAlpha( x, y, alpha );

void
wxImage::SetAlphaData( d )
    SV* d
  CODE:
    STRLEN len;
    unsigned char* data = (unsigned char*) SvPV( d, len );
    STRLEN imglen = THIS->GetWidth() * THIS->GetHeight();
    unsigned char* data_copy = (unsigned char*) malloc( imglen );
    memcpy( data_copy, data, len );
    THIS->SetAlpha( data_copy );

#endif

void
wxImage::SetData( d )
    SV* d
  CODE:
    STRLEN len;
    unsigned char* data = (unsigned char*)SvPV( d, len );
    STRLEN imglen = THIS->GetWidth() * THIS->GetHeight() * 3;
    unsigned char* data_copy = (unsigned char*)malloc( imglen );
    memcpy( data_copy, data, len );
    THIS->SetData( data_copy );

void
wxImage::SetMask( hasMask = true )
    bool hasMask

void
wxImage::SetMaskColour( red, green, blue )
    unsigned char red
    unsigned char green
    unsigned char blue

void
wxImage::SetOption( name, value )
    wxString name
    wxString value

void
wxImage::SetOptionInt( name, value )
    wxString name
    int value
  CODE:
    THIS->SetOption( name, value );

void
wxImage::SetPalette( palette )
    wxPalette* palette
  CODE:
    THIS->SetPalette( *palette );

void
wxImage::SetRGB( x, y, red, green, blue )
    int x
    int y
    unsigned char red
    unsigned char green
    unsigned char blue

MODULE=Wx PACKAGE=Wx::ImageHandler

void
wxImageHandler::Destroy()
  CODE:
    delete THIS;

int
wxImageHandler::GetImageCount( stream )
    wxPliInputStream stream

wxString
wxImageHandler::GetName()

wxString
wxImageHandler::GetExtension()

long
wxImageHandler::GetType()

wxString
wxImageHandler::GetMimeType()

bool
wxImageHandler::LoadFile( image, stream, verbose = true, index = 0 )
    wxImage* image
    wxPliInputStream stream
    bool verbose
    int index

bool
wxImageHandler::SaveFile( image, stream )
    wxImage* image
    wxPliOutputStream stream

void
wxImageHandler::SetName( name )
    wxString name

void
wxImageHandler::SetExtension( ext )
    wxString ext

void
wxImageHandler::SetMimeType( type )
    wxString type

void
wxImageHandler::SetType( type )
    long type

MODULE=Wx PACKAGE=Wx::GIFHandler

wxGIFHandler*
wxGIFHandler::new()

MODULE=Wx PACKAGE=Wx::BMPHandler

wxBMPHandler*
wxBMPHandler::new()

MODULE=Wx PACKAGE=Wx::PNMHandler

wxPNMHandler*
wxPNMHandler::new()

MODULE=Wx PACKAGE=Wx::PCXHandler

wxPCXHandler*
wxPCXHandler::new()

MODULE=Wx PACKAGE=Wx::PNGHandler

wxPNGHandler*
wxPNGHandler::new()

MODULE=Wx PACKAGE=Wx::JPEGHandler

wxJPEGHandler*
wxJPEGHandler::new()

MODULE=Wx PACKAGE=Wx::TIFFHandler

wxTIFFHandler*
wxTIFFHandler::new()

MODULE=Wx PACKAGE=Wx::XPMHandler

wxXPMHandler*
wxXPMHandler::new()

MODULE=Wx PACKAGE=Wx::IFFHandler

#if wxPERL_USE_IFF

wxIFFHandler*
wxIFFHandler::new()

#endif

#if wxPERL_USE_ICO_CUR

MODULE=Wx PACKAGE=Wx::ICOHandler

wxICOHandler*
wxICOHandler::new()

MODULE=Wx PACKAGE=Wx::CURHandler

wxCURHandler*
wxCURHandler::new()

MODULE=Wx PACKAGE=Wx::ANIHandler

wxANIHandler*
wxANIHandler::new()

#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

void
wxInitAllImageHandlers()
