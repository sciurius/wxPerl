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

MODULE=Wx PACKAGE=Wx::Locale

#FIXME// unimplemented
# AddLanguage
# class wxLanguageInfo ( 2.3 )

Wx_Locale*
newLong( name, shorts = 0, locale = 0, loaddefault = TRUE, convertencoding = FALSE )
    const char* name
    const char* shorts
    const char* locale
    bool loaddefault
    bool convertencoding
  CODE:
    RETVAL = new wxLocale( name, shorts, ( locale && strlen( locale ) ) ? locale : 0,
        loaddefault, convertencoding );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 3 )

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
    const char* domain

void
Wx_Locale::AddCatalogLookupPathPrefix( prefix )
    wxString prefix

const char*
Wx_Locale::GetLocale()

wxString
Wx_Locale::GetName()

const char*
Wx_Locale::GetString( string, domain = 0 )
    const char* string
    const char* domain

#if WXPERL_W_VERSION_GE( 2, 3 )

int
Wx_Locale::GetSystemLanguage()

int
Wx_Locale::GetLanguage()

wxString
Wx_Locale::GetSysName()

wxString
Wx_Locale::GetCanonicalName()

#endif

bool
Wx_Locale::IsLoaded( domain )
    const char* domain

bool
Wx_Locale::IsOk()
