#############################################################################
## Name:        XS/Font.xs
## Purpose:     XS for Wx::Font
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2004, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::NativeFontInfo

#include <wx/fontutil.h>

#undef THIS

wxNativeFontInfo*
wxNativeFontInfo::new()

static void
wxNativeFontInfo::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxNativeFontInfo::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::NativeFontInfo", THIS, ST(0) );
    delete THIS;

bool
wxNativeFontInfo::FromString( string )
    wxString string

wxString
wxNativeFontInfo::ToString()

bool
wxNativeFontInfo::FromUserString( string )
    wxString string

wxString
wxNativeFontInfo::ToUserString()

MODULE=Wx PACKAGE=Wx::Font

void
wxFont::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wfon, newFont )
#if defined(__WXMSW__) && WXPERL_W_VERSION_GE( 2, 5, 3 )     
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wsiz_n_n_n_b_s_n, newSize, 4 )
#endif
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
newLong( CLASS, pointsize, family, style, weight, underline = false, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
    int pointsize
    int family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxFont( pointsize, family, style, weight, underline,
		         faceName, encoding );
#else
    RETVAL = new wxFont( pointsize, (wxFontFamily)family, (wxFontStyle)style,
			 (wxFontWeight)weight, underline,
			 faceName, (wxFontEncoding)encoding );
#endif
  OUTPUT: RETVAL
  
#if defined(__WXMSW__) && WXPERL_W_VERSION_GE( 2, 5, 3 )     

wxFont*
newSize( CLASS, size, family, style, weight, underline = false, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
    wxSize size
    int family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxFont( size, family, style, weight, underline, faceName, encoding );
#else
    RETVAL = new wxFont( size, (wxFontFamily)family, (wxFontStyle)style,
			 (wxFontWeight)weight, underline,
			 faceName, encoding );
#endif
OUTPUT: RETVAL
  
#endif

## // static constructors
## // put correct static functions first - they will not match 
## // method calls which appear to have wxFont as first param

void
New( ... )
  PPCODE:
    BEGIN_OVERLOAD()
#if WXPERL_W_VERSION_GE( 2, 5, 3 )    
        MATCH_REDISP_COUNT_ALLOWMORE_FUNCTION( wxPliOvl_wsiz_n_n_n_b_s_n, Wx::Font::NewSizeStatic, 4 )
        MATCH_REDISP_COUNT_ALLOWMORE_FUNCTION( wxPliOvl_wsiz_n_n_s_n, Wx::Font::NewSizeFlagsStatic, 2 )
#endif
        MATCH_REDISP_COUNT_ALLOWMORE_FUNCTION( wxPliOvl_n_n_n_n_b_s_n, Wx::Font::NewPointStatic, 4 )
        MATCH_REDISP_COUNT_ALLOWMORE_FUNCTION( wxPliOvl_n_n_n_s_n, Wx::Font::NewPointFlagsStatic, 2 )    
#if WXPERL_W_VERSION_GE( 2, 5, 3 )    
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wsiz_n_n_n_b_s_n, NewSize, 4 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wsiz_n_n_s_n, NewSizeFlags, 2 )
#endif
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_b_s_n, NewPoint, 4 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_s_n, NewPointFlags, 2 )
    END_OVERLOAD( Wx::Font::New )

wxFont*
NewPoint( CLASS, pointsize, family, style, weight, underline = false, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
    int pointsize
    wxFontFamily family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxFont( pointsize, family, style, weight, underline,
		         faceName, encoding );
#else
    RETVAL = new wxFont( pointsize, family, (wxFontStyle)style,
			 (wxFontWeight)weight, underline,
			 faceName, encoding );
#endif
  OUTPUT: RETVAL
  
wxFont*
NewPointFlags( CLASS, pointsize, family, flags = wxFONTFLAG_DEFAULT, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
    int pointsize
    wxFontFamily family
    int flags
    wxString faceName
    wxFontEncoding encoding
  CODE:
    RETVAL = wxFont::New( pointsize, family, flags, faceName, encoding );
  OUTPUT: RETVAL  

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxFont*
NewSize( CLASS, size, family, style, weight, underline = false, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
    wxSize size
    wxFontFamily family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = wxFont::New( size, family, style, weight, underline, faceName, encoding );
#else
RETVAL = wxFont::New( size, family, (wxFontStyle)style,
		      (wxFontWeight)weight, underline, faceName,
		      encoding );
#endif
  OUTPUT: RETVAL
  
wxFont*
NewSizeFlags( CLASS, size, family, flags = wxFONTFLAG_DEFAULT, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    SV* CLASS
    wxSize size
    wxFontFamily family
    int flags
    wxString faceName
    wxFontEncoding encoding
  CODE:
    RETVAL = wxFont::New( size, family, flags, faceName, encoding );
  OUTPUT: RETVAL  

#endif

wxFont*
NewPointStatic( pointsize, family, style, weight, underline = false, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    int pointsize
    wxFontFamily family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxFont( pointsize, family, style, weight, underline,
		         faceName, encoding );
#else
    RETVAL = new wxFont( pointsize, family, (wxFontStyle)style,
			 (wxFontWeight)weight, underline,
			 faceName, encoding );
#endif
  OUTPUT: RETVAL
  
wxFont*
NewPointFlagsStatic( pointsize, family, flags = wxFONTFLAG_DEFAULT, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    int pointsize
    wxFontFamily family
    int flags
    wxString faceName
    wxFontEncoding encoding
  CODE:
    RETVAL = wxFont::New( pointsize, family, flags, faceName, encoding );
  OUTPUT: RETVAL  

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxFont*
NewSizeStatic( size, family, style, weight, underline = false, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    wxSize size
    wxFontFamily family
    int style
    int weight
    bool underline
    wxString faceName
    wxFontEncoding encoding
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxFont( size, family, style, weight, underline, faceName, encoding );
#else
    RETVAL = new wxFont( size, family, (wxFontStyle)style,
			 (wxFontWeight)weight, underline,
			 faceName, encoding );
#endif
  OUTPUT: RETVAL
  
wxFont*
NewSizeFlagsStatic( size, family, flags = wxFONTFLAG_DEFAULT, faceName = wxEmptyString, encoding = wxFONTENCODING_DEFAULT )
    wxSize size
    wxFontFamily family
    int flags
    wxString faceName
    wxFontEncoding encoding
  CODE:
    RETVAL = wxFont::New( size, family, flags, faceName, encoding );
  OUTPUT: RETVAL  

#endif

static void
wxFont::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxFont::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Font", THIS, ST(0) );
    delete THIS;

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

void
wxFont::SetNativeFontInfoUserDesc( info )
    wxString info

wxString
wxFont::GetFamilyString()
    
wxString
wxFont::GetStyleString()

wxString
wxFont::GetWeightString()

wxString
wxFont::GetNativeFontInfoDesc()

wxString
wxFont::GetNativeFontInfoUserDesc()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxSize*
wxFont::GetPixelSize()
  CODE:
    RETVAL = new wxSize( THIS->GetPixelSize() );
  OUTPUT:
    RETVAL
    
#endif    
    
wxFontEncoding
wxFont::GetEncoding()

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

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
wxFont::IsOk()

#endif

void
SetDefaultEncoding( encoding )
    wxFontEncoding encoding
  CODE:
    wxFont::SetDefaultEncoding( encoding );

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

bool
wxFont::SetFaceName( faceName )
    wxString faceName

#else

void
wxFont::SetFaceName( faceName )
    wxString faceName

#endif

void
wxFont::SetEncoding( encoding )
    wxFontEncoding encoding

#if WXPERL_W_VERSION_LT( 3, 2, 0 )
void
wxFont::SetFamily( family )
    int family
#else
void
wxFont::SetFamily( family )
    wxFontFamily family
#endif

void
wxFont::SetNativeFontInfo( info )
    wxString info
  CODE:
    THIS->SetNativeFontInfo( info );

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxFont::SetPixelSize( pixelsize )
    wxSize pixelsize
    
bool
wxFont::IsUsingSizeInPixels()    
    
#endif    

void
wxFont::SetPointSize( pointsize )
    int pointsize

#if WXPERL_W_VERSION_LT( 3, 2, 0 )
void
wxFont::SetStyle( style )
    int style
#else
void
wxFont::SetStyle( style )
    wxFontStyle style
#endif

void
wxFont::SetUnderlined( underlined )
    bool underlined

#if WXPERL_W_VERSION_LT( 3, 2, 0 )
void
wxFont::SetWeight( weight )
    int weight
#else
void
wxFont::SetWeight( weight )
    wxFontWeight weight
#endif
