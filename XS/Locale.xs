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

Wx_Locale*
Wx_Locale::new( name, shorts = 0, locale = 0, loaddefault = TRUE, convertencoding = FALSE )
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

bool
Wx_Locale::IsLoaded( domain )
    const char* domain

bool
Wx_Locale::IsOk()
