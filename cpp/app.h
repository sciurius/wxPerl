/////////////////////////////////////////////////////////////////////////////
// Name:        app.h
// Purpose:     c++ wrapper for wxApp
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: app.h,v 1.14 2003/04/22 19:25:50 mbarbon Exp $
// Copyright:   (c) 2000-2002 Mattia Barbon
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
    wxPliApp( const char* package );
    ~wxPliApp();

    bool OnInit();
    int OnExit();
    int MainLoop();
#if WXPERL_W_VERSION_GE( 2, 3, 2 )
    DEC_V_CBACK_BOOL__BOOL( Yield );
#endif
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
#if WXPERL_W_VERSION_GE( 2, 3, 3 )
        if( m_exitOnFrameDelete == Later )
            m_exitOnFrameDelete = Yes;
#endif
        retval = wxApp::MainLoop();
        OnExit();
    }

    return retval;
}

int wxPliApp::OnExit()
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "OnExit" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                                     G_SCALAR );
        int val = SvOK( ret ) ? SvIV( ret ) : 0;
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxApp::OnExit();
}

#if WXPERL_W_VERSION_GE( 2, 3, 2 )
DEF_V_CBACK_BOOL__BOOL( wxPliApp, wxApp, Yield );
#endif

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliApp, wxApp );

// Local variables: //
// mode: c++ //
// End: //
