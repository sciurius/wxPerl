#############################################################################
## Name:        ext/print/XS/Preview.xs
## Purpose:     XS for Wx::PreviewCanvas, Frame & ControlBar
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id: Preview.xs,v 1.12 2006/09/24 17:15:59 mbarbon Exp $
## Copyright:   (c) 2001-2002, 2004-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%module{Wx};

%typemap{wxPreviewControlBar*}{simple};
%typemap{wxPlPreviewControlBar*}{simple};
%typemap{wxPreviewFrame*}{simple};
%typemap{wxPlPreviewFrame*}{simple};
%typemap{wxPrintPreviewBase*}{simple};
%typemap{wxPrintPreview*}{simple};
%typemap{wxPreviewCanvas*}{simple};

#include <wx/print.h>

%file{cpp/previewcontrolbar.h};
%{
#include "cpp/v_cback.h"

// void METH(int)
#define DEC_V_CBACK_VOID__INT_( METHOD, CONST ) \
    void METHOD( int ) CONST

#define DEF_V_CBACK_VOID__INT_( CLASS, CALLBASE, METHOD, CONST )\
    void CLASS::METHOD( int p1 ) CONST                                       \
    {                                                                        \
        dTHX;                                                                \
        if( wxPliFCback( aTHX_ &m_callback, #METHOD ) )                      \
        {                                                                    \
            wxPliCCback( aTHX_ &m_callback, G_SCALAR|G_DISCARD, "i", p1 );   \
        } else                                                               \
            CALLBASE;                                                        \
    }

#define DEC_V_CBACK_VOID__INT( METHOD ) \
    DEC_V_CBACK_VOID__INT_( METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_( CLASS, BASE::METHOD(p1), METHOD, wxPli_NOCONST )

#define DEF_V_CBACK_VOID__INT_pure( CLASS, BASE, METHOD ) \
    DEF_V_CBACK_VOID__INT_( CLASS, return, METHOD, wxPli_NOCONST )

class wxPlPreviewControlBar : public wxPreviewControlBar
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlPreviewControlBar );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlPreviewControlBar( const char* package, wxPrintPreviewBase *preview,
                           long buttons, wxWindow *parent,
                           const wxPoint& pos = wxDefaultPosition,
                           const wxSize& size = wxDefaultSize,
                           long style = wxTAB_TRAVERSAL,
                           const wxString& name = wxPanelNameStr )
        : wxPreviewControlBar( preview, buttons, parent, pos, size,
                               style, name ),
          m_callback( "Wx::PlPreviewControlBar" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    DEC_V_CBACK_VOID__VOID( CreateButtons );
    DEC_V_CBACK_VOID__INT( SetZoomControl );
    DEC_V_CBACK_INT__VOID( GetZoomControl );

    wxButton* GetCloseButton()        { return m_closeButton; }
    wxButton* GetNextPageButton()     { return m_nextPageButton; }
    wxButton* GetPreviousPageButton() { return m_previousPageButton; }
    wxButton* GetPrintButton()        { return m_printButton; }
    wxButton* GetFirstPageButton()    { return m_firstPageButton; }
    wxButton* GetLastPageButton()     { return m_lastPageButton; }
    wxButton* GetGotoPageButton()     { return m_gotoPageButton; }
    wxChoice* GetZoomChoice()         { return m_zoomControl; }
    long      GetButtonFlags()        { return m_buttonFlags; }

    void SetCloseButton( wxButton* b )        { m_closeButton = b; }
    void SetNextPageButton( wxButton* b )     { m_nextPageButton = b; }
    void SetPreviousPageButton( wxButton* b ) { m_previousPageButton = b; }
    void SetPrintButton( wxButton* b )        { m_printButton = b; }
    void SetFirstPageButton( wxButton* b )    { m_firstPageButton = b; }
    void SetLastPageButton( wxButton* b )     { m_lastPageButton = b; }
    void SetGotoPageButton( wxButton* b )     { m_gotoPageButton = b; }
    void SetZoomChoice( wxChoice * c )        { m_zoomControl = c; }
    void SetButtonFlags( long f )             { m_buttonFlags = f; }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlPreviewControlBar, wxPreviewControlBar );

DEF_V_CBACK_VOID__VOID( wxPlPreviewControlBar, wxPreviewControlBar, CreateButtons );
DEF_V_CBACK_VOID__INT( wxPlPreviewControlBar, wxPreviewControlBar, SetZoomControl );
DEF_V_CBACK_INT__VOID( wxPlPreviewControlBar, wxPreviewControlBar, GetZoomControl );

%}
%file{-};

%file{cpp/previewframe.h};
%{
#include "cpp/v_cback.h"

class wxPlPreviewFrame : public wxPreviewFrame
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlPreviewFrame );
    WXPLI_DECLARE_V_CBACK();
public: 
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxPlPreviewFrame( const char* package, wxPrintPreviewBase *preview,
                      wxWindow *parent,
                      const wxString& title = wxT("Print Preview"),
                      const wxPoint& pos = wxDefaultPosition,
                      const wxSize& size = wxDefaultSize,
                      long style = wxDEFAULT_FRAME_STYLE,
                      const wxString& name = wxFrameNameStr )
        : wxPreviewFrame( preview, parent, title, pos, size, style, name ),
          m_callback( "Wx::PlPreviewFrame" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }
#else
    wxPlPreviewFrame( const char* package, wxPrintPreviewBase *preview,
                      wxFrame *parent,
                      const wxString& title = wxT("Print Preview"),
                      const wxPoint& pos = wxDefaultPosition,
                      const wxSize& size = wxDefaultSize,
                      long style = wxDEFAULT_FRAME_STYLE,
                      const wxString& name = wxFrameNameStr )
        : wxPreviewFrame( preview, parent, title, pos, size, style, name ),
          m_callback( "Wx::PlPreviewFrame" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxPreviewCanvas*     GetPreviewCanvas()     { return m_previewCanvas; }
#else
    wxWindow*            GetPreviewCanvas()     { return m_previewCanvas; }
#endif
    wxPreviewControlBar* GetPreviewControlBar() { return m_controlBar; }
    wxPrintPreviewBase*  GetPrintPreview()      { return m_printPreview; }

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    void SetPreviewCanvas( wxPreviewCanvas* p )       { m_previewCanvas = p; }
#else
    void SetPreviewCanvas( wxWindow* p )              { m_previewCanvas = p; }
#endif
    void SetPreviewControlBar( wxPreviewControlBar* p ) { m_controlBar = p; }
    void SetPrintPreview( wxPrintPreviewBase* p )       { m_printPreview = p; }

    DEC_V_CBACK_VOID__VOID( Initialize );
    DEC_V_CBACK_VOID__VOID( CreateCanvas );
    DEC_V_CBACK_VOID__VOID( CreateControlBar );
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlPreviewFrame, wxPreviewFrame );

DEF_V_CBACK_VOID__VOID( wxPlPreviewFrame, wxPreviewFrame, Initialize );
DEF_V_CBACK_VOID__VOID( wxPlPreviewFrame, wxPreviewFrame, CreateCanvas );
DEF_V_CBACK_VOID__VOID( wxPlPreviewFrame, wxPreviewFrame, CreateControlBar );
%}
%file{-};

#include "cpp/previewframe.h"
#include "cpp/previewcontrolbar.h"

%name{Wx::PreviewControlBar} class wxPreviewControlBar
{
    wxPreviewControlBar( wxPrintPreview* preview, long buttons,
                         wxWindow* parent, wxPoint pos = wxDefaultPosition,
                         wxSize size = wxDefaultSize,
                         long style = wxTAB_TRAVERSAL,
                         wxString name = wxPanelNameStr );

    void CreateButtons();
    wxPrintPreviewBase* GetPrintPreview();
    int GetZoomControl();
    void SetZoomControl( int zoom );

    void OnNext();
    void OnPrevious();
    void OnFirst();
    void OnLast();
    void OnGoto();
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    void OnPrint();
#endif
};

%{
#define CreateButtons wxPreviewControlBar::CreateButtons
%}

%name{Wx::PlPreviewControlBar} class wxPlPreviewControlBar
{
    wxPlPreviewControlBar( wxPrintPreview* preview, long buttons,
                           wxWindow* parent,
                           wxPoint pos = wxDefaultPosition,
                           wxSize size = wxDefaultSize,
                           long style = wxTAB_TRAVERSAL,
                           wxString name = wxPanelNameStr )
        %code{% RETVAL = new wxPlPreviewControlBar
                    ( CLASS, preview, buttons, parent, pos, size,
                      style, name );
             %};

    void CreateButtons();
};

%{
#undef CreateButtons
%}

%name{Wx::PreviewFrame} class wxPreviewFrame
{
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxPreviewFrame( wxPrintPreview* preview, wxWindow* parent,
                    wxString title, wxPoint pos = wxDefaultPosition,
                    wxSize size = wxDefaultSize,
                    long style = wxDEFAULT_FRAME_STYLE,
                    wxString name = wxFrameNameStr );
#else
    wxPreviewFrame( wxPrintPreview* preview, wxFrame* parent,
                    wxString title, wxPoint pos = wxDefaultPosition,
                    wxSize size = wxDefaultSize,
                    long style = wxDEFAULT_FRAME_STYLE,
                    wxString name = wxFrameNameStr );
#endif

    void Initialize();
    void CreateCanvas();
    void CreateControlBar();

#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    wxPreviewControlBar* GetControlBar() const;
#endif
};

%{
#define Initialize wxPreviewFrame::Initialize
#define CreateCanvas wxPreviewFrame::CreateCanvas
#define CreateControlBar wxPreviewFrame::CreateControlBar
%}

%name{Wx::PlPreviewFrame} class wxPlPreviewFrame
{
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxPlPreviewFrame( wxPrintPreview* preview, wxWindow* parent,
                      wxString title, wxPoint pos = wxDefaultPosition,
                      wxSize size = wxDefaultSize,
                      long style = wxDEFAULT_FRAME_STYLE,
                      wxString name = wxFrameNameStr )
        %code{% RETVAL = new wxPlPreviewFrame
                    ( CLASS, preview, parent, title, pos, size, style, name );
             %};
#else
    wxPlPreviewFrame( wxPrintPreview* preview, wxFrame* parent,
                      wxString title, wxPoint pos = wxDefaultPosition,
                      wxSize size = wxDefaultSize,
                      long style = wxDEFAULT_FRAME_STYLE,
                      wxString name = wxFrameNameStr )
        %code{% RETVAL = new wxPlPreviewFrame
                    ( CLASS, preview, parent, title, pos, size, style, name );
             %};
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxPreviewCanvas*     GetPreviewCanvas();
#else
    wxWindow*            GetPreviewCanvas();
#endif
    wxPreviewControlBar* GetPreviewControlBar();
    wxPrintPreviewBase*  GetPrintPreview();

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    void SetPreviewCanvas( wxPreviewCanvas* p );
#else
    void SetPreviewCanvas( wxWindow* p );
#endif
    void SetPreviewControlBar( wxPreviewControlBar* p );
    void SetPrintPreview( wxPrintPreviewBase* p );

    void Initialize();
    void CreateCanvas();
    void CreateControlBar();
};

%{
#undef Initialize
#undef CreateCanvas
#undef CreateControlBar
%}

%{
MODULE=Wx PACKAGE=Wx::PreviewCanvas

wxPreviewCanvas*
wxPreviewCanvas::new( preview, parent, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxT("canvas") )
    wxPrintPreview* preview
    wxWindow* parent
    wxPoint pos
    wxSize size
    long style
    wxString name
%}
