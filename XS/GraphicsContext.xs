#############################################################################
## Name:        XS/GraphicsContext.xs
## Purpose:     XS for Wx::GraphicsContext
## Author:      Klaas Hartmann
## Modified by:
## Created:     29/06/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Klaas Hartmann
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxUSE_GRAPHICS_CONTEXT

#include <wx/graphics.h>
#include <wx/window.h>
#include "cpp/streams.h"
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::GraphicsContext


wxGraphicsContext* 
Create ( window )
    wxWindow* window
  CODE:
    RETVAL = wxGraphicsContext::Create( window );
  OUTPUT: RETVAL

##void
##Create ( ... )
##  PPCODE:
##    BEGIN_OVERLOAD()
##      MATCH_REDISP(wxPliOvl_wwin, CreateWindow)
##      MATCH_REDISP(wxPliOvl_wdc, CreateDC)
##    END_OVERLOAD( "Wx::GraphicsContext::Create" )
##      
##wxGraphicsContext* 
##CreateWindow ( parent )
##    wxWindow* parent
##  CODE:
##    printf("A!\n");
##    RETVAL = wxGraphicsContext::Create( parent );
##  OUTPUT: RETVAL
##      
##wxGraphicsContext* 
##CreateDC (dc )
##    wxWindowDC* dc
##  CODE:
##    printf("B!\n");
##    RETVAL = wxGraphicsContext::Create(*dc);
##  OUTPUT: RETVAL
        
wxGraphicsPen*  
wxGraphicsContext::CreatePen ( pen )
    wxPen* pen
  CODE:
    RETVAL = new wxGraphicsPen( THIS->CreatePen(*pen) );
  OUTPUT: RETVAL
 
wxGraphicsBrush*
wxGraphicsContext::CreateBrush ( brush )
    wxGraphicsBrush* brush
  CODE:
    RETVAL = new wxGraphicsBrush( *brush );
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
wxGraphicsContext::CreateFont (font, col = new wxColour(*wxBLACK) )
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
        
void
wxGraphicsContext::Clip (x, y, w, h)
    wxDouble x
    wxDouble y
    wxDouble w
    wxDouble h

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

 # wxGraphicsContext::DrawLines
 # void DrawLines(size_t n, const wxPoint2DDouble* points, int fillStyle = wxODDEVEN_RULE)
 
void 
wxGraphicsContext::DrawPath (path, fillStyle = wxODDEVEN_RULE)
    wxGraphicsPath *path
    int fillStyle
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
    int fillStyle
  CODE:
    THIS->FillPath ( *path, fillStyle );
 
void
wxGraphicsContext::StrokePath ( path )
    wxGraphicsPath *path;
  CODE:
    THIS->StrokePath ( *path );
 
 # Not to be implemented
 # wxGraphicsContext::GetNativeContext
 # void * GetNativeContext()
 
 # Pinched from wxDC

 # void
 # wxGraphicsContext::GetTextExtent( string )
 #     wxString string
 #   PREINIT:
 #     wxDouble x, y, descent, externalLeading;
 #   PPCODE:
 #     THIS->GetTextExtent( string, &x, &y, &descent, &externalLeading);
 #     EXTEND( SP, 4 );
 #     PUSHs( sv_2mortal( newSViv( x ) ) );
 #     PUSHs( sv_2mortal( newSViv( y ) ) );
 #     PUSHs( sv_2mortal( newSViv( descent ) ) );
 #     PUSHs( sv_2mortal( newSViv( externalLeading ) ) );

 # Pinched from wxDC

 # void
 # wxGraphicsContext::GetPartialTextExtents( string )
 #     wxString string
 #   PREINIT:
 #     wxArrayDouble widths;
 #   PPCODE:
 #     THIS->GetPartialTextExtents( string, widths );
 #     PUTBACK;
 #     wxPli_intarray_push( aTHX_ widths );
 #     SPAGAIN;

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
    
void
wxGraphicsContext::SetBrush (brush)
    wxBrush* brush
  CODE:
    THIS->SetBrush( *brush );
    
void 
wxGraphicsContext::SetFont (font, colour)    
    wxFont* font
    wxColour* colour
  CODE:
    THIS->SetFont(*font, *colour);
     
void
wxGraphicsContext::SetPen (pen)
    wxPen* pen
  CODE:
    THIS->SetPen( *pen );

void
wxGraphicsContext::StrokeLine (x1,y1,x2,y2)
    wxDouble x1
    wxDouble y1
    wxDouble x2
    wxDouble y2
    
 # Todo!
 # wxGraphicsContext::StrokeLines
 # void StrokeLines(size_t n, const wxPoint2DDouble* beginPoints, const wxPoint2DDouble* endPoints)
 # void StrokeLines(size_t n, const wxPoint2DDouble* points)     
    
#endif
