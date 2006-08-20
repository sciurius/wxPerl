#############################################################################
## Name:        ext/html/XS/HtmlDCRenderer.xs
## Purpose:     XS for Wx::HtmlDCRenderer
## Author:      Mark Dootson
## Modified by:
## Created:     20/00/2006
## RCS-ID:      $Id: HtmlDCRenderer.xs,v 1.1 2006/08/20 09:25:20 mbarbon Exp $
## Copyright:   (c) 2006 Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/htmprint.h>
#include <wx/dc.h>

MODULE=Wx PACKAGE=Wx::HtmlDCRenderer

wxHtmlDCRenderer*
wxHtmlDCRenderer::new()

void
wxHtmlDCRenderer::DESTROY()

void
wxHtmlDCRenderer::SetDC( dc, pixel_scale = 1.0 )
    wxDC* dc
    double pixel_scale

void 
wxHtmlDCRenderer::SetSize(width, height)
    int width
    int height
    
void
wxHtmlDCRenderer::SetHtmlText( htmlText, basepath = wxEmptyString, isdir = 1 )
    wxString htmlText
    wxString basepath
    bool isdir
    
void
wxHtmlDCRenderer::SetFonts( normal_face, fixed_face, sizes )
    wxString normal_face
    wxString fixed_face
    SV* sizes
  PREINIT:
    int* array;
    int n = wxPli_av_2_intarray( aTHX_ sizes, &array );
  CODE:
    if( n != 7 )
    {
       delete[] array;
       croak( "Specified %d sizes, 7 wanted", n );
    }
    THIS->SetFonts( normal_face, fixed_face, array );
    delete[] array;        


#if WXPERL_W_VERSION_GE( 2, 7, 0 )

int 
wxHtmlDCRenderer::Render(x, y, pagebreaks, from = 0, dont_render = 0, to = INT_MAX)
    int x
    int y
    wxArrayInt pagebreaks
    int from
    int dont_render
    int to
    
#else

int 
wxHtmlDCRenderer::Render(x, y, from = 0, dont_render = 0, maxHeight = INT_MAX, pagebreaks, number_of_pages = 0)
    int x
    int y
    int from
    int dont_render
    int maxHeight
    SV* pagebreaks
    int number_of_pages
  PREINIT:
    int* array;
    int n = wxPli_av_2_intarray( aTHX_ pagebreaks, &array );
  CODE:
    RETVAL = THIS->Render( x, y, from, dont_render, maxHeight,
                           ( n == 0 ? NULL : array ), number_of_pages);
    delete[] array;
  OUTPUT: 
    RETVAL

#endif                        

int
wxHtmlDCRenderer::GetTotalHeight()
