#############################################################################
## Name:        Locale.xs
## Purpose:     XS for Wx::Locale
## Author:      Mattia Barbon
## Modified by:
## Created:     30/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/intl.h>

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

MODULE=Wx PACKAGE=Wx::LanguageInfo

Wx_LanguageInfo*
Wx_LanguageInfo::new( language, canonicalName, winLang, winSublang, description )
    int language
    wxString canonicalName
    int winLang
    int winSublang
    wxString description
  CODE:
    RETVAL = new wxLanguageInfo;
    RETVAL->Language = language;
    RETVAL->CanonicalName = canonicalName;
#if defined( __WXMSW__ )
    RETVAL->WinLang = winLang;
    RETVAL->WinSublang = winSublang;
#endif
    RETVAL->Description = description;
  OUTPUT:
    RETVAL

void
Wx_LanguageInfo::DESTROY()

#endif

MODULE=Wx PACKAGE=Wx::Locale

Wx_Locale*
newLong( name, shorts = 0, locale = 0, loaddefault = TRUE, convertencoding = FALSE )
    const wxChar* name
    const wxChar* shorts = NO_INIT
    const wxChar* locale = NO_INIT
    bool loaddefault
    bool convertencoding
  CODE:
    wxString shorts_tmp, locale_tmp;
    
    if( items < 2 ) shorts = 0;
    else
    {
        WXSTRING_INPUT( shorts_tmp, const char*, ST(1) );
        shorts = shorts_tmp.c_str();
    }

    if( items < 3 ) locale = 0;
    else
    {
        WXSTRING_INPUT( locale_tmp, const char*, ST(2) );
        locale = locale_tmp.c_str();
    }

    RETVAL = new wxLocale( name, shorts,
#if wxUSE_UNICODE
        ( locale && wcslen( locale ) ) ? locale : 0,
#else
        ( locale && strlen( locale ) ) ? locale : 0,
#endif
        loaddefault, convertencoding );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_Locale*
newShort( language, flags = wxLOCALE_LOAD_DEFAULT|wxLOCALE_CONV_ENCODING )
    int language
    int flags
  CODE:
    RETVAL = new wxLocale( language, flags );
  OUTPUT:
    RETVAL

#endif

void
Wx_Locale::DESTROY()

bool
Wx_Locale::AddCatalog( domain )
    wxString domain

void
Wx_Locale::AddCatalogLookupPathPrefix( prefix )
    wxString prefix

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

void
AddLanguage( info )
    Wx_LanguageInfo* info
  CODE:
    wxLocale::AddLanguage( *info );

#endif

const wxChar*
Wx_Locale::GetLocale()

wxString
Wx_Locale::GetName()

const wxChar*
Wx_Locale::GetString( string, domain = 0 )
    const wxChar* string
    const wxChar* domain

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

int
GetSystemLanguage()
  CODE:
    RETVAL = wxLocale::GetSystemLanguage();
  OUTPUT:
    RETVAL

int
Wx_Locale::GetLanguage()

wxString
Wx_Locale::GetSysName()

wxString
Wx_Locale::GetCanonicalName()

#endif

bool
Wx_Locale::IsLoaded( domain )
    const wxChar* domain

bool
Wx_Locale::IsOk()

MODULE=Wx PACKAGE=Wx PREFIX=wx

const wxChar*
wxGetTranslation( string )
    const wxChar* string
  CODE:
#if wxUSE_UNICODE
    wxMB2WXbuf ret = wxGetTranslation( string );
    RETVAL = ret.data();
#else
    RETVAL = wxGetTranslation( string );
#endif
  OUTPUT:
    RETVAL
