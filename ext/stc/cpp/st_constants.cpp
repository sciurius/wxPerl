/////////////////////////////////////////////////////////////////////////////
// Name:        st_constants.cpp
// Purpose:     constants for Wx::STC
// Author:      Marcus Friedlaender and Mattia Barbon
// Created:     23/ 5/2002
// RCS-ID:
// Copyright:   (c) 2002 Marcus Friedlaender and Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

double stc_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: stc
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();
    if( strlen( name ) >= 7 )
        fl = name[6];
    else
        fl = 0;

    switch( fl )
    {
    case 'E':
        r( wxSTC_EOL_CR );
        r( wxSTC_EOL_LF );
        r( wxSTC_EOL_CRLF );
        break;
    case 'H':
        r( wxSTC_H_DEFAULT );
        r( wxSTC_H_TAG );
        r( wxSTC_H_TAGUNKNOWN );
        r( wxSTC_H_ATTRIBUTE );
        r( wxSTC_H_ATTRIBUTEUNKNOWN );
        r( wxSTC_H_NUMBER );
        r( wxSTC_H_DOUBLESTRING );
        r( wxSTC_H_SINGLESTRING );
        r( wxSTC_H_OTHER );
        r( wxSTC_H_COMMENT );
        r( wxSTC_H_ENTITY );
        break;
    case 'L':
        r( wxSTC_LEX_PERL );
        r( wxSTC_LEX_XML );
        r( wxSTC_LEX_HTML );
        break;
	case 'S':
        r( wxSTC_STYLE_DEFAULT );
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants stc_module( &stc_constant );
