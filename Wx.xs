/////////////////////////////////////////////////////////////////////////////
// Name:        Wx.xs
// Purpose:     main XS module
// Author:      Mattia Barbon
// Modified by:
// Created:     01/10/2000
// RCS-ID:      $Id: Wx.xs,v 1.72 2006/03/10 19:25:32 mbarbon Exp $
// Copyright:   (c) 2000-2002, 2004-2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

#include <stddef.h>
#include "cpp/compat.h"

// THIS IS AN HACK!
#if defined(_MSC_VER)
#define STRICT
#endif

#include "cpp/wxapi.h"

#include <wx/window.h>
#include <wx/module.h>
// FIXME hack
#if WXPERL_W_VERSION_GE( 2, 5, 2 ) \
    && (defined(__DARWIN__) || defined(__UNIX__))
#define HACK
#include <wx/html/htmlwin.h>
#include <wx/mediactrl.h>
#endif

#if defined(__WXMSW__)
#include <wx/msw/private.h>
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    #include <wx/init.h>
#else
#if defined(__WXGTK__)
int  WXDLLEXPORT wxEntryStart( int& argc, char** argv );
#else
int  WXDLLEXPORT wxEntryStart( int argc, char** argv );
#endif
int  WXDLLEXPORT wxEntryInitGui();
void WXDLLEXPORT wxEntryCleanup();
#endif

#include "cpp/typedef.h"

#include "cpp/v_cback.h"

// to declare wxPliUserDataCD
#include "cpp/helpers.h"
#include "cpp/helpers.cpp"
#include "cpp/v_cback.cpp"
#include "cpp/overload.cpp"
#include "cpp/ovl_const.cpp"

//
// our App
//
#include <wx/app.h>
#include "cpp/app.h"

IMPLEMENT_APP_NO_MAIN(wxPliApp);
static bool wxPerlAppCreated = false;
static bool wxPerlInitialized = false;

#undef THIS

#ifdef __cplusplus
extern "C" {
#endif
    XS( boot_Wx_Const );
    XS( boot_Wx_Ctrl );
    XS( boot_Wx_Evt );
    XS( boot_Wx_Win );
    XS( boot_Wx_Wnd );
    XS( boot_Wx_GDI );
#if defined( WXPL_STATIC )
    XS( boot_Wx__DocView );
#if wxPERL_USE_STC
    XS( boot_Wx__STC );
#endif
#if wxPERL_USE_XRC
    XS( boot_Wx__XRC );
#endif
    XS( boot_Wx__Print );
    XS( boot_Wx__MDI );
    XS( boot_Wx__Html );
    XS( boot_Wx__Help );
    XS( boot_Wx__Grid );
    XS( boot_Wx__FS );
    XS( boot_Wx__DND );
#endif
#ifdef __cplusplus
}
#endif

extern void SetConstants();
extern void SetConstantsOnce();

static int call_oninit( pTHX_ SV* This, SV* sub )
{
    dSP;

    ENTER;
    SAVETMPS;

    PUSHMARK( SP );
    XPUSHs( This );
    PUTBACK;

    int count = call_sv( sub, G_SCALAR|G_EVAL );
    int retval = 0;

    SPAGAIN;

    if( SvTRUE( ERRSV ) )
    {
        croak( Nullch );
    }
    else if( count == 1 )
    {
        retval = POPi;
    }

    PUTBACK;

    FREETMPS;
    LEAVE;

    return retval;
}


#if defined(__WXMOTIF__) && !WXPERL_W_VERSION_GE( 2, 5, 1 )

#include <wx/app.h>
#include <wx/log.h>

int wxEntryStart( int argc, char** argv )
{
#if (defined(__WXDEBUG__) && wxUSE_MEMORY_TRACING) || wxUSE_DEBUG_CONTEXT
    // This seems to be necessary since there are 'rogue'
    // objects present at this point (perhaps global objects?)
    // Setting a checkpoint will ignore them as far as the
    // memory checking facility is concerned.
    // Of course you may argue that memory allocated in globals should be
    // checked, but this is a reasonable compromise.
    wxDebugContext::SetCheckpoint();
#endif

    if (!wxApp::Initialize())
        return false;
}

int wxEntryInitGui()
{
    int retValue = 0;

    // GUI-specific initialization, such as creating an app context.
    if( !wxTheApp->OnInitGui() )
        retValue = -1;

    return retValue;
}

void wxEntryCleanup()
{
    // flush the logged messages if any
    wxLog *pLog = wxLog::GetActiveTarget();
    if ( pLog != NULL && pLog->HasPendingMessages() )
        pLog->Flush();

    delete wxLog::SetActiveTarget(new wxLogStderr); // So dialog boxes aren't used
    // for further messages

    wxApp::CleanUp();

    // some code moved to _wxApp destructor
    // since at this point the app is already destroyed
}

#endif

DEFINE_PLI_HELPERS( st_wxPliHelpers );

#include <wx/confbase.h>
typedef wxConfigBase::EntryType EntryType;

WXPLI_BOOT_ONCE_EXP(Wx);
#define boot_Wx wxPli_boot_Wx

extern bool Wx_booted, Wx_Const_booted, Wx_Ctrl_booted,
    Wx_Evt_booted, Wx_Wnd_booted, Wx_GDI_booted, Wx_Win_booted;

MODULE=Wx PACKAGE=Wx

BOOT:
  newXSproto( "Wx::_boot_Constant", boot_Wx_Const, file, "$$" );
  newXSproto( "Wx::_boot_Controls", boot_Wx_Ctrl, file, "$$" );
  newXSproto( "Wx::_boot_Events", boot_Wx_Evt, file, "$$" );
  newXSproto( "Wx::_boot_Window", boot_Wx_Win, file, "$$" );
  newXSproto( "Wx::_boot_Frames", boot_Wx_Wnd, file, "$$" );
  newXSproto( "Wx::_boot_GDI", boot_Wx_GDI, file, "$$" );
#if defined( WXPL_STATIC )
  newXSproto( "Wx::_boot_Wx__DocView", boot_Wx__DocView, file, "$$" );
#if wxPERL_USE_STC
  newXSproto( "Wx::_boot_Wx__STC", boot_Wx__STC, file, "$$" );
#endif
#if wxPERL_USE_XRC
  newXSproto( "Wx::_boot_Wx__XRC", boot_Wx__XRC, file, "$$" );
#endif
  newXSproto( "Wx::_boot_Wx__Print", boot_Wx__Print, file, "$$" );
  newXSproto( "Wx::_boot_Wx__MDI", boot_Wx__MDI, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Html", boot_Wx__Html, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Help", boot_Wx__Help, file, "$$" );
  newXSproto( "Wx::_boot_Wx__Grid", boot_Wx__Grid, file, "$$" );
  newXSproto( "Wx::_boot_Wx__FS", boot_Wx__FS, file, "$$" );
  newXSproto( "Wx::_boot_Wx__DND", boot_Wx__DND, file, "$$" );
#endif
  SV* tmp = get_sv( "Wx::_exports", 1 );
  sv_setiv( tmp, (IV)(void*)&st_wxPliHelpers );

void 
Load()
  CODE:
    wxPerlAppCreated = wxTheApp != NULL && wxTheApp->Initialized();
    if( wxPerlInitialized ) { XSRETURN_EMPTY; }
    wxPerlInitialized = true;

    NV ver = wxMAJOR_VERSION + wxMINOR_VERSION / 1000.0 + 
        wxRELEASE_NUMBER / 1000000.0;
    // set up version as soon as possible
    SV* tmp = get_sv( "Wx::_wx_version", 1 );
    sv_setnv( tmp, ver );
    tmp = get_sv( "Wx::wxVERSION", 1 );
    sv_setnv( tmp, ver );

    int platform;
    // change App.pm whenever these change
#if defined(__WXMSW__)
    platform = 1;
#elif defined(__WXGTK__)
    platform = 2;
#elif defined(__WXMOTIF__)
    platform = 3;
#elif defined(__WXMAC__)
    platform = 4;
#elif defined(__WXX11__)
    platform = 5;
#else
    #error must add case
#endif

    tmp = get_sv( "Wx::_platform", 1 );
    sv_setiv( tmp, platform );

    if( wxPerlAppCreated || wxTopLevelWindows.GetCount() > 0 )
        return;

    int argc = 0;
#if wxUSE_UNICODE && WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxChar** argv = 0;

    argc = wxPli_get_args_argc_argv( (void***) &argv, 1 );
    wxEntryStart( argc, argv );
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxPli_delete_argv( (void***) &argv, 1 );
#endif
#else
    char** argv = 0;

    argc = wxPli_get_args_argc_argv( (void***) &argv, 0 );
    wxEntryStart( argc, argv );
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxPli_delete_argv( (void***) &argv, 0 );
#endif
#endif

void
SetConstants()
  CODE:
    // this is after wxEntryStart, since
    // wxInitializeStockObjects needs to be called
    // (for colours, cursors, pens, etc...)
    SetConstants();

void
SetConstantsOnce()

void
SetOvlConstants()

void
UnLoad()
  CODE:
    wxPerlAppCreated = wxTheApp != NULL && wxTheApp->Initialized();
    Wx_booted = Wx_Const_booted = Wx_Ctrl_booted =
        Wx_Evt_booted = Wx_Wnd_booted = Wx_GDI_booted = Wx_Win_booted = false;
    if( wxPerlInitialized && !wxPerlAppCreated )
        wxEntryCleanup();
    wxPerlInitialized = false;

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

#include <wx/dynload.h>

bool
_load_plugin( string )
    wxString string
  CODE:
#ifdef HACK
    delete new wxHtmlWindow();
    delete new wxMediaCtrl();
#endif
    RETVAL = wxPluginManager::LoadLibrary( string, wxDL_VERBATIM );
  OUTPUT:
    RETVAL

bool
_unload_plugin( string )
    wxString string
  CODE:
    RETVAL = wxPluginManager::UnloadLibrary( string );
  OUTPUT:
    RETVAL

#endif

bool
_xsmatch( avref, proto, required = -1, allow_more = false )
    SV* avref
    SV* proto
    int required
    bool allow_more
  PREINIT:
    AV* av;
    unsigned char* prototype;
    int i, n, len;
  PROTOTYPE: \@$;$$
  CODE:
    av = wxPli_avref_2_av( avref );
    if( !av ) croak( "first parameter must be an ARRAY reference" );
    n = wxPli_av_2_uchararray( aTHX_ proto, &prototype );
    len = av_len( av ) + 1;
    EXTEND(SP, len);
    PUSHMARK(SP);
    for( i = 0; i < len; ++i )
        PUSHs( *av_fetch( av, i, 0 ) );
    PUTBACK;
    RETVAL = wxPli_match_arguments( aTHX_ prototype, n, required, allow_more );
    SPAGAIN;
    POPMARK; // wxPli_match_* does a PUSHMARK
    delete[] prototype;
  OUTPUT:
    RETVAL

I32
looks_like_number( sval )
    SV* sval
  CODE:
    RETVAL = my_looks_like_number( aTHX_ sval );
  OUTPUT:
    RETVAL

void
CLONE( CLASS )
    char* CLASS
  CODE:
    SetConstants();

INCLUDE: XS/App.xs
INCLUDE: XS/Caret.xs
INCLUDE: XS/Geom.xs
INCLUDE: XS/Menu.xs
INCLUDE: XS/Log.xs
INCLUDE: XS/ToolTip.xs
INCLUDE: XS/Locale.xs
INCLUDE: XS/Utils.xs
INCLUDE: XS/Timer.xs
INCLUDE: XS/Stream.xs
INCLUDE: XS/TaskBarIcon.xs
INCLUDE: XS/Config.xs
INCLUDE: XS/Process.xs
INCLUDE: XS/FontMapper.xs
INCLUDE: XS/FontEnumerator.xs
INCLUDE: XS/Wave.xs
INCLUDE: perl ./script/xsubppp.pl --typemap=typemap.xsp XS/ArtProvider.xsp |

INCLUDE: perl ./script/xsubppp.pl --typemap=typemap.xsp XS/MimeTypes.xsp |

# this is here for debugging purpouses
INCLUDE: XS/ClassInfo.xs

##  //FIXME// tricky
##if defined(__WXMSW__)
##undef XS
##define XS( name ) WXXS( name )
##endif

MODULE=Wx PACKAGE=Wx
