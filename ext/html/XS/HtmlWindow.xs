#############################################################################
## Name:        HtmlWindow.xs
## Purpose:     XS for Wx::HtmlWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     17/ 3/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/html/htmlwin.h>
#include <wx/frame.h>
#include "cpp/htmlwindow.h"

MODULE=Wx PACKAGE=Wx::HtmlLinkInfo

Wx_MouseEvent*
Wx_HtmlLinkInfo::GetEvent()
  CODE:
    RETVAL = (Wx_MouseEvent*) THIS->GetEvent();
  OUTPUT:
    RETVAL

Wx_HtmlCell*
Wx_HtmlLinkInfo::GetHtmlCell()
  CODE:
    RETVAL = (Wx_HtmlCell*) THIS->GetHtmlCell();
  OUTPUT:
    RETVAL

wxString
Wx_HtmlLinkInfo::GetHref()

wxString
Wx_HtmlLinkInfo::GetTarget()

MODULE=Wx__Html PACKAGE=Wx::HtmlWindow

Wx_HtmlWindow*
Wx_HtmlWindow::new( parent, id = -1, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHW_SCROLLBAR_AUTO, name = "htmlWindow" )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliHtmlWindow( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

wxString
Wx_HtmlWindow::GetOpenedAnchor()

wxString
Wx_HtmlWindow::GetOpenedPage()

wxString
Wx_HtmlWindow::GetOpenedPageTitle()

Wx_Frame*
Wx_HtmlWindow::GetRelatedFrame()

bool
Wx_HtmlWindow::HistoryBack()

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

bool
Wx_HtmlWindow::HistoryCanForward()

bool
Wx_HtmlWindow::HistoryCanBack()

#endif

void
Wx_HtmlWindow::HistoryClear()

bool
Wx_HtmlWindow::HistoryForward()

bool
Wx_HtmlWindow::LoadPage( location )
    wxString location

void
Wx_HtmlWindow::OnLinkClicked( info )
    Wx_HtmlLinkInfo* info
  CODE:
    THIS->wxHtmlWindow::OnLinkClicked( *info );

void
Wx_HtmlWindow::OnSetTitle( title )
    wxString title
  CODE:
    THIS->wxHtmlWindow::OnSetTitle( title );

void
Wx_HtmlWindow::ReadCustomization( cfg, path = wxEmptyString )
    Wx_ConfigBase* cfg
    wxString path

void
Wx_HtmlWindow::SetBorders( b )
    int b

void
Wx_HtmlWindow::SetFonts( normal_face, fixed_face, sizes )
    wxString normal_face
    wxString fixed_face
    SV* sizes
  PREINIT:
    int* array;
    int n = wxPli_av_2_intarray( sizes, &array );
  CODE:
    if( n != 7 )
    {
       delete[] array;
       croak( "Specified %s sizes, 7 wanted", n );
    }
    THIS->SetFonts( normal_face, fixed_face, array );
    delete[] sizes;

bool
Wx_HtmlWindow::SetPage( source )
    wxString source

void
Wx_HtmlWindow::SetRelatedFrame( frame, format )
    Wx_Frame* frame
    wxString format

void
Wx_HtmlWindow::SetRelatedStatusBar( bar )
    int bar

void
Wx_HtmlWindow::WriteCustomization( cfg, path = wxEmptyString )
    Wx_ConfigBase* cfg
    wxString path
