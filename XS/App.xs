#############################################################################
## Name:        XS/App.xs
## Purpose:     XS for Wx::_App and Wx::App
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: App.xs,v 1.23 2004/07/10 14:01:48 mbarbon Exp $
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/app.h>
##include "cpp/app.h"

#if WXPERL_W_VERSION_GE( 2, 3, 3 )
#include <wx/artprov.h>
#endif

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

## void
## End()
##   CODE:
##     wxEntryCleanup();

int
Start( app, sub )
    wxApp* app 
    SV* sub
  CODE:
    // for Wx::Perl::SplashFast
    if( !SvROK( sub ) || SvTYPE( SvRV( sub ) ) != SVt_PVCV )
      croak( "sub must be a CODE reference" );

    app->argc = wxPli_get_args_argc_argv( &app->argv, 1 );
#ifdef __WXMOTIF__
    app->SetClassName( app->argv[0] );
    app->SetAppName( app->argv[0] );
#endif
#if !WXPERL_W_VERSION_GE( 2, 5, 1 )
    if( !wxPerlAppCreated )
        wxEntryInitGui();
#endif

    SV* This = ST(0);
    
    PUSHMARK( SP );
    XPUSHs( This );
    PUTBACK;
    call_sv(sub, G_SCALAR);
    SPAGAIN;
    RETVAL = POPi;
    PUTBACK;
  OUTPUT:
    RETVAL

wxApp*
wxApp::new()
  CODE:
#if !WXPERL_W_VERSION_GE( 2, 5, 1 )
    if( !wxTheApp )
        wxTheApp = new wxPliApp();
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

Wx_Icon*
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

Wx_Window*
wxApp::GetTopWindow()

bool
wxApp::GetUseBestVisual()

wxString
wxApp::GetVendorName()

void
wxApp::ExitMainLoop()

bool
wxApp::Initialized()

int
wxApp::MainLoop()
  CODE:
    RETVAL = THIS->MainLoop();
    // hack for embedded case...
#if defined( __WXMSW__ ) && !WXPERL_W_VERSION_GE( 2, 5, 0 )
    wxPliApp::SetKeepGoing( (wxPliApp*) THIS, true );
#endif
    THIS->DeletePendingObjects();
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
    Wx_Window* window

void
wxApp::SetVendorName( name )
    wxString name

void
wxApp::SetUseBestVisual( flag )
    bool flag

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

void
wxApp::Yield()
  CODE:
    THIS->wxApp::Yield();

#endif
