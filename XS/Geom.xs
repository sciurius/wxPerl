#############################################################################
## Name:        Geom.xs
## Purpose:     XS for Wx::Point, Wx::Size, Wx::Rect, Wx::Region
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Size

Wx_Size*
Wx_Size::new( width = 0, height = 0 )
    int width
    int height

void
Wx_Size::DESTROY()

int
Wx_Size::width( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
Wx_Size::height( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

int
Wx_Size::GetHeight()

int
Wx_Size::GetWidth()

void
Wx_Size::Set( width, height )
    int width
    int height

void
Wx_Size::SetHeight( height )
    int height

void
Wx_Size::SetWidth( width )
    int width

MODULE=Wx PACKAGE=Wx::Point

Wx_Point*
Wx_Point::new( x = 0, y = 0 )
    int x
    int y

void
Wx_Point::DESTROY()

int
Wx_Point::x( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
Wx_Point::y( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::Rect

Wx_Rect*
newXYWH( x, y, width, height )
    int x
    int y
    int width
    int height
  CODE:
    RETVAL = new wxRect( x, y, width, height );
  OUTPUT:
    RETVAL

Wx_Rect*
newPP( tl, br )
    Wx_Point tl
    Wx_Point br
  CODE:
    RETVAL = new wxRect( tl, br );
  OUTPUT:
    RETVAL

Wx_Rect*
newPS( pos, size )
    Wx_Point pos
    Wx_Size size
  CODE:
    RETVAL = new wxRect( pos, size );
  OUTPUT:
    RETVAL

void
Wx_Rect::DESTROY()

int
Wx_Rect::x( ... )
  CODE:
    if( items > 1 )
      THIS->x = SvIV( ST(1) );
    RETVAL = THIS->x;
  OUTPUT:
    RETVAL

int
Wx_Rect::y( ... )
  CODE:
    if( items > 1 )
      THIS->y = SvIV( ST(1) );
    RETVAL = THIS->y;
  OUTPUT:
    RETVAL

int
Wx_Rect::width( ... )
  CODE:
    if( items > 1 )
      THIS->width = SvIV( ST(1) );
    RETVAL = THIS->width;
  OUTPUT:
    RETVAL

int
Wx_Rect::height( ... )
  CODE:
    if( items > 1 )
      THIS->height = SvIV( ST(1) );
    RETVAL = THIS->height;
  OUTPUT:
    RETVAL

int
Wx_Rect::GetBottom()

int
Wx_Rect::GetHeight()

int
Wx_Rect::GetLeft()

Wx_Point*
Wx_Rect::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

int
Wx_Rect::GetRight()

Wx_Size*
Wx_Rect::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

int
Wx_Rect::GetTop()

int
Wx_Rect::GetWidth()

int
Wx_Rect::GetX()

int
Wx_Rect::GetY()

void
Wx_Rect::Inflate( x, y )
    wxCoord x 
    wxCoord y = NO_INIT
  CODE:
    if( items == 2 )
      y = x;
    else
      y = SvIV( ST(2) );
    THIS->Inflate( x, y );

void
Wx_Rect::SetHeight( height )
    int height

void
Wx_Rect::SetWidth( width )
    int width

void
Wx_Rect::SetX( x )
    int x

void
Wx_Rect::SetY( y )
   int y

MODULE=Wx PACKAGE=Wx::Region

Wx_Region*
newXYWH( x, y, width, height )
    wxCoord x
    wxCoord y
    wxCoord width
    wxCoord height
  CODE:
    RETVAL = new wxRegion( x, y, width, height );
  OUTPUT:
    RETVAL

Wx_Region*
newPP( topLeft, bottomRight )
    Wx_Point topLeft
    Wx_Point bottomRight
  CODE:
    RETVAL = new wxRegion( topLeft, bottomRight );
  OUTPUT:
    RETVAL

Wx_Region*
newRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = new wxRegion( *rect );
  OUTPUT:
    RETVAL
 
void
Wx_Region::DESTROY()

void
Wx_Region::Clear()

wxRegionContain
Wx_Region::ContainsXY( x, y )
    wxCoord x
    wxCoord y
  CODE:
    RETVAL = THIS->Contains( x, y );
  OUTPUT:
    RETVAL

wxRegionContain
Wx_Region::ContainsPoint( point )
    Wx_Point point
  CODE:
    RETVAL = THIS->Contains( point );
  OUTPUT:
    RETVAL

wxRegionContain
Wx_Region::ContainsXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Contains( x, y, w, h );
  OUTPUT:
    RETVAL

wxRegionContain
Wx_Region::ContainsRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->Contains( *rect );
  OUTPUT:
    RETVAL

Wx_Rect*
Wx_Region::GetBox()
  CODE:
    RETVAL = new wxRect( THIS->GetBox() );
  OUTPUT:
    RETVAL

void
Wx_Region::GetBoxXYWH()
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
Wx_Region::IntersectXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Intersect( x, y, w, h );
  OUTPUT:
    RETVAL

bool
Wx_Region::IntersectRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->Intersect( *rect );
  OUTPUT:
    RETVAL

bool
Wx_Region::IntersectRegion( region )
    Wx_Region* region
  CODE:
    RETVAL = THIS->Intersect( *region );
  OUTPUT:
    RETVAL

bool
Wx_Region::IsEmpty()

bool
Wx_Region::SubtractRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->Subtract( *rect );
  OUTPUT:
    RETVAL

bool
Wx_Region::SubtractRegion( region )
    Wx_Region* region
  CODE:
    RETVAL = THIS->Subtract( *region );
  OUTPUT:
    RETVAL

bool
Wx_Region::UnionXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Union( x, y, w, h );
  OUTPUT:
    RETVAL

bool
Wx_Region::UnionRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->Union( *rect );
  OUTPUT:
    RETVAL

bool
Wx_Region::UnionRegion( region )
    Wx_Region* region
  CODE:
    RETVAL = THIS->Union( *region );
  OUTPUT:
    RETVAL

bool
Wx_Region::XorXYWH( x, y, w, h )
    wxCoord x
    wxCoord y
    wxCoord w
    wxCoord h
  CODE:
    RETVAL = THIS->Xor( x, y, w, h );
  OUTPUT:
    RETVAL

bool
Wx_Region::XorRect( rect )
    Wx_Rect* rect
  CODE:
    RETVAL = THIS->Xor( *rect );
  OUTPUT:
    RETVAL

bool
Wx_Region::XorRegion( region )
    Wx_Region* region
  CODE:
    RETVAL = THIS->Xor( *region );
  OUTPUT:
    RETVAL
