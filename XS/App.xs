#############################################################################
## Name:        App.xs
## Purpose:     XS for Wx::_App and Wx::App
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/app.h>
#include "cpp/app.h"

#if WXPERL_W_VERSION_GE( 2, 3, 3 )
#include <wx/artprov.h>
#endif

MODULE=Wx PACKAGE=Wx PREFIX=wx

void
wxPostEvent( evthnd, event )
    Wx_EvtHandler* evthnd
    Wx_Event* event
  CODE:
    wxPostEvent( evthnd, *event );

void
wxWakeUpIdle()

MODULE=Wx PACKAGE=Wx::_App

void
End()
  CODE:
    wxEntryCleanup();

int
Start( app, sub )
    Wx_App* app 
    SV* sub
  CODE:
    // for Wx::Perl::SplashFast
#if 0
    if( wxTopLevelWindows.Number() > 0 )
      croak( "Only one Wx::App instance allowed" );
#endif
    if( !SvROK( sub ) || SvTYPE( SvRV( sub ) ) != SVt_PVCV )
      croak( "sub must be a CODE reference" );

    app->argc = wxPli_get_args_argc_argv( &app->argv, 1 );
#ifdef __WXMOTIF__
    app->SetClassName( app->argv[0] );
    app->SetAppName( app->argv[0] );
#endif
    wxEntryInitGui();

    PUSHMARK( SP );
    XPUSHs( ST(0) );
    PUTBACK;
    call_sv(sub, G_SCALAR);
    RETVAL = POPi;
  OUTPUT:
    RETVAL

Wx_App*
Wx_App::new()
  CODE:
    RETVAL = new wxPliApp( CLASS );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::App

# unimplemented
# virtual void OnFatalException() # too low level

void
Wx_App::Dispatch()

wxString
Wx_App::GetAppName()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

bool
Wx_App::GetAuto3D()

#endif

wxString
Wx_App::GetClassName()

bool
Wx_App::GetExitOnFrameDelete()

Wx_Icon*
Wx_App::GetStdIcon( which )
    int which
  CODE:
#if WXPERL_W_VERSION_LE( 2, 3, 2 )
    RETVAL = new wxIcon( THIS->GetStdIcon( which ) );
#else
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
#endif
  OUTPUT:
    RETVAL

Wx_Window*
Wx_App::GetTopWindow()

bool
Wx_App::GetUseBestVisual()

wxString
Wx_App::GetVendorName()

void
Wx_App::ExitMainLoop()

bool
Wx_App::Initialized()

int
Wx_App::MainLoop()

bool
Wx_App::Pending()

void
Wx_App::SetAppName( name )
    wxString name

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_App::SetAuto3D( auto3d )
    bool auto3d

#endif

void
Wx_App::SetClassName( name )
    wxString name

void
Wx_App::SetExitOnFrameDelete( flag )
    bool flag

void
Wx_App::SetTopWindow( window )
    Wx_Window* window

void
Wx_App::SetVendorName( name )
    wxString name

void
Wx_App::SetUseBestVisual( flag )
    bool flag

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

void
Wx_App::Yield()
  CODE:
    THIS->wxApp::Yield();

#endif
