/////////////////////////////////////////////////////////////////////////////
// Name:        app.h
// Purpose:     c++ wrapper for wxApp
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: app.h,v 1.17 2003/08/17 19:34:40 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifdef Yield
#undef Yield
#endif

class wxPliApp:public wxApp
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliApp );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliApp( const char* package = "Wx::App" );
    ~wxPliApp();

    bool OnInit();
    int MainLoop();
    void CleanUp() { DeletePendingObjects(); wxApp::CleanUp(); }

    DEC_V_CBACK_INT__VOID( OnExit );
    DEC_V_CBACK_BOOL__BOOL( Yield );
};

inline wxPliApp::wxPliApp( const char* package )
    :m_callback( "Wx::App" ) 
{
    m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
}

wxPliApp::~wxPliApp()
{
#ifdef __WXMOTIF__
    if (wxTheApp->GetTopWindow())
    {
        delete wxTheApp->GetTopWindow();
        wxTheApp->SetTopWindow(NULL);
    }

    wxTheApp->DeletePendingObjects();

    wxTheApp->OnExit();
#endif
    wxPli_delete_argv( argv, 1 );

    argc = 0;
    argv = 0;
}

inline bool wxPliApp::OnInit() 
{
    wxApp::OnInit();

    return FALSE;
}

inline int wxPliApp::MainLoop() {
    int retval = 0;
  
    DeletePendingObjects();
#ifdef __WXGTK__
    m_initialized = wxTopLevelWindows.GetCount() != 0;
#endif

    if( Initialized() ) 
    {
        if( m_exitOnFrameDelete == Later )
            m_exitOnFrameDelete = Yes;
        retval = wxApp::MainLoop();
        OnExit();
    }

    return retval;
}

DEF_V_CBACK_INT__VOID( wxPliApp, wxApp, OnExit );
DEF_V_CBACK_BOOL__BOOL( wxPliApp, wxApp, Yield );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliApp, wxApp );

// Local variables: //
// mode: c++ //
// End: //
