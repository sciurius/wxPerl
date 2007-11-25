#############################################################################
## Name:        XS/FontMapper.xs
## Purpose:     XS for Wx::FontMapper
## Author:      Mattia Barbon
## Modified by:
## Created:     13/09/2002
## RCS-ID:      $Id$
## Copyright:   (c) 2002-2003, 2006-2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/fontmap.h>

MODULE=Wx PACKAGE=Wx::FontMapper

wxFontMapper*
Get()
  CODE:
    RETVAL = wxFontMapper::Get();
  OUTPUT: RETVAL

void
wxFontMapper::GetAltForEncoding( encoding, facename = wxEmptyString, interactive = true )
    wxFontEncoding encoding
    wxString facename
    bool interactive
  PREINIT:
    wxFontEncoding retval;
    bool result;
  PPCODE:
    result = THIS->GetAltForEncoding( encoding, &retval, facename,
                                      interactive );
    EXTEND( SP, 2 );
    PUSHs( boolSV( result ) );
    PUSHs( sv_2mortal( newSViv( retval ) ) );

bool
wxFontMapper::IsEncodingAvailable( encoding, facename = wxEmptyString )
    wxFontEncoding encoding
    wxString facename

wxFontEncoding
wxFontMapper::CharsetToEncoding( charset, interactive = true )
    wxString charset
    bool interactive

wxString
GetEncodingName( encoding )
    wxFontEncoding encoding
  CODE:
    RETVAL = wxFontMapper::GetEncodingName( encoding );
  OUTPUT: RETVAL

wxString
GetEncodingDescription( encoding )
    wxFontEncoding encoding
  CODE:
    RETVAL = wxFontMapper::GetEncodingDescription( encoding );
  OUTPUT: RETVAL

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

void
GetAllEncodingNames( encoding )
    wxFontEncoding encoding
  PPCODE:
    const wxChar** encodings = wxFontMapper::GetAllEncodingNames( encoding );
    if( !encodings )
        return;
    while( *encodings )
    {
        XPUSHs( wxPli_wxChar_2_sv( aTHX_ *encodings, sv_newmortal() ) );
        ++encodings;        
    }

#endif

wxFontEncoding
wxFontMapper::GetEncoding( n )
    size_t n
  CODE:
    RETVAL = wxFontMapper::GetEncoding( n );
  OUTPUT: RETVAL

wxFontEncoding
wxFontMapper::GetEncodingFromName( encoding )
    wxString encoding
  CODE:
    RETVAL = wxFontMapper::GetEncodingFromName( encoding );
  OUTPUT: RETVAL

size_t
wxFontMapper::GetSupportedEncodingsCount()
  CODE:
    RETVAL = wxFontMapper::GetSupportedEncodingsCount();
  OUTPUT: RETVAL

void
wxFontMapper::SetDialogParent( parent )
    wxWindow* parent

void
wxFontMapper::SetDialogTitle( title )
    wxString title

#if WXPERL_W_VERSION_LT( 2, 7, 0 )

void
wxFontMapper::SetConfig( config )
    wxConfigBase* config

#endif

void
wxFontMapper::SetConfigPath( path )
    wxString path
