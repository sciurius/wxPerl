#############################################################################
## Name:        Font.xs
## Purpose:     XS for Wx::Font
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::NativeFontInfo

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

#include <wx/fontutil.h>

void
Wx_NativeFontInfo::DESTROY()

bool
Wx_NativeFontInfo::FromString( string )
    wxString string

wxString
Wx_NativeFontInfo::ToString()

#endif

MODULE=Wx PACKAGE=Wx::Font

Wx_Font*
Wx_Font::new( pointsize, family, style, weight, underline = FALSE, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    int pointsize
    int family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding

void
Wx_Font::DESTROY()

wxFontEncoding
GetDefaultEncoding()
  CODE:
    RETVAL = wxFont::GetDefaultEncoding();
  OUTPUT:
    RETVAL

wxString
Wx_Font::GetFaceName()

int
Wx_Font::GetFamily()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_Font::GetFontId()

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_NativeFontInfo*
Wx_Font::GetNativeFontInfo()

wxString
Wx_Font::GetNativeFontInfoDesc()

#endif

int
Wx_Font::GetPointSize()

int
Wx_Font::GetStyle()

bool
Wx_Font::GetUnderlined()

int
Wx_Font::GetWeight()

void
SetDefaultEncoding( encoding )
    wxFontEncoding encoding
  CODE:
    wxFont::SetDefaultEncoding( encoding );

void
Wx_Font::SetFaceName( faceName )
    wxString faceName

void
Wx_Font::SetFamily( family )
    int family

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

void
Wx_Font::SetNativeFontInfo( info )
    Wx_NativeFontInfo* info
  CODE:
    THIS->SetNativeFontInfo( *info );

#endif

void
Wx_Font::SetPointSize( pointsize )
    int pointsize

void
Wx_Font::SetStyle( style )
    int style

void
Wx_Font::SetUnderlined( underlined )
    bool underlined

void
Wx_Font::SetWeight( weight )
    int weight
