#############################################################################
## Name:        DC.xs
## Purpose:     XS for Wx::DC and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: DC.xs,v 1.19 2003/05/05 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dc.h>
#include <wx/dcmemory.h>
#include <wx/dcclient.h>
#include <wx/dcscreen.h>

MODULE=Wx PACKAGE=Wx::DC

void
DESTROY( THIS )
    Wx_DC* THIS
  CODE:
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;

void
Wx_DC::BeginDrawing()

bool
Wx_DC::Blit( xdest, ydest, width, height, source, xsrc, ysrc, logicalFunc = wxCOPY, useMask = FALSE )
    wxCoord xdest
    wxCoord ydest
    wxCoord width
    wxCoord height
    Wx_DC* source
    wxCoord xsrc
    wxCoord ysrc
    int logicalFunc
    bool useMask

void
Wx_DC::CalcBoundingBox( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::Clear()

void
Wx_DC::CrossHair( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::DestroyClippingRegion()

wxCoord
Wx_DC::DeviceToLogicalX( x )
    wxCoord x

wxCoord
Wx_DC::DeviceToLogicalXRel( x )
    wxCoord x

wxCoord
Wx_DC::DeviceToLogicalY( y )
    wxCoord y

wxCoord
Wx_DC::DeviceToLogicalYRel( y )
    wxCoord y

void
Wx_DC::DrawArc( x1, y1, x2, y2, xc, yc )
    wxCoord x1
    wxCoord y1
    wxCoord x2
    wxCoord y2
    wxCoord xc
    wxCoord yc

void
Wx_DC::DrawBitmap( bitmap, x, y, transparent )
    Wx_Bitmap* bitmap
    wxCoord x
    wxCoord y
    bool transparent
  CODE:
    THIS->DrawBitmap( *bitmap, x, y, transparent );

void
Wx_DC::DrawCheckMark( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, DrawCheckMarkXYWH )
        MATCH_REDISP( wxPliOvl_wrec, DrawCheckMarkRect )
    END_OVERLOAD( Wx::DC::DrawCheckMark )

void
Wx_DC::DrawCheckMarkXYWH( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
  CODE:
    THIS->DrawCheckMark( x, y, width, height );

void
Wx_DC::DrawCheckMarkRect( rect )
    Wx_Rect* rect
  CODE:
    THIS->DrawCheckMark( *rect );

void
Wx_DC::DrawEllipse( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height

void
Wx_DC::DrawEllipticArc( x, y, width, height, start, end )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
    double start
    double end

void
Wx_DC::DrawIcon( icon, x, y )
    Wx_Icon* icon
    wxCoord x
    wxCoord y
  CODE:
    THIS->DrawIcon( *icon, x, y );

void
Wx_DC::DrawLine( x1, y1, x2, y2 )
    wxCoord x1
    wxCoord y1
    wxCoord x2
    wxCoord y2

void
Wx_DC::DrawLines( list, xoffset = 0, yoffset = 0 )
    SV* list
    wxCoord xoffset
    wxCoord yoffset
  PREINIT:
    wxList points;
    wxPoint* pts;
  CODE:
    wxPli_av_2_pointlist( aTHX_ list, &points, &pts );
    THIS->DrawLines( &points, xoffset, yoffset );
    delete [] pts;

void
Wx_DC::DrawObject( object )
    Wx_DrawObject* object

void
Wx_DC::DrawPoint( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::DrawPolygon( list, xoffset, yoffset, fill_style = wxODDEVEN_RULE )
    SV* list
    wxCoord xoffset
    wxCoord yoffset
    int fill_style
  PREINIT:
    wxList points;
    wxPoint* pts;
  CODE:
    wxPli_av_2_pointlist( aTHX_ list, &points, &pts );
    THIS->DrawPolygon( &points, xoffset, yoffset, fill_style );
    delete [] pts;


void
Wx_DC::DrawRectangle( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height

void
Wx_DC::DrawRotatedText( text, x, y, angle )
    wxString text
    wxCoord x
    wxCoord y
    double angle

void
Wx_DC::DrawRoundedRectangle( x, y, width, height, radius = 20 )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
    wxCoord radius

void
Wx_DC::DrawSpline( list )
    SV* list
  PREINIT:
    wxList points;
    wxPoint* pts;
  CODE:
    wxPli_av_2_pointlist( aTHX_ list, &points, &pts );
    THIS->DrawSpline( &points );
    delete [] pts;

void
Wx_DC::DrawText( text, x, y )
    wxString text
    wxCoord x
    wxCoord y

void
Wx_DC::EndDoc()

void
Wx_DC::EndDrawing()

void
Wx_DC::EndPage()

void
Wx_DC::FloodFill( x, y, colour, style =  wxFLOOD_SURFACE )
    wxCoord x
    wxCoord y
    Wx_Colour* colour
    int style
  CODE:
    THIS->FloodFill( x, y, *colour, style );

Wx_Brush*
Wx_DC::GetBackground()
  CODE:
    RETVAL = new wxBrush( THIS->GetBackground() );
  OUTPUT:
    RETVAL

int
Wx_DC::GetBackgroundMode()

Wx_Brush*
Wx_DC::GetBrush()
  CODE:
    RETVAL = new wxBrush( THIS->GetBrush() );
  OUTPUT:
    RETVAL

wxCoord
Wx_DC::GetCharHeight()

wxCoord
Wx_DC::GetCharWidth()

void
Wx_DC::GetClippingBox()
  PREINIT:
    wxCoord x, y, width, height;
  PPCODE:
    THIS->GetClippingBox( &x, &y, &width, &height );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( width ) ) );
    PUSHs( sv_2mortal( newSViv( height ) ) );

Wx_Font*
Wx_DC::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

int
Wx_DC::GetLogicalFunction()

int
Wx_DC::GetMapMode()

bool
Wx_DC::GetOptimization()

Wx_Pen*
Wx_DC::GetPen()
  CODE:
    RETVAL = new wxPen( THIS->GetPen() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_DC::GetPixel( x, y )
    wxCoord x
    wxCoord y
  PREINIT:
    wxColour c;
  CODE:
    THIS->GetPixel( x, y, &c );
    RETVAL = new wxColour( c );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_DC::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
Wx_DC::GetSizeWH()
  PREINIT:
    wxCoord x, y;
  PPCODE:
    THIS->GetSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

Wx_Colour*
Wx_DC::GetTextBackground()
  CODE:
    RETVAL = new wxColour( THIS->GetTextBackground() );
  OUTPUT:
    RETVAL

void
Wx_DC::GetTextExtent( string, font = 0 )
    wxString string
    Wx_Font* font
  PREINIT:
    wxCoord x;
    wxCoord y;
    wxCoord descent;
    wxCoord externalLeading;
  PPCODE:
    THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading,
        font );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( descent ) ) );
    PUSHs( sv_2mortal( newSViv( externalLeading ) ) );

Wx_Colour*
Wx_DC::GetTextForeground()
  CODE:
    RETVAL = new wxColour( THIS->GetTextForeground() );
  OUTPUT:
    RETVAL

void
Wx_DC::GetUserScale()
  PREINIT:
    double x, y;
  PPCODE:
    THIS->GetUserScale( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );

wxCoord
Wx_DC::LogicalToDeviceX( x )
    wxCoord x

wxCoord
Wx_DC::LogicalToDeviceXRel( x )
    wxCoord x

wxCoord
Wx_DC::LogicalToDeviceY( y )
    wxCoord y

wxCoord
Wx_DC::LogicalToDeviceYRel( y )
    wxCoord y

wxCoord
Wx_DC::MaxX()

wxCoord
Wx_DC::MaxY()

wxCoord
Wx_DC::MinX()

wxCoord
Wx_DC::MinY()

bool
Wx_DC::Ok()

void
Wx_DC::ResetBoundingBox()

void
Wx_DC::SetAxisOrientation( xLeftRight, yBottomUp )
    bool xLeftRight
    bool yBottomUp

wxPoint*
wxDC::GetDeviceOrigin()
  CODE:
    RETVAL = new wxPoint( THIS->GetDeviceOrigin() );
  OUTPUT: RETVAL

void
Wx_DC::SetDeviceOrigin( x, y )
    wxCoord x
    wxCoord y

void
Wx_DC::SetBackground( brush )
    Wx_Brush* brush
  CODE:
    THIS->SetBackground( *brush );

void
Wx_DC::SetBackgroundMode( mode )
    int mode

void
Wx_DC::SetBrush( brush )
    Wx_Brush* brush
  CODE:
    THIS->SetBrush( *brush );

void
Wx_DC::SetClippingRegion( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, SetClippingRegionXYWH )
        MATCH_REDISP( wxPliOvl_wreg, SetClippingRegionRegion )
    END_OVERLOAD( Wx::DC::SetClippingRegion )

void
Wx_DC::SetClippingRegionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    THIS->SetClippingRegion( x, y, w, h );

void
Wx_DC::SetClippingRegionRegion( region )
    Wx_Region* region
  CODE:
    THIS->SetClippingRegion( *region );

void
Wx_DC::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

void
Wx_DC::SetLogicalFunction( function )
    int function

void
Wx_DC::SetMapMode( mode )
    int mode

void
Wx_DC::SetOptimization( optimize )
    bool optimize

void
Wx_DC::SetPalette( palette )
    Wx_Palette* palette
  CODE:
    THIS->SetPalette( *palette );

void
Wx_DC::SetPen( pen )
    Wx_Pen* pen
  CODE:
    THIS->SetPen( *pen );

void
Wx_DC::SetTextBackground( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetTextBackground( *colour );

void
Wx_DC::SetTextForeground( colour )
    Wx_Colour* colour
  CODE:
    THIS->SetTextForeground( *colour );

void
Wx_DC::SetUserScale( xScale, yScale )
    double xScale
    double yScale

bool
Wx_DC::StartDoc( message )
    wxString message

void
Wx_DC::StartPage()

MODULE=Wx PACKAGE=Wx::ScreenDC

Wx_ScreenDC*
Wx_ScreenDC::new()

bool
Wx_ScreenDC::EndDrawingOnTop()

void
Wx_ScreenDC::StartDrawingOnTop( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin, StartDrawingOnTopWindow )
        MATCH_REDISP( wxPliOvl_wrec, StartDrawingOnTopRect )
    END_OVERLOAD( Wx::ScreenDC::StartDrawingOnTop )

bool
Wx_ScreenDC::StartDrawingOnTopWindow( window )
    Wx_Window* window
  CODE:
    RETVAL = THIS->StartDrawingOnTop( window );
  OUTPUT:
    RETVAL

bool
Wx_ScreenDC::StartDrawingOnTopRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->StartDrawingOnTop( rect );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::WindowDC

Wx_WindowDC*
Wx_WindowDC::new( window )
    Wx_Window* window

MODULE=Wx PACKAGE=Wx::PaintDC

Wx_PaintDC*
Wx_PaintDC::new( window )
    Wx_Window* window

MODULE=Wx PACKAGE=Wx::MemoryDC

Wx_MemoryDC*
Wx_MemoryDC::new()

void
Wx_MemoryDC::SelectObject( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SelectObject( *bitmap );

MODULE=Wx PACKAGE=Wx::ClientDC

Wx_ClientDC*
Wx_ClientDC::new( window )
    Wx_Window* window
