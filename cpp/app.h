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
    _DECLARE_SELFREF();
public:
    _wxApp( const char* package );
    ~_wxApp();

    bool OnInit();
    int MainLoop();
};

_wxApp::_wxApp( const char* package )
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

bool _wxApp::OnInit() 
{
    return FALSE;
}

int _wxApp::MainLoop() {
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

_IMPLEMENT_DYNAMIC_CLASS( _wxApp, wxApp );

// Local variables: //
// mode: c++ //
// End: //
