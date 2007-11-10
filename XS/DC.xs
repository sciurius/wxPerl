#############################################################################
## Name:        XS/DC.xs
## Purpose:     XS for Wx::DC and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%{
#include <wx/dc.h>
#include <wx/dcmemory.h>
#include <wx/dcclient.h>
#include <wx/dcscreen.h>
#include <wx/window.h>
#include <wx/dcbuffer.h>

#define wxNullBitmapPtr (wxBitmap*) &wxNullBitmap

MODULE=Wx PACKAGE=Wx::DC

static void
wxDC::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxDC::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ),
                                THIS, ST(0) );
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;

#if WXPERL_W_VERSION_LT( 2, 7, 0 ) || WXWIN_COMPATIBILITY_2_6

void
wxDC::BeginDrawing()

#endif

bool
wxDC::Blit( xdest, ydest, width, height, source, xsrc, ysrc, logicalFunc = wxCOPY, useMask = false )
    wxCoord xdest
    wxCoord ydest
    wxCoord width
    wxCoord height
    wxDC* source
    wxCoord xsrc
    wxCoord ysrc
    int logicalFunc
    bool useMask

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

bool
wxDC::StretchBlit( xdest, ydest, wdest, hdest, source, xsrc, ysrc, wsrc, hsrc, logicalFunc = wxCOPY, useMask = false, xsrcmask = -1, ysrcmask = -1 )
    wxCoord xdest
    wxCoord ydest
    wxCoord wdest
    wxCoord hdest
    wxDC* source
    wxCoord xsrc
    wxCoord ysrc
    wxCoord wsrc
    wxCoord hsrc
    int logicalFunc
    bool useMask
    wxCoord xsrcmask
    wxCoord ysrcmask

#endif

void
wxDC::CalcBoundingBox( x, y )
    wxCoord x
    wxCoord y

void
wxDC::Clear()

void
wxDC::CrossHair( x, y )
    wxCoord x
    wxCoord y

void
wxDC::DestroyClippingRegion()

wxCoord
wxDC::DeviceToLogicalX( x )
    wxCoord x

wxCoord
wxDC::DeviceToLogicalXRel( x )
    wxCoord x

wxCoord
wxDC::DeviceToLogicalY( y )
    wxCoord y

wxCoord
wxDC::DeviceToLogicalYRel( y )
    wxCoord y

void
wxDC::DrawArc( x1, y1, x2, y2, xc, yc )
    wxCoord x1
    wxCoord y1
    wxCoord x2
    wxCoord y2
    wxCoord xc
    wxCoord yc

void
wxDC::DrawBitmap( bitmap, x, y, transparent )
    wxBitmap* bitmap
    wxCoord x
    wxCoord y
    bool transparent
  CODE:
    THIS->DrawBitmap( *bitmap, x, y, transparent );

void
wxDC::DrawCheckMark( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, DrawCheckMarkXYWH )
        MATCH_REDISP( wxPliOvl_wrec, DrawCheckMarkRect )
    END_OVERLOAD( Wx::DC::DrawCheckMark )

void
wxDC::DrawCheckMarkXYWH( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
  CODE:
    THIS->DrawCheckMark( x, y, width, height );

void
wxDC::DrawCheckMarkRect( rect )
    wxRect* rect
  CODE:
    THIS->DrawCheckMark( *rect );

void
wxDC::DrawCircle( x, y, radius )
    wxCoord x
    wxCoord y
    wxCoord radius

void
wxDC::DrawEllipse( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height

void
wxDC::DrawEllipticArc( x, y, width, height, start, end )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
    double start
    double end

void
wxDC::DrawIcon( icon, x, y )
    wxIcon* icon
    wxCoord x
    wxCoord y
  CODE:
    THIS->DrawIcon( *icon, x, y );

void
wxDC::DrawLine( x1, y1, x2, y2 )
    wxCoord x1
    wxCoord y1
    wxCoord x2
    wxCoord y2

void
wxDC::DrawLines( list, xoffset = 0, yoffset = 0 )
    SV* list
    wxCoord xoffset
    wxCoord yoffset
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    wxPointList points;
#else
    wxList points;
#endif
    wxPliArrayGuard<wxPoint> pts;
  CODE:
    wxPli_av_2_pointlist( aTHX_ list, &points, pts.lvalue() );
    THIS->DrawLines( &points, xoffset, yoffset );

void
wxDC::DrawObject( object )
    wxDrawObject* object

void
wxDC::DrawPoint( x, y )
    wxCoord x
    wxCoord y

void
wxDC::DrawPolygon( list, xoffset, yoffset, fill_style = wxODDEVEN_RULE )
    SV* list
    wxCoord xoffset
    wxCoord yoffset
    int fill_style
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    wxPointList points;
#else
    wxList points;
#endif
    wxPliArrayGuard<wxPoint> pts;
  CODE:
    wxPli_av_2_pointlist( aTHX_ list, &points, pts.lvalue() );
    THIS->DrawPolygon( &points, xoffset, yoffset, fill_style );

void
wxDC::DrawRectangle( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height

void
wxDC::DrawRotatedText( text, x, y, angle )
    wxString text
    wxCoord x
    wxCoord y
    double angle

void
wxDC::DrawRoundedRectangle( x, y, width, height, radius = 20 )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
    wxCoord radius

void
wxDC::DrawSpline( list )
    SV* list
  PREINIT:
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    wxPointList points;
#else
    wxList points;
#endif
    wxPliArrayGuard<wxPoint> pts;
  CODE:
    wxPli_av_2_pointlist( aTHX_ list, &points, pts.lvalue() );
    THIS->DrawSpline( &points );

void
wxDC::DrawText( text, x, y )
    wxString text
    wxCoord x
    wxCoord y

void
wxDC::EndDoc()

#if WXPERL_W_VERSION_LT( 2, 7, 0 ) || WXWIN_COMPATIBILITY_2_6

void
wxDC::EndDrawing()

#endif

void
wxDC::EndPage()

void
wxDC::FloodFill( x, y, colour, style =  wxFLOOD_SURFACE )
    wxCoord x
    wxCoord y
    wxColour* colour
    int style
  CODE:
    THIS->FloodFill( x, y, *colour, style );

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

wxBitmap*
wxDC::GetAsBitmap( wxRect* subrect = NULL )
  CODE:
    RETVAL = new wxBitmap( THIS->GetAsBitmap( subrect ) );
  OUTPUT: RETVAL

#endif

wxBrush*
wxDC::GetBackground()
  CODE:
    RETVAL = new wxBrush( THIS->GetBackground() );
  OUTPUT:
    RETVAL

int
wxDC::GetBackgroundMode()

wxBrush*
wxDC::GetBrush()
  CODE:
    RETVAL = new wxBrush( THIS->GetBrush() );
  OUTPUT:
    RETVAL

wxCoord
wxDC::GetCharHeight()

wxCoord
wxDC::GetCharWidth()

void
wxDC::GetClippingBox()
  PREINIT:
    wxCoord x, y, width, height;
  PPCODE:
    THIS->GetClippingBox( &x, &y, &width, &height );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( width ) ) );
    PUSHs( sv_2mortal( newSViv( height ) ) );

wxFont*
wxDC::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

int
wxDC::GetLogicalFunction()

int
wxDC::GetMapMode()

#if !defined( __WXMAC__ ) && WXPERL_W_VERSION_LE( 2, 5, 3 )

bool
wxDC::GetOptimization()

#endif

wxPen*
wxDC::GetPen()
  CODE:
    RETVAL = new wxPen( THIS->GetPen() );
  OUTPUT:
    RETVAL

wxColour*
wxDC::GetPixel( x, y )
    wxCoord x
    wxCoord y
  PREINIT:
    wxColour c;
  CODE:
    THIS->GetPixel( x, y, &c );
    RETVAL = new wxColour( c );
  OUTPUT:
    RETVAL

wxSize*
wxDC::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
wxDC::GetSizeWH()
  PREINIT:
    wxCoord x, y;
  PPCODE:
    THIS->GetSize( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxSize*
wxDC::GetSizeMM()
  CODE:
    RETVAL = new wxSize( THIS->GetSizeMM() );
  OUTPUT:
    RETVAL

void
wxDC::GetSizeMMWH()
  PREINIT:
    wxCoord x, y;
  PPCODE:
    THIS->GetSizeMM( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxSize*
wxDC::GetPPI()
  CODE:
    RETVAL = new wxSize( THIS->GetPPI() );
  OUTPUT:
    RETVAL

wxColour*
wxDC::GetTextBackground()
  CODE:
    RETVAL = new wxColour( THIS->GetTextBackground() );
  OUTPUT:
    RETVAL

void
wxDC::GetTextExtent( string, font = NULL )
    wxString string
    wxFont* font
  PREINIT:
    wxCoord x, y, descent, externalLeading;
  PPCODE:
    THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading,
        font );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );
    PUSHs( sv_2mortal( newSViv( descent ) ) );
    PUSHs( sv_2mortal( newSViv( externalLeading ) ) );

void
wxDC::GetPartialTextExtents( string )
    wxString string
  PREINIT:
    wxArrayInt widths;
  PPCODE:
    bool ok = THIS->GetPartialTextExtents( string, widths );
    if( ok ) {
        PUTBACK;
        wxPli_intarray_push( aTHX_ widths );
        SPAGAIN;
    } else
        XSRETURN_EMPTY;

void
wxDC::GetMultiLineTextExtent( string, font = NULL )
    wxString string
    wxFont* font
  PREINIT:
    wxCoord w, h, hLine;
  PPCODE:
    THIS->GetMultiLineTextExtent( string, &w, &h, &hLine, font );
    EXTEND( SP, 3 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );
    PUSHs( sv_2mortal( newSViv( hLine ) ) );

wxColour*
wxDC::GetTextForeground()
  CODE:
    RETVAL = new wxColour( THIS->GetTextForeground() );
  OUTPUT:
    RETVAL

void
wxDC::GetUserScale()
  PREINIT:
    double x, y;
  PPCODE:
    THIS->GetUserScale( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

void
wxDC::GradientFillLinear( rect, initialColour, destColour, direction = wxEAST )
    wxRect* rect
    wxColour initialColour
    wxColour destColour
    wxDirection direction
  C_ARGS: *rect, initialColour, destColour, direction

#endif

wxCoord
wxDC::LogicalToDeviceX( x )
    wxCoord x

wxCoord
wxDC::LogicalToDeviceXRel( x )
    wxCoord x

wxCoord
wxDC::LogicalToDeviceY( y )
    wxCoord y

wxCoord
wxDC::LogicalToDeviceYRel( y )
    wxCoord y

wxCoord
wxDC::MaxX()

wxCoord
wxDC::MaxY()

wxCoord
wxDC::MinX()

wxCoord
wxDC::MinY()

bool
wxDC::Ok()

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

bool
wxDC::IsOk()

#endif

void
wxDC::ResetBoundingBox()

void
wxDC::SetAxisOrientation( xLeftRight, yBottomUp )
    bool xLeftRight
    bool yBottomUp

int
wxDC::GetDepth()

wxPoint*
wxDC::GetDeviceOrigin()
  CODE:
    RETVAL = new wxPoint( THIS->GetDeviceOrigin() );
  OUTPUT: RETVAL

void
wxDC::SetDeviceOrigin( x, y )
    wxCoord x
    wxCoord y

void
wxDC::SetBackground( brush )
    wxBrush* brush
  CODE:
    THIS->SetBackground( *brush );

void
wxDC::SetBackgroundMode( mode )
    int mode

void
wxDC::SetBrush( brush )
    wxBrush* brush
  CODE:
    THIS->SetBrush( *brush );

void
wxDC::SetClippingRegion( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, SetClippingRegionXYWH )
        MATCH_REDISP( wxPliOvl_wreg, SetClippingRegionRegion )
    END_OVERLOAD( Wx::DC::SetClippingRegion )

void
wxDC::SetClippingRegionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    THIS->SetClippingRegion( x, y, w, h );

void
wxDC::SetClippingRegionRegion( region )
    wxRegion* region
  CODE:
    THIS->SetClippingRegion( *region );

void
wxDC::SetFont( font )
    wxFont* font
  CODE:
    THIS->SetFont( *font );

void
wxDC::SetLogicalFunction( function )
    int function

void
wxDC::SetMapMode( mode )
    int mode

#if !defined( __WXMAC__ ) && WXPERL_W_VERSION_LE( 2, 5, 3 )

void
wxDC::SetOptimization( optimize )
    bool optimize

#endif 

void
wxDC::SetPalette( palette )
    wxPalette* palette
  CODE:
    THIS->SetPalette( *palette );

void
wxDC::SetPen( pen )
    wxPen* pen
  CODE:
    THIS->SetPen( *pen );

void
wxDC::SetTextBackground( colour )
    wxColour* colour
  CODE:
    THIS->SetTextBackground( *colour );

void
wxDC::SetTextForeground( colour )
    wxColour* colour
  CODE:
    THIS->SetTextForeground( *colour );

void
wxDC::SetUserScale( xScale, yScale )
    double xScale
    double yScale

bool
wxDC::StartDoc( message )
    wxString message

void
wxDC::StartPage()

void
wxDC::GetLogicalScale()
  PREINIT:
    double x, y;
  PPCODE:
    THIS->GetLogicalScale( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );

void
wxDC::SetLogicalScale( double x, double y );

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxLayoutDirection
wxDC::GetLayoutDirection()

void
wxDC::SetLayoutDirection( wxLayoutDirection dir )

#endif

MODULE=Wx PACKAGE=Wx::ScreenDC

wxScreenDC*
wxScreenDC::new()

bool
wxScreenDC::EndDrawingOnTop()

void
wxScreenDC::StartDrawingOnTop( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin, StartDrawingOnTopWindow )
        MATCH_REDISP( wxPliOvl_wrec, StartDrawingOnTopRect )
    END_OVERLOAD( Wx::ScreenDC::StartDrawingOnTop )

bool
wxScreenDC::StartDrawingOnTopWindow( window )
    wxWindow* window
  CODE:
    RETVAL = THIS->StartDrawingOnTop( window );
  OUTPUT:
    RETVAL

bool
wxScreenDC::StartDrawingOnTopRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->StartDrawingOnTop( rect );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::WindowDC

wxWindowDC*
wxWindowDC::new( window )
    wxWindow* window

MODULE=Wx PACKAGE=Wx::PaintDC

wxPaintDC*
wxPaintDC::new( window )
    wxWindow* window

MODULE=Wx PACKAGE=Wx::MemoryDC

wxMemoryDC*
wxMemoryDC::new()

void
wxMemoryDC::SelectObject( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

void
wxMemoryDC::SelectObjectAsSource( bitmap )
    wxBitmap* bitmap
  C_ARGS: *bitmap

#endif

MODULE=Wx PACKAGE=Wx::ClientDC

wxClientDC*
wxClientDC::new( window )
    wxWindow* window

%}

%module{Wx};

%typemap{wxBufferedDC*}{simple};
%typemap{wxBufferedPaintDC*}{simple};
%typemap{wxAutoBufferedPaintDC*}{simple};

%name{Wx::BufferedDC} class wxBufferedDC
{
    %name{newDefault} wxBufferedDC();
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
    %name{newBitmap} wxBufferedDC( wxDC *dc,
                                   const wxBitmap &buffer = wxNullBitmapPtr,
                                   int style = wxBUFFER_CLIENT_AREA );
    %name{newSize} wxBufferedDC( wxDC *dc, const wxSize &area,
                                 int style = wxBUFFER_CLIENT_AREA );
    %name{InitBitmap} void Init( wxDC *dc,
                                 const wxBitmap &buffer = wxNullBitmapPtr,
                                 int style = wxBUFFER_CLIENT_AREA );
    %name{InitSize} void Init( wxDC *dc, const wxSize &area,
                               int style = wxBUFFER_CLIENT_AREA );
#else
    %name{newBitmap} wxBufferedDC( wxDC *dc,
                                   const wxBitmap &buffer = wxNullBitmapPtr );
    %name{newSize} wxBufferedDC( wxDC *dc, const wxSize &area );
    %name{InitBitmap} void Init( wxDC *dc,
                                 const wxBitmap &buffer = wxNullBitmapPtr );
    %name{InitSize} void Init( wxDC *dc, const wxSize &area );
#endif

%{
void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wdc_wsiz_n, newSize, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wdc_wbmp_n, newBitmap, 1 )
    END_OVERLOAD( "Wx::BufferedDC::new" )

void
Init( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wdc_wsiz_n, InitSize, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wdc_wbmp_n, InitBitmap, 1 )
    END_OVERLOAD( "Wx::BufferedDC::Init" )
%}
    void UnMask();

#if WXPERL_W_VERSION_GE( 2, 6, 0 )
    void SetStyle( int style );
    int GetStyle();
#endif
};

%name{Wx::BufferedPaintDC} class wxBufferedPaintDC
{
#if WXPERL_W_VERSION_GE( 2, 5, 5 )
    %name{newBitmap} wxBufferedPaintDC( wxWindow* window,
                                        const wxBitmap& buffer,
                                        int style = wxBUFFER_CLIENT_AREA );
    %name{newWindow} wxBufferedPaintDC( wxWindow* window,
                                        int style = wxBUFFER_CLIENT_AREA );
#else
    %name{newBitmap} wxBufferedPaintDC( wxWindow* window,
                                        const wxBitmap& buffer );
    %name{newWindow} wxBufferedPaintDC( wxWindow* window );
#endif
%{
void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wdc_wbmp_n, newBitmap, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wdc_n, newBitmap, 1 )
    END_OVERLOAD( "Wx::BufferedPaintDC::new" )
%}
};

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

%name{Wx::AutoBufferedPaintDC} class wxAutoBufferedPaintDC
{
    wxAutoBufferedPaintDC( wxWindow* win );
};

%{
MODULE=Wx PACKAGE=Wx PREFIX=wx
%}

wxDC* wxAutoBufferedPaintDCFactory( wxWindow* window );

#endif
