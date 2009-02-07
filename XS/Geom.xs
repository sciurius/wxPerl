#############################################################################
## Name:        XS/Geom.xs
## Purpose:     XS for Wx::Point, Wx::Size, Wx::Rect, Wx::Region
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2003, 2006-2009 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Size

wxSize*
wxSize::new( width = 0, height = 0 )
    int width
    int height

static void
wxSize::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxSize::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Size", THIS, ST(0) );
    delete THIS;

int
wxSize::width( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
wxSize::height( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

int
wxSize::GetHeight()

int
wxSize::GetWidth()

void
wxSize::Set( width, height )
    int width
    int height

void
wxSize::SetHeight( height )
    int height

void
wxSize::SetWidth( width )
    int width

void
wxSize::IncTo( size )
    wxSize size

void
wxSize::DecTo( size )
    wxSize size

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

SV*
wxSize::Scale( xscale, yscale )
    float xscale
    float yscale
  CODE:
    THIS->Scale( xscale, yscale );
    RETVAL = ST(0);
  OUTPUT: RETVAL

#endif

bool
wxSize::IsFullySpecified()

void
wxSize::SetDefaults( size )
    wxSize size

MODULE=Wx PACKAGE=Wx::Point

wxPoint*
wxPoint::new( x = 0, y = 0 )
    int x
    int y

static void
wxPoint::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxPoint::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Point", THIS, ST(0) );
    delete THIS;

int
wxPoint::x( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
wxPoint::y( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::Rect

void
wxRect::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, newXYWH )
        MATCH_REDISP( wxPliOvl_wpoi_wsiz, newPS )
        MATCH_REDISP( wxPliOvl_wpoi_wpoi, newPP )
    END_OVERLOAD( Wx::Rect::new )

wxRect*
newXYWH( CLASS, x, y, width, height )
    SV* CLASS
    int x
    int y
    int width
    int height
  CODE:
    RETVAL = new wxRect( x, y, width, height );
  OUTPUT:
    RETVAL

wxRect*
newPP( CLASS, tl, br )
    SV* CLASS
    wxPoint tl
    wxPoint br
  CODE:
    RETVAL = new wxRect( tl, br );
  OUTPUT:
    RETVAL

wxRect*
newPS( CLASS, pos, size )
    SV* CLASS
    wxPoint pos
    wxSize size
  CODE:
    RETVAL = new wxRect( pos, size );
  OUTPUT:
    RETVAL

static void
wxRect::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxRect::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Rect", THIS, ST(0) );
    delete THIS;

int
wxRect::x( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
wxRect::y( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

int
wxRect::width( ... )
  CODE:
    if( items > 1 )
      THIS->width = SvIV( ST(1) );
    RETVAL = THIS->width;
  OUTPUT:
    RETVAL

int
wxRect::height( ... )
  CODE:
    if( items > 1 )
      THIS->height = SvIV( ST(1) );
    RETVAL = THIS->height;
  OUTPUT:
    RETVAL

int
wxRect::GetBottom()

int
wxRect::GetHeight()

int
wxRect::GetLeft()

wxPoint*
wxRect::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL
    
wxPoint*
wxRect::GetTopLeft()
  CODE:
    RETVAL = new wxPoint( THIS->GetTopLeft() );
  OUTPUT:
    RETVAL
    
wxPoint*
wxRect::GetBottomRight()
  CODE:
    RETVAL = new wxPoint( THIS->GetBottomRight() );
  OUTPUT:
    RETVAL
    
#if WXPERL_W_VERSION_GE( 2, 8, 0 )

wxPoint*
wxRect::GetBottomLeft()
  CODE:
    RETVAL = new wxPoint( THIS->GetBottomLeft() );
  OUTPUT:
    RETVAL
    
wxPoint*
wxRect::GetTopRight()
  CODE:
    RETVAL = new wxPoint( THIS->GetTopRight() );
  OUTPUT:
    RETVAL

bool
wxRect::IsEmpty()

wxRect*
wxRect::Union( wxRect* rec )
  CODE:
    RETVAL = new wxRect( THIS->Union( *rec ) );
  OUTPUT:
    RETVAL

#endif    

int
wxRect::GetRight()

wxSize*
wxRect::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

int
wxRect::GetTop()

int
wxRect::GetWidth()

int
wxRect::GetX()

int
wxRect::GetY()

void
wxRect::Deflate( x, y )
    wxCoord x 
    wxCoord y = NO_INIT
  CODE:
    if( items == 2 )
      y = x;
    else
      y = SvIV( ST(2) );
    THIS->Deflate( x, y );

void
wxRect::Inflate( x, y )
    wxCoord x 
    wxCoord y = NO_INIT
  CODE:
    if( items == 2 )
      y = x;
    else
      y = SvIV( ST(2) );
    THIS->Inflate( x, y );

wxRect*
wxRect::Intersect( rect )
    wxRect* rect
  CODE:
    RETVAL = new wxRect( THIS->Intersect( *rect ) );
  OUTPUT: RETVAL

bool
wxRect::Intersects( wxRect* rec )
  CODE:
    RETVAL = THIS->Intersects( *rec );
  OUTPUT: RETVAL

void
wxRect::SetHeight( height )
    int height

void
wxRect::SetWidth( width )
    int width

void
wxRect::SetX( x )
    int x

void
wxRect::SetY( y )
   int y

void
wxRect::SetPosition( pos )
    wxPoint pos

void
wxRect::SetSize( size )
    wxSize size
    
void
wxRect::Offset( x, y )
    wxCoord x
    wxCoord y
 CODE:
   THIS->Offset( x, y);

void
wxRect::Contains( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, ContainsXY )
        MATCH_REDISP( wxPliOvl_wpoi, ContainsPoint )
        MATCH_REDISP( wxPliOvl_wrec, ContainsRect )
    END_OVERLOAD( Wx::Rect::Contains )

void
wxRect::Inside( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, ContainsXY )
        MATCH_REDISP( wxPliOvl_wpoi, ContainsPoint )
#if WXPERL_W_VERSION_GE( 2, 7, 0 )
        MATCH_REDISP( wxPliOvl_wrec, ContainsRect )
#endif
    END_OVERLOAD( Wx::Rect::Inside )

bool
wxRect::ContainsXY( int x, int y )
  CODE:
#if WXPERL_W_VERSION_GE( 2, 7, 1 )
    RETVAL = THIS->Contains( x, y );
#else
    RETVAL = THIS->Inside( x, y );
#endif
  OUTPUT: RETVAL

bool
wxRect::ContainsPoint( wxPoint pt )
  CODE:
#if WXPERL_W_VERSION_GE( 2, 7, 1 )
    RETVAL = THIS->Contains( pt );
#else
    RETVAL = THIS->Inside( pt );
#endif
  OUTPUT: RETVAL

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

bool
wxRect::ContainsRect( wxRect* rec )
  CODE:
    RETVAL = THIS->Contains( *rec );
  OUTPUT: RETVAL

wxRect*
wxRect::CentreIn ( wxRect* rec, int dir = wxBOTH )
  CODE:
    RETVAL = new wxRect( THIS->CentreIn( *rec, dir ) );
  OUTPUT:
    RETVAL
    
#endif

MODULE=Wx PACKAGE=Wx::Region

wxRegion*
newEmpty( CLASS )
    SV* CLASS
  CODE:
    RETVAL = new wxRegion();
  OUTPUT:
    RETVAL

wxRegion*
newXYWH( CLASS, x, y, width, height )
    SV* CLASS
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
  CODE:
    RETVAL = new wxRegion( x, y, width, height );
  OUTPUT:
    RETVAL

wxRegion*
newPP( CLASS, topLeft, bottomRight )
    SV* CLASS
    wxPoint topLeft
    wxPoint bottomRight
  CODE:
    RETVAL = new wxRegion( topLeft, bottomRight );
  OUTPUT:
    RETVAL

wxRegion*
newRect( CLASS, rect )
    SV* CLASS
    wxRect* rect
  CODE:
    RETVAL = new wxRegion( *rect );
  OUTPUT:
    RETVAL

#if !defined( __WXMAC__ ) && !defined( __WXMOTIF__ )

wxRegion*
newPolygon( CLASS, list, fillStyle = wxODDEVEN_RULE )
    SV* CLASS
    SV* list
    wxPolygonFillMode fillStyle
  PREINIT:
    wxPoint* points;
    size_t n;
  CODE:
    n = wxPli_av_2_pointarray( aTHX_ list, &points );
    RETVAL = new wxRegion( n, points, fillStyle );
    delete [] points;
  OUTPUT: RETVAL

#endif

#if !defined( __WXOSX_COCOA__ )

wxRegion*
newBitmap( CLASS, bitmap, colour, tolerance = 0 )
    SV* CLASS
    wxBitmap* bitmap
    wxColour colour
    int tolerance
  CODE: 
    RETVAL = new wxRegion( *bitmap, colour, tolerance );
  OUTPUT: RETVAL

wxRegion*
newBitmapOnly( CLASS, bitmap )
    SV* CLASS
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxRegion( *bitmap );
  OUTPUT: RETVAL

#endif

void
wxRegion::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newEmpty )
        MATCH_REDISP( wxPliOvl_n_n_n_n, newXYWH )
        MATCH_REDISP( wxPliOvl_wpoi_wpoi, newPP )
        MATCH_REDISP( wxPliOvl_wrec, newRect )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wbmp_wcol_n, newBitmap, 2 )
        MATCH_REDISP( wxPliOvl_wbmp, newBitmapOnly )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_arr, newPolygon, 1 )
    END_OVERLOAD( Wx::Region::new )

static void
wxRegion::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxRegion::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Region", THIS, ST(0) );
    delete THIS;

void
wxRegion::Clear()

wxRegionContain
wxRegion::ContainsXY( x, y )
    wxCoord x
    wxCoord y
  CODE:
    RETVAL = THIS->Contains( x, y );
  OUTPUT:
    RETVAL

wxRegionContain
wxRegion::ContainsPoint( point )
    wxPoint point
  CODE:
    RETVAL = THIS->Contains( point );
  OUTPUT:
    RETVAL

wxRegionContain
wxRegion::ContainsXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Contains( x, y, w, h );
  OUTPUT:
    RETVAL

wxRegionContain
wxRegion::ContainsRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Contains( *rect );
  OUTPUT:
    RETVAL

void
wxRegion::Contains( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, ContainsXYWH )
        MATCH_REDISP( wxPliOvl_n_n, ContainsXY )
        MATCH_REDISP( wxPliOvl_wpoi, ContainsPoint )
        MATCH_REDISP( wxPliOvl_wrec, ContainsRect )
    END_OVERLOAD( Wx::Region::Contains )

wxBitmap*
wxRegion::ConvertToBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->ConvertToBitmap() );
  OUTPUT: RETVAL

wxRect*
wxRegion::GetBox()
  CODE:
    RETVAL = new wxRect( THIS->GetBox() );
  OUTPUT:
    RETVAL

void
wxRegion::GetBoxXYWH()
  PREINIT:
    int x;
    int y;
    int w;
    int h;
  PPCODE:
    THIS->GetBox( x, y, w, h );
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSViv( (IV) x ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) y ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) w ) ) );
    PUSHs( sv_2mortal( newSViv( (IV) h ) ) );

bool
wxRegion::IntersectXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Intersect( x, y, w, h );
  OUTPUT:
    RETVAL

bool
wxRegion::IntersectRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Intersect( *rect );
  OUTPUT:
    RETVAL

bool
wxRegion::IntersectRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Intersect( *region );
  OUTPUT:
    RETVAL

void
wxRegion::Intersect( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, IntersectXYWH )
        MATCH_REDISP( wxPliOvl_wrec, IntersectRect )
        MATCH_REDISP( wxPliOvl_wreg, IntersectRegion )
    END_OVERLOAD( Wx::Region::Intersect )

bool
wxRegion::IsEmpty()

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
wxRegion::IsEqual( region )
    wxRegion* region
  C_ARGS: *region

#endif

bool
wxRegion::SubtractRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Subtract( *rect );
  OUTPUT:
    RETVAL

#if !defined(__WXMOTIF__) && !defined(__WXMAC__)

bool
wxRegion::Offset( x, y )
    wxCoord x
    wxCoord y

#endif

bool
wxRegion::SubtractRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Subtract( *region );
  OUTPUT:
    RETVAL

void
wxRegion::Subtract( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wrec, SubtractRect )
        MATCH_REDISP( wxPliOvl_wreg, SubtractRegion )
    END_OVERLOAD( Wx::Region::Subtract )

bool
wxRegion::UnionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Union( x, y, w, h );
  OUTPUT: RETVAL

bool
wxRegion::UnionRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Union( *rect );
  OUTPUT: RETVAL

bool
wxRegion::UnionRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Union( *region );
  OUTPUT: RETVAL

bool
wxRegion::UnionBitmapOnly( bitmap )
    wxBitmap* bitmap
  CODE:
    RETVAL = THIS->Union( *bitmap );
  OUTPUT: RETVAL

bool
wxRegion::UnionBitmap( bitmap, colour, tolerance = 0 )
    wxBitmap* bitmap
    wxColour colour
    int tolerance
  CODE:
    RETVAL = THIS->Union( *bitmap, colour, tolerance );
  OUTPUT: RETVAL

void
wxRegion::Union( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, UnionXYWH )
        MATCH_REDISP( wxPliOvl_wrec, UnionRect )
        MATCH_REDISP( wxPliOvl_wreg, UnionRegion )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wbmp_wcol_n, UnionBitmap, 2 )
        MATCH_REDISP( wxPliOvl_wbmp, UnionBitmapOnly )
    END_OVERLOAD( Wx::Region::Union )

bool
wxRegion::XorXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Xor( x, y, w, h );
  OUTPUT:
    RETVAL

bool
wxRegion::XorRect( rect )
    wxRect* rect
  CODE:
    RETVAL = THIS->Xor( *rect );
  OUTPUT:
    RETVAL

bool
wxRegion::XorRegion( region )
    wxRegion* region
  CODE:
    RETVAL = THIS->Xor( *region );
  OUTPUT:
    RETVAL

void
wxRegion::Xor( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n_n_n, XorXYWH )
        MATCH_REDISP( wxPliOvl_wrec, XorRect )
        MATCH_REDISP( wxPliOvl_wreg, XorRegion )
    END_OVERLOAD( Wx::Region::Xor )

MODULE=Wx PACKAGE=Wx::Position

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

#include <wx/position.h>

wxPosition*
wxPosition::new( row = 0, column = 0 )
    int row
    int column

static void
wxPosition::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxPosition::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Position", THIS, ST(0) );
    delete THIS;

int
wxPosition::row( ... )
  CODE:
    if( items > 1 )
      THIS->SetRow( SvIV( ST(1) ) );
    RETVAL = THIS->GetRow();
  OUTPUT:
    RETVAL

int
wxPosition::col( ... )
  CODE:
    if( items > 1 )
      THIS->SetCol( SvIV( ST(1) ) );
    RETVAL = THIS->GetCol();
  OUTPUT:
    RETVAL

int
wxPosition::column( ... )
  CODE:
    if( items > 1 )
      THIS->SetColumn( SvIV( ST(1) ) );
    RETVAL = THIS->GetColumn();
  OUTPUT:
    RETVAL

int
wxPosition::GetRow()

int
wxPosition::GetCol()

int
wxPosition::GetColumn()

void
wxPosition::SetRow( height )
    int height

void
wxPosition::SetCol( width )
    int width

void
wxPosition::SetColumn( width )
    int width

#endif
