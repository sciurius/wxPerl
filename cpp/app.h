/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/app.h
// Purpose:     c++ wrapper for wxApp
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: app.h,v 1.24 2005/01/23 13:43:01 mbarbon Exp $
// Copyright:   (c) 2000-2004 Mattia Barbon
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
    void CleanUp() { DeletePendingObjects( this ); wxApp::CleanUp(); }

#if defined( __WXMSW__ ) && !WXPERL_W_VERSION_GE( 2, 5, 0 )
    static void SetKeepGoing(wxPliApp* app, bool value)
    {
        app->m_keepGoing = value;
    }
#endif

    void DeletePendingObjects() {
        wxApp::DeletePendingObjects();
    }

    static void DeletePendingObjects(wxApp* app)
    {
        ((wxPliApp*) app)->DeletePendingObjects();
    }

    DEC_V_CBACK_INT__VOID( OnExit );
    DEC_V_CBACK_BOOL__BOOL( Yield );
};

inline wxPliApp::wxPliApp( const char* package )
    :m_callback( "Wx::App" ) 
{
    m_callback.SetSelf( wxPli_make_object( this, package ), true );
}

wxPliApp::~wxPliApp()
{
#ifdef __WXMOTIF__
    if (GetTopWindow())
    {
        delete GetTopWindow();
        SetTopWindow(NULL);
    }

    DeletePendingObjects();

    OnExit();
#endif
#if WXPERL_W_VERSION_LE( 2, 5, 1 )
    wxPli_delete_argv( (void***) &argv, 1 );

    argc = 0;
    argv = 0;
#endif
}

inline bool wxPliApp::OnInit() 
{
    wxApp::OnInit();

    return false;
}

inline int wxPliApp::MainLoop() {
    int retval = 0;
  
    DeletePendingObjects();
#if defined( __WXGTK__ ) && !WXPERL_W_VERSION_GE( 2, 5, 1 )
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
