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
    if( wxTopLevelWindows.Number() > 0 )
      croak( "Only one Wx::App instance allowed" );
    if( !SvROK( sub ) || SvTYPE( SvRV( sub ) ) != SVt_PVCV )
      croak( "sub must be a CODE reference" );

    app->argc = _get_args_argc_argv( &app->argv );
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
    RETVAL = new _wxApp( CLASS );
  OUTPUT:
    RETVAL

# void
# Wx_App::DESTROY()

MODULE=Wx PACKAGE=Wx::App

#FIXME// unimplemented
# virtual Wx_Log* Wx_App::CreateLogTarget()
# virtual void OnFatalException()
# bool SendIdleEvents( * )

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
    RETVAL = new wxIcon( THIS->GetStdIcon( which ) );
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
