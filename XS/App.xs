#############################################################################
## Name:        XS/App.xs
## Purpose:     XS for Wx::_App and Wx::App
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: App.xs,v 1.34 2006/09/24 15:04:24 mbarbon Exp $
## Copyright:   (c) 2000-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/app.h>
##include "cpp/app.h"

#include <wx/artprov.h>

MODULE=Wx PACKAGE=Wx PREFIX=wx

void
wxPostEvent( evthnd, event )
    wxEvtHandler* evthnd
    wxEvent* event
  CODE:
    wxPostEvent( evthnd, *event );

void
wxWakeUpIdle()

MODULE=Wx PACKAGE=Wx::_App

int
Start( app, sub )
    wxApp* app 
    SV* sub
  CODE:
    // for Wx::Perl::SplashFast
    if( !SvROK( sub ) || SvTYPE( SvRV( sub ) ) != SVt_PVCV )
      croak( "sub must be a CODE reference" );
#if WXPERL_W_VERSION_LE( 2, 5, 1 )
    app->argc = wxPli_get_args_argc_argv( (void***) &app->argv, 1 );
#endif
#ifdef __WXMOTIF__
    app->SetClassName( app->argv[0] );
    app->SetAppName( app->argv[0] );
#endif
#if WXPERL_W_VERSION_LE( 2, 5, 0 )
    if( !wxPerlAppCreated )
        wxEntryInitGui();
#endif

    PUTBACK;
    RETVAL = call_oninit( aTHX_ ST(0), sub );
    SPAGAIN;
  OUTPUT:
    RETVAL

wxApp*
wxApp::new()
  CODE:
    if( !wxTheApp )
#if !WXPERL_W_VERSION_GE( 2, 5, 1 )
        wxTheApp = new wxPliApp();
#else
        wxAppConsole::SetInstance( new wxPliApp() );
#endif
    RETVAL = wxTheApp;
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::App

# unimplemented
# virtual void OnFatalException() # too low level

void
wxApp::Dispatch()

wxString
wxApp::GetAppName()

#if defined( __WXMSW__ ) && !WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxApp::GetAuto3D()

#endif

wxString
wxApp::GetClassName()

bool
wxApp::GetExitOnFrameDelete()

wxIcon*
wxApp::GetStdIcon( which )
    int which
  CODE:
    wxString id;
    switch( which )
    {
    case wxICON_EXCLAMATION:
        id = wxART_WARNING;
        break;
    case wxICON_HAND:
        id = wxART_ERROR; 
        break;
    case wxICON_QUESTION:
        id = wxART_QUESTION;
        break;
    case wxICON_INFORMATION:
        id = wxART_INFORMATION;
        break;
    };

    RETVAL = new wxIcon( wxArtProvider::GetIcon( id, wxART_MESSAGE_BOX ) );
  OUTPUT:
    RETVAL

wxWindow*
wxApp::GetTopWindow()

bool
wxApp::GetUseBestVisual()

wxString
wxApp::GetVendorName()

void
wxApp::ExitMainLoop()

#if !WXPERL_W_VERSION_GE( 2, 7, 0 )

bool
wxApp::Initialized()

#endif

int
wxApp::MainLoop()
  CODE:
    RETVAL = THIS->MainLoop();
    // hack for embedded case...
#if defined( __WXMSW__ ) && !WXPERL_W_VERSION_GE( 2, 5, 0 )
    wxPliApp::SetKeepGoing( (wxPliApp*) THIS, true );
#endif
    wxPliApp::DeletePendingObjects( THIS );
  OUTPUT: RETVAL

bool
wxApp::Pending()

void
wxApp::SetAppName( name )
    wxString name

#if defined( __WXMSW__ ) && !WXPERL_W_VERSION_GE( 2, 5, 0 )

void
wxApp::SetAuto3D( auto3d )
    bool auto3d

#endif

void
wxApp::SetClassName( name )
    wxString name

void
wxApp::SetExitOnFrameDelete( flag )
    bool flag

void
wxApp::SetTopWindow( window )
    wxWindow* window

void
wxApp::SetVendorName( name )
    wxString name

void
wxApp::SetUseBestVisual( flag )
    bool flag

void
wxApp::Yield()
  CODE:
    THIS->wxApp::Yield();

#if defined( __WXMSW__ ) && WXPERL_W_VERSION_GE( 2, 5, 0 )
int
GetComCtl32Version()
  CODE:
    RETVAL = wxApp::GetComCtl32Version();
  OUTPUT:
    RETVAL

#endif

#if WXPERL_W_VERSION_GE( 2, 5, 2 )

void
wxApp::Exit()

bool
wxApp::ProcessIdle()

bool
wxApp::SendIdleEvents( window, event )
    wxWindow* window
    wxIdleEvent* event
  C_ARGS: window, *event

bool
wxApp::IsActive()

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

wxLayoutDirection
wxApp::GetLayoutDirection()

#endif
