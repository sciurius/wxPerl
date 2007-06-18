#############################################################################
## Name:        ext/html/XS/HtmlWindow.xs
## Purpose:     XS for Wx::HtmlWindow
## Author:      Mattia Barbon
## Modified by:
## Created:     17/03/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%module{Wx};

%typemap{wxMouseEvent&}{reference};

%{
#include <wx/html/htmlwin.h>
#include <wx/frame.h>
#include "cpp/htmlwindow.h"
%}

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

%name{Wx::HtmlCellEvent} class wxHtmlCellEvent
{
    wxHtmlCell* GetCell() const;
    wxPoint GetPoint() const;
    wxMouseEvent& GetMouseEvent() const;

    void SetLinkClicked( bool linkclicked );
    bool GetLinkClicked() const;
};

%name{Wx::HtmlLinkEvent} class wxHtmlLinkEvent
{
    const wxHtmlLinkInfo& GetLinkInfo() const;
};

#endif

%{

MODULE=Wx PACKAGE=Wx::HtmlLinkInfo

wxMouseEvent*
wxHtmlLinkInfo::GetEvent()
  CODE:
    RETVAL = (wxMouseEvent*) THIS->GetEvent();
  OUTPUT:
    RETVAL

wxHtmlCell*
wxHtmlLinkInfo::GetHtmlCell()
  CODE:
    RETVAL = (wxHtmlCell*) THIS->GetHtmlCell();
  OUTPUT:
    RETVAL

wxString
wxHtmlLinkInfo::GetHref()

wxString
wxHtmlLinkInfo::GetTarget()

MODULE=Wx PACKAGE=Wx::HtmlWindow

wxHtmlWindow*
wxHtmlWindow::new( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, style = wxHW_SCROLLBAR_AUTO, name = wxT("htmlWindow") )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxPliHtmlWindow( CLASS, parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

bool
wxHtmlWindow::AppendToPage( source )
    wxString source

wxString
wxHtmlWindow::GetOpenedAnchor()

wxString
wxHtmlWindow::GetOpenedPage()

wxString
wxHtmlWindow::GetOpenedPageTitle()

wxHtmlWinParser*
wxHtmlWindow::GetParser()

wxFrame*
wxHtmlWindow::GetRelatedFrame()

bool
wxHtmlWindow::HistoryBack()

bool
wxHtmlWindow::HistoryCanForward()

bool
wxHtmlWindow::HistoryCanBack()

void
wxHtmlWindow::HistoryClear()

bool
wxHtmlWindow::HistoryForward()

bool
wxHtmlWindow::LoadFile( filename  )
    wxString filename

bool
wxHtmlWindow::LoadPage( location )
    wxString location

void
wxHtmlWindow::OnLinkClicked( info )
    wxHtmlLinkInfo* info
  CODE:
    THIS->wxHtmlWindow::OnLinkClicked( *info );

void
wxHtmlWindow::OnSetTitle( title )
    wxString title
  CODE:
    THIS->wxHtmlWindow::OnSetTitle( title );

void
wxHtmlWindow::ReadCustomization( cfg, path = wxEmptyString )
    wxConfigBase* cfg
    wxString path

void
wxHtmlWindow::SetBorders( b )
    int b

void
wxHtmlWindow::SetFonts( normal_face, fixed_face, sizes )
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

bool
wxHtmlWindow::SetPage( source )
    wxString source

void
wxHtmlWindow::SetRelatedFrame( frame, format )
    wxFrame* frame
    wxString format

void
wxHtmlWindow::SetRelatedStatusBar( bar )
    int bar

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxHtmlWindow::SelectWord( pos )
    wxPoint pos

void
wxHtmlWindow::SelectLine( pos )
    wxPoint pos

void
wxHtmlWindow::SelectAll()

wxString
wxHtmlWindow::SelectionToText()

wxString
wxHtmlWindow::ToText()

#endif

void
wxHtmlWindow::WriteCustomization( cfg, path = wxEmptyString )
    wxConfigBase* cfg
    wxString path

%}
