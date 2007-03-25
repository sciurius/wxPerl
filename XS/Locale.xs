#############################################################################
## Name:        XS/Locale.xs
## Purpose:     XS for Wx::Locale
## Author:      Mattia Barbon
## Modified by:
## Created:     30/11/2000
## RCS-ID:      $Id: Locale.xs,v 1.29 2007/03/25 10:22:33 mbarbon Exp $
## Copyright:   (c) 2000-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/intl.h>

MODULE=Wx PACKAGE=Wx::LanguageInfo

wxLanguageInfo*
wxLanguageInfo::new( language, canonicalName, winLang, winSublang, descr )
    int language
    wxString canonicalName
    int winLang
    int winSublang
    wxString descr
  CODE:
    RETVAL = new wxLanguageInfo;
    RETVAL->Language = language;
    RETVAL->CanonicalName = canonicalName;
#if defined( __WXMSW__ )
    RETVAL->WinLang = winLang;
    RETVAL->WinSublang = winSublang;
#endif
    RETVAL->Description = descr;
  OUTPUT: RETVAL

static void
wxLanguageInfo::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxLanguageInfo::DESTROY()
  CODE:
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;

MODULE=Wx PACKAGE=Wx::Locale

wxLocale*
newLong( name, shorts = NULL, locale = NULL, loaddefault = true, convertencoding = false )
    const wxChar* name
    const wxChar* shorts = NO_INIT
    const wxChar* locale = NO_INIT
    bool loaddefault
    bool convertencoding
  CODE:
    wxString shorts_tmp, locale_tmp;
    
    if( items < 2 ) shorts = NULL;
    else
    {
        WXSTRING_INPUT( shorts_tmp, const char*, ST(1) );
        shorts = shorts_tmp.c_str();
    }

    if( items < 3 ) locale = NULL;
    else
    {
        WXSTRING_INPUT( locale_tmp, const char*, ST(2) );
        locale = locale_tmp.c_str();
    }

    RETVAL = new wxLocale( name, shorts,
        ( locale && wxStrlen( locale ) ) ? locale : NULL,
        loaddefault, convertencoding );
  OUTPUT:
    RETVAL

wxLocale*
newShort( language, flags = wxLOCALE_LOAD_DEFAULT|wxLOCALE_CONV_ENCODING )
    int language
    int flags
  CODE:
    RETVAL = new wxLocale( language, flags );
  OUTPUT:
    RETVAL

static void
wxLocale::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxLocale::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Locale", THIS, ST(0) );
    delete THIS;

bool
wxLocale::AddCatalog( domain )
    wxString domain

void
wxLocale::AddCatalogLookupPathPrefix( prefix )
    wxString prefix

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
IsAvailable( lang )
    int lang
  CODE:
    RETVAL = wxLocale::IsAvailable( lang );
  OUTPUT: RETVAL

#endif

void
AddLanguage( info )
    wxLanguageInfo* info
  CODE:
    wxLocale::AddLanguage( *info );

const wxChar*
wxLocale::GetLocale()

wxString
wxLocale::GetName()

const wxChar*
wxLocale::GetString( string, domain = NULL )
    const wxChar* string
    const wxChar* domain

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxString
wxLocale::GetHeaderValue( header, domain = NULL )
    const wxChar* header
    const wxChar* domain

#endif

int
GetSystemLanguage()
  CODE:
    RETVAL = wxLocale::GetSystemLanguage();
  OUTPUT:
    RETVAL

int
wxLocale::GetLanguage()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxString
wxLocale::GetLanguageName( lang )
    int lang

#endif

wxString
wxLocale::GetSysName()

wxString
wxLocale::GetCanonicalName()

wxFontEncoding
GetSystemEncoding()
  CODE:
    RETVAL = wxLocale::GetSystemEncoding();
  OUTPUT:
    RETVAL

wxString
GetSystemEncodingName()
  CODE:
    RETVAL = wxLocale::GetSystemEncodingName();
  OUTPUT:
    RETVAL

bool
wxLocale::IsLoaded( domain )
    const wxChar* domain

bool
wxLocale::IsOk()

MODULE=Wx PACKAGE=Wx PREFIX=wx

const wxChar*
wxGetTranslation( string )
    const wxChar* string
  CODE:
    RETVAL = wxGetTranslation( string );
  OUTPUT:
    RETVAL
