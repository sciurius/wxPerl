/////////////////////////////////////////////////////////////////////////////
// Name:        app.h
// Purpose:     c++ wrapper for wxApp
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxApp:public wxApp
{
    _DECLARE_DYNAMIC_CLASS( _wxApp );
    _DECLARE_V_CBACK();
public:
    _wxApp( const char* package );
    ~_wxApp();

    bool OnInit();
    int OnExit();
    int MainLoop();
};

inline _wxApp::_wxApp( const char* package )
    :m_callback( "Wx::App" ) 
{
    m_callback.SetSelf( _make_object( this, package ), FALSE );
}

_wxApp::~_wxApp()
{
#ifdef __WXMOTIF__
    if (wxTheApp->GetTopWindow())
    {
        delete wxTheApp->GetTopWindow();
        wxTheApp->SetTopWindow(NULL);
    }

    wxTheApp->DeletePendingObjects();

    wxTheApp->OnExit();

    wxApp::CleanUp();
#endif
    delete[] argv;

    argc = 0;
    argv = 0;
}

inline bool _wxApp::OnInit() 
{
    return FALSE;
}

inline int _wxApp::MainLoop() {
    int retval = 0;
  
    DeletePendingObjects();
#ifdef __WXGTK__
    m_initialized = wxTopLevelWindows.GetCount() != 0;
#endif

    if( Initialized() ) 
    {
        retval = wxApp::MainLoop();
        OnExit();
    }

    return retval;
}

int _wxApp::OnExit()
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnExit" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR );
        int val = SvIV( ret );
        SvREFCNT_dec( ret );

        return val;
    }
    else
        return wxApp::OnExit();
}

_IMPLEMENT_DYNAMIC_CLASS( _wxApp, wxApp );

// Local variables: //
// mode: c++ //
// End: //
