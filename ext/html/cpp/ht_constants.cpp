/////////////////////////////////////////////////////////////////////////////
// Name:        ht_constants.cpp
// Purpose:     constants for Wx::Html
// Author:      Mattia Barbon
// Modified by:
// Created:     21/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

double html_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: html
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'H':
        r( wxHF_TOOLBAR );
        r( wxHF_FLATTOOLBAR );
#if WXPERL_W_VERSION_GE( 2, 3, 1 )
        r( wxHF_FLAT_TOOLBAR );
#endif
        r( wxHF_CONTENTS );
        r( wxHF_INDEX );
        r( wxHF_SEARCH );
        r( wxHF_BOOKMARKS );
        r( wxHF_OPENFILES );
#if WXPERL_W_VERSION_GE( 2, 3, 1 )
        r( wxHF_OPEN_FILES );
#endif
        r( wxHF_PRINT );
        r( wxHF_DEFAULTSTYLE );
#if WXPERL_W_VERSION_GE( 2, 3, 1 )
        r( wxHF_MERGE_BOOKS );
        r( wxHF_ICONS_BOOK );
        r( wxHF_ICONS_BOOK_CHAPTER );
        r( wxHF_ICONS_FOLDER );
#endif
        break;
    case 'P':
        r( wxPAGE_ODD );
        r( wxPAGE_EVEN );
        r( wxPAGE_ALL );
        break;
    }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants html_module( &html_constant );
