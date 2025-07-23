#############################################################################
## Name:        ext/html/XS/HtmlDCRenderer.xs
## Purpose:     XS for Wx::HtmlDCRenderer
## Author:      Mark Dootson
## Modified by:
## Created:     20/00/2006
## RCS-ID:      $Id$
## Copyright:   (c) 2006, 2009 Mark Dootson
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/htmprint.h>
#include <wx/dc.h>

MODULE=Wx PACKAGE=Wx::HtmlDCRenderer

wxHtmlDCRenderer*
wxHtmlDCRenderer::new()

static void
wxHtmlDCRenderer::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxHtmlDCRenderer::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::HtmlDCRenderer", THIS, ST(0) );
    delete THIS;

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

void
wxHtmlDCRenderer::Render(x, y, from = 0, to = INT_MAX)
    int x
    int y
    int from
    int to

int
wxHtmlDCRenderer::GetTotalHeight()
