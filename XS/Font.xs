#############################################################################
## Name:        XS/Font.xs
## Purpose:     XS for Wx::Font
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: Font.xs,v 1.21 2004/07/10 13:16:46 mbarbon Exp $
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::NativeFontInfo

#include <wx/fontutil.h>

#undef THIS

wxNativeFontInfo*
wxNativeFontInfo::new()

## XXX threads
void
wxNativeFontInfo::DESTROY()

bool
wxNativeFontInfo::FromString( string )
    wxString string

wxString
wxNativeFontInfo::ToString()

MODULE=Wx PACKAGE=Wx::Font

void
wxFont::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wfon, newFont )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_b_s_n, newLong, 4 )
        MATCH_REDISP( wxPliOvl_s, newNativeInfo )
    END_OVERLOAD( Wx::Font::new )

wxFont*
newNativeInfo( CLASS, info )
    SV* CLASS
    wxString info
  CODE:
#if defined(__WXMOTIF__) || defined(__WXX11__)
    wxNativeFontInfo fontinfo;
    fontinfo.FromString( info );
    RETVAL = new wxFont( fontinfo );
#else
    RETVAL = new wxFont( info );
#endif
  OUTPUT: RETVAL

wxFont*
newFont( CLASS, font )
    SV* CLASS
    wxFont* font
  CODE:
    RETVAL = new wxFont( *font );
  OUTPUT: RETVAL

wxFont*
newLong( CLASS, pointsize, family, style, weight, underline = FALSE, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
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
wxFont::DESTROY()

int
font_spaceship( fnt1, fnt2, ... )
    SV* fnt1
    SV* fnt2
  CODE:
    // this is not a proper spaceship method
    // it just allows autogeneration of != and ==
    // anyway, comparing fontss is just useless
    RETVAL = -1;
    if( SvROK( fnt1 ) && SvROK( fnt2 ) &&
        sv_derived_from( fnt1, "Wx::Font" ) &&
        sv_derived_from( fnt2, "Wx::Font" ) )
    {
        wxFont* font1 = (wxFont*)wxPli_sv_2_object( aTHX_ fnt1, "Wx::Font" );
        wxFont* font2 = (wxFont*)wxPli_sv_2_object( aTHX_ fnt2, "Wx::Font" );

        RETVAL = *font1 == *font2 ? 0 : 1;
    }
    else
      RETVAL = 1;
  OUTPUT:
    RETVAL

wxFontEncoding
GetDefaultEncoding()
  CODE:
    RETVAL = wxFont::GetDefaultEncoding();
  OUTPUT:
    RETVAL

wxString
wxFont::GetFaceName()

int
wxFont::GetFamily()

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxNativeFontInfo*
wxFont::GetNativeFontInfo()
  CODE:
    RETVAL = new wxNativeFontInfo( *(THIS->GetNativeFontInfo()) );
  OUTPUT: RETVAL

#else

wxNativeFontInfo*
wxFont::GetNativeFontInfo()

#endif

wxString
wxFont::GetNativeFontInfoDesc()

int
wxFont::GetPointSize()

int
wxFont::GetStyle()

bool
wxFont::GetUnderlined()

int
wxFont::GetWeight()

bool
wxFont::IsFixedWidth()

bool
wxFont::Ok()

void
SetDefaultEncoding( encoding )
    wxFontEncoding encoding
  CODE:
    wxFont::SetDefaultEncoding( encoding );

void
wxFont::SetFaceName( faceName )
    wxString faceName

void
wxFont::SetFamily( family )
    int family

void
wxFont::SetNativeFontInfo( info )
    wxString info
  CODE:
    THIS->wxFontBase::SetNativeFontInfo( info );

##void
##wxFont::SetNativeFontInfo( info )
##    wxString info
##  CODE:
##    THIS->SetNativeFontInfo( info );

void
wxFont::SetPointSize( pointsize )
    int pointsize

void
wxFont::SetStyle( style )
    int style

void
wxFont::SetUnderlined( underlined )
    bool underlined

void
wxFont::SetWeight( weight )
    int weight
