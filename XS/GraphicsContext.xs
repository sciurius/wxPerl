#############################################################################
## Name:        XS/GraphicsContext.xs
## Purpose:     XS for Wx::GraphicsContext
## Author:      Klaas Hartmann
## Modified by:
## Created:     29/06/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007, 2009 Klaas Hartmann
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxUSE_GRAPHICS_CONTEXT

#include <wx/graphics.h>
#include <wx/window.h>
#include "cpp/streams.h"
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::GraphicsContext

# DECLARE_OVERLOAD( wmdc, Wx::MemoryDC )
# DECLARE_OVERLOAD( wwdc, Wx::WindowDC )
# DECLARE_OVERLOAD( wpdc, Wx::PrinterDC )

void
Create ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP_FUNCTION( Wx::GraphicsContext::createMeasuringContext )
        MATCH_REDISP_FUNCTION(wxPliOvl_wwin, Wx::GraphicsContext::createFromWindow)
#if defined(__WXMSW__) || WXPERL_W_VERSION_GE( 2, 9, 0 )       
        MATCH_REDISP_FUNCTION(wxPliOvl_wmdc, Wx::GraphicsContext::createFromMemoryDC)
#endif     
#if wxPERL_USE_PRINTING_ARCHITECTURE && WXPERL_W_VERSION_GE( 2, 9, 0 )     
        MATCH_REDISP_FUNCTION(wxPliOvl_wpdc, Wx::GraphicsContext::createFromPrinterDC)
#endif  
        MATCH_REDISP_FUNCTION(wxPliOvl_wwdc, Wx::GraphicsContext::createFromWindowDC)
    END_OVERLOAD( "Wx::GraphicsContext::Create" )

wxGraphicsContext* 
createFromWindow ( window )
    wxWindow* window
  CODE:
    RETVAL = wxGraphicsContext::Create( window );
  OUTPUT: RETVAL

wxGraphicsContext* 
createFromWindowDC (dc )
    wxWindowDC* dc
  CODE:
    RETVAL = wxGraphicsContext::Create(*dc);
  OUTPUT: RETVAL

#if wxPERL_USE_PRINTING_ARCHITECTURE && WXPERL_W_VERSION_GE( 2, 9, 0 )

wxGraphicsContext* 
createFromPrinterDC (dc )
     wxPrinterDC* dc
  CODE:
    RETVAL = wxGraphicsContext::Create(*dc);
  OUTPUT: RETVAL

#endif

#if defined(__WXMSW__) || WXPERL_W_VERSION_GE( 2, 9, 0 )     

wxGraphicsContext* 
createFromMemoryDC (dc )
     wxMemoryDC* dc
  CODE:
    RETVAL = wxGraphicsContext::Create(*dc);
  OUTPUT: RETVAL

#endif

wxGraphicsContext* 
createMeasuringContext ()
  CODE:
    RETVAL = wxGraphicsContext::Create();
  OUTPUT: RETVAL

wxGraphicsPen*  
wxGraphicsContext::CreatePen ( pen )
    wxPen* pen
  CODE:
    RETVAL = new wxGraphicsPen( THIS->CreatePen(*pen) );
  OUTPUT: RETVAL

wxGraphicsBrush*
wxGraphicsContext::CreateBrush ( brush )
    wxBrush* brush
  CODE:
    RETVAL = new wxGraphicsBrush( THIS->CreateBrush(*brush) );
  OUTPUT: RETVAL

wxGraphicsBrush*
wxGraphicsContext::CreateRadialGradientBrush (xo,yo,xc,yc,radius,oColor, cColor)
    wxDouble xo
    wxDouble yo
    wxDouble xc
    wxDouble yc
    wxDouble radius
    wxColour* oColor
    wxColour* cColor
  CODE:
    RETVAL = new wxGraphicsBrush( THIS->CreateRadialGradientBrush(xo,yo,xc,yc,radius,*oColor,*cColor) );
  OUTPUT: RETVAL

wxGraphicsBrush*
wxGraphicsContext::CreateLinearGradientBrush (x1,y1,x2,y2,c1,c2)
    wxDouble x1
    wxDouble y1
    wxDouble x2
    wxDouble y2
    wxColour* c1
    wxColour* c2
  CODE:
    RETVAL = new wxGraphicsBrush( THIS->CreateLinearGradientBrush(x1,y1,x2,y2,*c1,*c2) );
  OUTPUT: RETVAL

wxGraphicsFont* 
wxGraphicsContext::CreateFont (font, col = (wxColour*)wxBLACK )
    wxFont* font
    wxColour* col
  CODE:
    RETVAL = new wxGraphicsFont( THIS->CreateFont(*font, *col) );
  OUTPUT: RETVAL

wxGraphicsMatrix* 
wxGraphicsContext::CreateMatrix ( a = 1.0, b = 0.0, c = 0.0, d = 1.0, tx = 0.0, ty = 0.0)
    wxDouble a
    wxDouble b
    wxDouble c
    wxDouble d
    wxDouble tx
    wxDouble ty
  CODE:
    RETVAL = new wxGraphicsMatrix( THIS->CreateMatrix(a,b,c,d,tx,ty) );
  OUTPUT: RETVAL

wxGraphicsPath* 
wxGraphicsContext::CreatePath ()
  CODE:
      RETVAL = new wxGraphicsPath( THIS->CreatePath() );
  OUTPUT: RETVAL

# DECLARE_OVERLOAD( wrgn, Wx::Region )

void
Clip ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP(wxPliOvl_n_n_n_n, ClipXYWH)
        MATCH_REDISP(wxPliOvl_wrgn, ClipRegion)
    END_OVERLOAD( "Wx::GraphicsContext::Clip" )

void
wxGraphicsContext::ClipXYWH (x, y, w, h)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h
  CODE:
    THIS->Clip (x, y, w, h);

void
wxGraphicsContext::ClipRegion (region)
    wxRegion* region
  CODE:
    THIS->Clip (*region);

void
wxGraphicsContext::ResetClip ()

void 
wxGraphicsContext::DrawBitmap (bitmap, x, y, w, h)
    wxBitmap* bitmap
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h
  CODE:
    THIS->DrawBitmap( *bitmap, x, y, w, h );

void 
wxGraphicsContext::DrawEllipse(x, y, w, h)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h

void 
wxGraphicsContext::DrawIcon(icon, x, y, w, h)
    wxIcon* icon
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h
  CODE:
    THIS->DrawIcon( *icon, x, y, w, h );

void
wxGraphicsContext::DrawLines ( points, fillStyle = wxODDEVEN_RULE )
    SV* points
    wxPolygonFillMode fillStyle
  CODE:
    wxPliArrayGuard<wxPoint2DDouble> newPoints;
    int n = wxPli_av_2_point2ddoublearray(aTHX_ points, newPoints.lvalue());
    THIS->DrawLines(n,newPoints);

void 
wxGraphicsContext::DrawPath (path, fillStyle = wxODDEVEN_RULE)
    wxGraphicsPath *path
    wxPolygonFillMode fillStyle
  CODE:
    THIS->DrawPath( *path, fillStyle );

void 
wxGraphicsContext::DrawRectangle (x, y, w, h)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h

void 
wxGraphicsContext::DrawRoundedRectangle (x, y, w, h, radius)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h
    wxDouble radius

void
wxGraphicsContext::DrawText ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
      MATCH_REDISP(wxPliOvl_s_n_n_n, DrawTextAngle)
      MATCH_REDISP(wxPliOvl_s_n_n, DrawTextNoAngle)
    END_OVERLOAD( "Wx::GraphicsContext::DrawText" )

void
wxGraphicsContext::DrawTextAngle ( string, x, y, angle )
    wxString string
    wxDouble x
    wxDouble y
    wxDouble angle
  CODE:
    THIS->DrawText(string,x,y,angle);

void
wxGraphicsContext::DrawTextNoAngle ( string, x, y )
    wxString string
    wxDouble x
    wxDouble y
  CODE:
    THIS->DrawText(string,x,y);

void
wxGraphicsContext::FillPath (path, fillStyle = wxODDEVEN_RULE)
    wxGraphicsPath *path
    wxPolygonFillMode fillStyle
  CODE:
    THIS->FillPath ( *path, fillStyle );

void
wxGraphicsContext::StrokePath ( path )
    wxGraphicsPath *path;
  CODE:
    THIS->StrokePath ( *path );

## Adapted from wxDC

void
wxGraphicsContext::GetTextExtent( string )
    wxString string
  PREINIT:
    wxDouble x, y, descent, externalLeading;
  PPCODE:
    THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading);
    EXTEND( SP, 4 );
    PUSHs( sv_2mortal( newSVnv( x ) ) );
    PUSHs( sv_2mortal( newSVnv( y ) ) );
    PUSHs( sv_2mortal( newSVnv( descent ) ) );
    PUSHs( sv_2mortal( newSVnv( externalLeading ) ) );

 # Adapted from wxDC

void
wxGraphicsContext::GetPartialTextExtents( string )
    wxString string
  PREINIT:
    wxArrayDouble widths;
  PPCODE:
    THIS->GetPartialTextExtents( string, widths );
    PUTBACK;
    wxPli_doublearray_push( aTHX_ widths );
    SPAGAIN;

void
wxGraphicsContext::Rotate ( angle )
    wxDouble angle

void
wxGraphicsContext::Scale ( x, y )
    wxDouble x
    wxDouble y

void 
wxGraphicsContext::Translate ( x, y )
    wxDouble x
    wxDouble y

wxGraphicsMatrix*
wxGraphicsContext::GetTransform ()
  CODE:
    RETVAL = new wxGraphicsMatrix( THIS->GetTransform() );
  OUTPUT: RETVAL

void 
wxGraphicsContext::SetTransform (matrix)
    wxGraphicsMatrix* matrix
  CODE:
    THIS->SetTransform(*matrix);

void
wxGraphicsContext::ConcatTransform (matrix)
    wxGraphicsMatrix* matrix
  CODE:
    THIS->ConcatTransform(*matrix);

# DECLARE_OVERLOAD( wbru, Wx::Brush )
# DECLARE_OVERLOAD( wgbr, Wx::GraphicsBrush )
# DECLARE_OVERLOAD( wfon, Wx::Font )
# DECLARE_OVERLOAD( wgfo, Wx::GraphicsFont )
# DECLARE_OVERLOAD( wpen, Wx::Pen )
# DECLARE_OVERLOAD( wgpe, Wx::GraphicsPen )
# DECLARE_OVERLOAD( wcol, Wx::Colour )

void
SetBrush ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP(wxPliOvl_wbru, SetBrushBrush)
        MATCH_REDISP(wxPliOvl_wgbr, SetBrushGraphics)
    END_OVERLOAD( "Wx::GraphicsContext::SetBrush" )

void
wxGraphicsContext::SetBrushBrush (brush)
    wxBrush* brush
  CODE:
    THIS->SetBrush( *brush );

void
wxGraphicsContext::SetBrushGraphics (brush)
    wxGraphicsBrush* brush
  CODE:
    THIS->SetBrush( *brush );

void
SetFont ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP(wxPliOvl_wfon_wcol, SetFontFont)
        MATCH_REDISP(wxPliOvl_wgfo, SetFontGraphics)
    END_OVERLOAD( "Wx::GraphicsContext::SetFont" )

void 
wxGraphicsContext::SetFontFont (font, colour)
    wxFont* font
    wxColour* colour
  CODE:
    THIS->SetFont(*font, *colour);

void 
wxGraphicsContext::SetFontGraphics (font)
    wxGraphicsFont* font
  CODE:
    THIS->SetFont(*font);

void
SetPen ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP(wxPliOvl_wpen, SetPenPen)
        MATCH_REDISP(wxPliOvl_wgpe, SetPenGraphics)
    END_OVERLOAD( "Wx::GraphicsContext::SetPen" )

void
wxGraphicsContext::SetPenPen (pen)
    wxPen* pen
  CODE:
    THIS->SetPen( *pen );

void
wxGraphicsContext::SetPenGraphics (pen)
    wxGraphicsPen* pen
  CODE:
    THIS->SetPen( *pen );

void
wxGraphicsContext::StrokeLine (x1,y1,x2,y2)
    wxDouble x1
    wxDouble y1
    wxDouble x2
    wxDouble y2

##Used wpoi's for overload checking as opposed to arr's 
##We want array references (which wpoi matches) but arr
##causes some problems...

void
wxGraphicsContext::StrokeLines ( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP(wxPliOvl_wpoi_wpoi, StrokeLinesTwo)
        MATCH_REDISP(wxPliOvl_wpoi, StrokeLinesOne)
    END_OVERLOAD( "Wx::GraphicsContext::StrokeLines" )


void
wxGraphicsContext::StrokeLinesOne ( points )
    SV* points
  CODE:
    wxPliArrayGuard<wxPoint2DDouble> points2d;
    int n = wxPli_av_2_point2ddoublearray(aTHX_ points, points2d.lvalue());
    THIS->StrokeLines(n,points2d);


void
wxGraphicsContext::StrokeLinesTwo ( beginPoints, endPoints )
    SV* beginPoints
    SV* endPoints
  CODE:
    wxPliArrayGuard<wxPoint2DDouble> beginPoints2d, endPoints2d;
    int n1 = wxPli_av_2_point2ddoublearray(aTHX_ beginPoints, beginPoints2d.lvalue());
    int n2 = wxPli_av_2_point2ddoublearray(aTHX_ endPoints, endPoints2d.lvalue());
    THIS->StrokeLines(wxMin(n1, n2), beginPoints2d, endPoints2d);

#endif
