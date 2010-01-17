/////////////////////////////////////////////////////////////////////////////
// Name:        Wx.xs
// Purpose:     main XS module
// Author:      Mattia Barbon
// Modified by:
// Created:     01/10/2000
// RCS-ID:      $Id$
// Copyright:   (c) 2000-2002, 2004-2010 Mattia Barbon
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
    && defined(__DARWIN__)
#define HACK
#include <wx/html/htmlwin.h>
#if wxUSE_MEDIACTRL
#include <wx/mediactrl.h>
#endif
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
#if !wxUSE_UNICODE
bool wxPli_always_utf8;
#endif

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


#if defined(__WXMOTIF__) && WXPERL_W_VERSION_LT( 2, 5, 1 )

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
        return -1;

    return 0;
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

#if WXPERL_W_VERSION_LT( 2, 9, 0 )
typedef int wxPolygonFillMode;
#endif

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

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
#define wxPliEntryStart( argc, argv ) wxEntryStart( (argc), (argv) )
#else
#define wxPliEntryStart( argc, argv ) ( wxEntryStart( (argc), (argv) ) == 0 )
#endif

bool 
Load()
  CODE:
    wxPerlAppCreated = wxTheApp != NULL;
    if( wxPerlInitialized ) { XSRETURN( true ); }
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
#if defined(DEBUGGING) && !defined(PERL_USE_SAFE_PUTENV)
    // avoid crash on exit in Fedora (and other DEBUGGING Perls)
    PL_use_safe_putenv = 1;
#endif

    int argc = 0;
#if wxUSE_UNICODE && WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxChar** argv = 0;

    argc = wxPli_get_args_argc_argv( (void***) &argv, 1 );
    wxPerlInitialized = wxPliEntryStart( argc, argv );
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxPli_delete_argv( (void***) &argv, 1 );
#endif
#else
    char** argv = 0;

    argc = wxPli_get_args_argc_argv( (void***) &argv, 0 );
    wxPerlInitialized = wxPliEntryStart( argc, argv );
#if WXPERL_W_VERSION_LE( 2, 5, 2 )
    wxPli_delete_argv( (void***) &argv, 0 );
#endif
#endif
    RETVAL = wxPerlInitialized;
  OUTPUT: RETVAL

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
    wxPerlAppCreated = wxTheApp != NULL;
    Wx_booted = Wx_Const_booted = Wx_Ctrl_booted =
        Wx_Evt_booted = Wx_Wnd_booted = Wx_GDI_booted = Wx_Win_booted = false;
    if( wxPerlInitialized && !wxPerlAppCreated )
        wxEntryCleanup();
    wxPerlInitialized = false;

void
SetAlwaysUTF8( always_utf8 = true )
    bool always_utf8
  CODE:
#if !wxUSE_UNICODE
    wxPli_always_utf8 = always_utf8;
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

#include <wx/dynload.h>

bool
_load_plugin( string )
    wxString string
  CODE:
#ifdef HACK
    delete new wxHtmlWindow();
#if wxUSE_MEDIACTRL
    delete new wxMediaCtrl();
#endif
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
_xsmatch( avref, proto, required = -1, allowmore = false )
    SV* avref
    SV* proto
    int required
    bool allowmore
  PREINIT:
    AV* av;
    wxPliPrototype* prototype;
    int n, len;
  PROTOTYPE: \@$;$$
  CODE:
    av = wxPli_avref_2_av( avref );
    if( !av ) croak( "first parameter must be an ARRAY reference" );
    prototype = INT2PTR( wxPliPrototype*, SvIV( proto ) );
    len = av_len( av ) + 1;
    EXTEND(SP, len);
    PUSHMARK(SP);
    for( int i = 0; i < len; ++i )
        PUSHs( *av_fetch( av, i, 0 ) );
    PUTBACK;
    RETVAL = wxPli_match_arguments( aTHX_ *prototype, required, allowmore );
    SPAGAIN;
    POPMARK; // wxPli_match_* does a PUSHMARK
  OUTPUT: RETVAL

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
INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ArtProvider.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/MimeTypes.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Sound.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Power.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/ClassInfo.xs

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Display.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/StandardPaths.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/Variant.xsp

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp XS/NotificationMessage.xsp

##  //FIXME// tricky
##if defined(__WXMSW__)
##undef XS
##define XS( name ) WXXS( name )
##endif

MODULE=Wx PACKAGE=Wx

#!irrelevant class wxArray
#!irrelevant class wxArray<T>
#!irrelevant class wxArrayString
#!irrelevant class wxObjArray
#!irrelevant class wxBrushList
#!irrelevant class wxClientData
#!irrelevant class wxClientDataContainer
#!irrelevant class wxCondition
#!irrelevant class wxCriticalSection
#!irrelevant class wxCriticalSectionLocker
#!irrelevant class wxDebugContext
#!irrelevant class wxDebugStreamBuf
#!irrelevant class wxDynamicLibrary
#!irrelevant class wxDynamicLibraryDetails
#!irrelevant class wxFFile
#!irrelevant class wxFFileInputStream
#!irrelevant class wxFFileOutputStream
#!irrelevant class wxFFileStream
#!irrelevant class wxFile
#!irrelevant class wxFileInputStream
#!irrelevant class wxFileOutputStream
#!irrelevant class wxFileStream
#!irrelevant class wxFilterClassFactory
#!irrelevant class wxFontList
#!irrelevant class wxHashMap
#!irrelevant class wxHashSet
#!irrelevant class wxHashTable
#!irrelevant class wxList
#!irrelevant class wxLongLong
#!irrelevant class wxMemoryBuffer
#!irrelevant class wxModule
#!irrelevant class wxMutex
#!irrelevant class wxMutexLocker
#!irrelevant class wxNode
#!irrelevant class wxObjectRefData
#!irrelevant class wxPathList
#!irrelevant class wxPenList
#!irrelevant class wxProtocol
#!irrelevant class wxRecursionGuard
#!irrelevant class wxRecursionGuardFlag
#!irrelevant class wxScopedArray
#!irrelevant class wxScopedPtr
#!irrelevant class wxScopedTiedPtr
#!irrelevant class wxSemaphore
#!irrelevant class wxString
#!irrelevant class wxStringBuffer
#!irrelevant class wxStringBufferLength
#!irrelevant class wxStringClientData
#!irrelevant class wxStringTokenizer
#!irrelevant class wxThreadHelper

#!equivalent class wxThread to Perl modules thread, thread::shared

#!equivalent class wxArchiveClassFactory to Perl modules Archive::Any, Archive::Zip, Archive::Tar
#!equivalent class wxArchiveEntry to Perl modules Archive::Any, Archive::Zip, Archive::Tar
#!equivalent class wxArchiveInputStream to Perl modules Archive::Any, Archive::Zip, Archive::Tar
#!equivalent class wxArchiveIterator to Perl modules Archive::Any, Archive::Zip, Archive::Tar
#!equivalent class wxArchiveNotifier to Perl modules Archive::Any, Archive::Zip, Archive::Tar
#!equivalent class wxArchiveOutputStream to Perl modules Archive::Any, Archive::Zip, Archive::Tar
#!equivalent class wxAutomationObject to perl module Win32::OLE

#!equivalent class wxCSConv to Perl module Encode
#!equivalent class wxEncodingConverter to Perl module Encode
#!equivalent class wxMBConv to Perl module Encode
#!equivalent class wxMBConvFile to Perl module Encode
#!equivalent class wxMBConvUTF16 to Perl module Encode
#!equivalent class wxMBConvUTF32 to Perl module Encode
#!equivalent class wxMBConvUTF7 to Perl module Encode
#!equivalent class wxMBConvUTF8 to Perl module Encode

#!equivalent class wxDb to Perl module DBI
#!equivalent class wxDbColDataPtr to Perl module DBI
#!equivalent class wxDbColDef to Perl module DBI
#!equivalent class wxDbColFor to Perl module DBI
#!equivalent class wxDbColInf to Perl module DBI
#!equivalent class wxDbConnectInf to Perl module DBI
#!irrelevant class wxDbGridColInfo
#!equivalent class wxDbIdxDef to Perl module DBI
#!equivalent class wxDbInf to Perl module DBI
#!equivalent class wxDbTable to Perl module DBI
#!equivalent class wxDbTableInf to Perl module DBI

#!equivalent class wxDir to opendir/readdir and to Perl modules File::Find, File::Find::Rule
#!equivalent class wxDirTraverser to Perl modules File::Find, File::Find::Rule
#!equivalent class wxFileName to File::Spec, Path::Class

#!equivalent class wxFTP to Perl modules Net::FTP, LWP::UserAgent
#!equivalent class wxHTTP to Perl modules Net::HTTP, LWP::UserAgent

#!equivalent class wxRegEx to a Perl regular expression
#!equivalent class wxRegKey to Perl module Win32::Registry

#!equivalent class wxTarClassFactory to Perl module Archive::Tar
#!equivalent class wxTarEntry to Perl module Archive::Tar
#!equivalent class wxTarInputStream to Perl module Archive::Tar
#!equivalent class wxTarOutputStream to Perl module Archive::Tar

#!equivalent class wxTempFile to Perl module File::Temp
#!equivalent class wxTempFileOutputStream to Perl module File::Temp

#!equivalent class wxTextValidator to Perl module Wx::Perl::TextValidator

#!equivalent class wxURI to Perl module URI
#!equivalent class wxURL to Perl module URI::URL

#!equivalent class wxZipClassFactory to Perl module Archive::Zip
#!equivalent class wxZipEntry to Perl module Archive::Zip
#!equivalent class wxZipInputStream to Perl module Archive::Zip
#!equivalent class wxZipNotifier to Perl module Archive::Zip
#!equivalent class wxZipOutputStream to Perl module Archive::Zip

#!equivalent class wxZlibInputStream to Perl module Compress::Zlib, IO::Zlib
#!equivalent class wxZlibOutputStream to Perl module Compress::Zlib, IO::Zlib

#!equivalent class wxBufferedInputStream to Perl input/output
#!equivalent class wxBufferedOutputStream to Perl input/output
#!equivalent class wxCountingOutputStream to Perl input/output
#!equivalent class wxCountingOutputStream to Perl input/output
#!equivalent class wxDataInputStream to Perl module Storable
#!equivalent class wxDataOutputStream to Perl module Storable
#!equivalent class wxFilterInputStream to Perl module PerlIO::via
#!equivalent class wxFilterOutputStream to Perl module PerlIO::via
#!equivalent class wxMemoryInputStream to Perl module PerlIO::scalar
#!equivalent class wxMemoryOutputStream to Perl module PerlIO::scalar
#!equivalent class wxSocketInputStream to Perl modules IO::Socket::*
#!equivalent class wxSocketOutputStream to Perl modules IO::Socket::*
#!equivalent class wxStreamBase to Perl input/output
#!equivalent class wxStreamBase to Perl input/output
#!equivalent class wxStreamBuffer to Perl input/output
#!equivalent class wxStringInputStream to Perl module PerlIO::scalar
#!equivalent class wxStringOutputStream to Perl module PerlIO::scalar
#!equivalent class wxTextFile to Perl input/output
#!equivalent class wxTextInputStream to Perl input/output
#!equivalent class wxTextOutputStream to Perl input/output

#!equivalent class wxMetafile to Perl module Wx::Metafile

#!equivalent class wxDialUpEvent to Perl module Wx::DialUpEvent
#!equivalent class wxDialUpManager to Perl module Wx::DialUpManager      

#!equivalent class wxGLCanvas to Perl module Wx::GLCanvas
#!equivalent class wxGLContext to Perl module Wx::GLCanvas

#!equivalent class wxDateTime to perl module DateTime, Date::Calc, Date::Manip, Time::Piece
#!equivalent class wxDateSpan to perl module DateTime, Date::Calc, Date::Manip, Time::Piece
#!equivalent class wxTimeSpan to perl module DateTime, Date::Calc, Date::Manip, Time::Piece
