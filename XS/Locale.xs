#############################################################################
## Name:        XS/Locale.xs
## Purpose:     XS for Wx::Locale
## Author:      Mattia Barbon
## Modified by:
## Created:     30/11/2000
## RCS-ID:      $Id: Locale.xs,v 1.22 2004/07/10 13:16:46 mbarbon Exp $
## Copyright:   (c) 2000-2004 Mattia Barbon
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

void
DESTROY( THIS )
    wxLanguageInfo* THIS
  CODE:
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;

MODULE=Wx PACKAGE=Wx::Locale

wxLocale*
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

wxLocale*
newShort( language, flags = wxLOCALE_LOAD_DEFAULT|wxLOCALE_CONV_ENCODING )
    int language
    int flags
  CODE:
    RETVAL = new wxLocale( language, flags );
  OUTPUT:
    RETVAL

## XXX threads
void
wxLocale::DESTROY()

bool
wxLocale::AddCatalog( domain )
    wxString domain

void
wxLocale::AddCatalogLookupPathPrefix( prefix )
    wxString prefix

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
wxLocale::GetString( string, domain = 0 )
    const wxChar* string
    const wxChar* domain

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
