/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/app.h
// Purpose:     c++ wrapper for wxApp
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2006 Mattia Barbon
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

#if defined( __WXMSW__ ) && WXPERL_W_VERSION_LT( 2, 5, 0 )
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

#if ( WXPERL_W_VERSION_GE( 2, 9, 1 ) && wxDEBUG_LEVEL > 0 ) || ( WXPERL_W_VERSION_LE( 2, 9, 0) && defined(__WXDEBUG__) )    

    void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg)
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "OnAssertFailure" ) )
        {
            wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                               G_DISCARD|G_SCALAR,
                                               "wiwww", file, line, func, cond, msg );
        } else
            wxApp::OnAssertFailure( file, line, func, cond, msg );
    }
#endif

    DEC_V_CBACK_INT__VOID( OnExit );
    DEC_V_CBACK_BOOL__BOOL( Yield );
    
#if ( WXPERL_W_VERSION_GE( 2, 9, 4 ) && defined(__WXOSX_COCOA__) )
    
    virtual void MacOpenFiles(const wxArrayString &fileNames )
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "MacOpenFiles" ) )
        {
            AV* files;
            files = wxPli_stringarray_2_av( aTHX_ fileNames );
            wxPliCCback( aTHX_ &m_callback, G_DISCARD|G_SCALAR,
                        "S", sv_2mortal( newRV_noinc( (SV*)files ) ) );
        } else
            wxApp::MacOpenFiles( fileNames );
    }
    
    virtual void MacOpenFile(const wxString &fileName)
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "MacOpenFile" ) )
        {
            wxPliCCback( aTHX_ &m_callback, G_DISCARD|G_SCALAR, "P", &fileName );
        } else
            wxApp::MacOpenFile( fileName );
    }

    virtual void MacOpenURL(const wxString &url)
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "MacOpenURL" ) )
        {
            wxPliCCback( aTHX_ &m_callback, G_DISCARD|G_SCALAR, "P", &url );
        } else
            wxApp::MacOpenURL( url );
    }
    
    virtual void MacPrintFile(const wxString &fileName)
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "MacPrintFile" ) )
        {
            wxPliCCback( aTHX_ &m_callback, G_DISCARD|G_SCALAR, "P", &fileName );
        } else
            wxApp::MacPrintFile( fileName );
    }    
    
    virtual void MacNewFile()
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "MacNewFile" ) )
        {
            wxPliCCback( aTHX_ &m_callback, G_DISCARD|G_SCALAR, NULL );
        } else
            wxApp::MacNewFile();
    }
    
    virtual void MacReopenApp()
    {
        dTHX;
        if( wxPliFCback( aTHX_ &m_callback, "MacReopenApp" ) )
        {
            wxPliCCback( aTHX_ &m_callback, G_DISCARD|G_SCALAR, NULL );
        } else
            wxApp::MacReopenApp();
    }      

#endif
    
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
#if defined( __WXGTK__ ) && WXPERL_W_VERSION_LT( 2, 5, 1 )
    m_initialized = wxTopLevelWindows.GetCount() != 0;
#endif

    if( m_exitOnFrameDelete == Later )
      m_exitOnFrameDelete = Yes;
    retval = wxApp::MainLoop();
    OnExit();

    return retval;
}

DEF_V_CBACK_INT__VOID( wxPliApp, wxApp, OnExit );
DEF_V_CBACK_BOOL__BOOL( wxPliApp, wxApp, Yield );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliApp, wxApp );

// Local variables: //
// mode: c++ //
// End: //
