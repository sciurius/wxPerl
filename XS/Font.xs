#############################################################################
## Name:        Font.xs
## Purpose:     XS for Wx::Font
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::NativeFontInfo

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

#include <wx/fontutil.h>

#undef THIS

Wx_NativeFontInfo*
Wx_NativeFontInfo::new()

## XXX threads
void
Wx_NativeFontInfo::DESTROY()

bool
Wx_NativeFontInfo::FromString( string )
    wxString string

wxString
Wx_NativeFontInfo::ToString()

#endif

MODULE=Wx PACKAGE=Wx::Font

wxFont*
wxFont::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wfon, newFont )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_b_s_n, newLong, 4 )
        MATCH_REDISP( wxPliOvl_s, newNativeInfo )
    END_OVERLOAD( Wx::Font::new )

#if WXPERL_W_VERSION_GE( 2, 4, 0 )

wxFont*
newNativeInfo( CLASS, info )
    SV* CLASS
    wxString info
  CODE:
    RETVAL = new wxFont( info );
  OUTPUT: RETVAL

#endif

wxFont*
newFont( CLASS, font )
    SV* CLASS
    wxFont* font
  CODE:
    RETVAL = new wxFont( *font );
  OUTPUT: RETVAL

wxFont*
newLong( pointsize, family, style, weight, underline = FALSE, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    int pointsize
    int family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
    RETVAL = new wxFont( pointsize, family, style, weight, underline,
                         faceName, encoding );
  OUTPUT: RETVAL

## XXX threads
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

#if defined( __WXMSW__ ) && WXPERL_W_VERSION_LE( 2, 3, 2 ) || defined( __WXPERL_FORCE__ )

int
Wx_Font::GetFontId()

#endif

#if WXPERL_W_VERSION_GE( 2, 4, 0 )

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

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

bool
Wx_Font::IsFixedWidth()

bool
Wx_Font::Ok()

#endif

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

#if WXPERL_W_VERSION_GE( 2, 4, 0 )

void
Wx_Font::SetNativeFontInfo( info )
    wxString info
  CODE:
    THIS->wxFontBase::SetNativeFontInfo( info );

#endif

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

##void
##Wx_Font::SetNativeFontInfo( info )
##    wxString info
##  CODE:
##    THIS->SetNativeFontInfo( info );

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
