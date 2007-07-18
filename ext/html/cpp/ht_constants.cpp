/////////////////////////////////////////////////////////////////////////////
// Name:        ext/html/cpp/ht_constants.cpp
// Purpose:     constants for Wx::Html
// Author:      Mattia Barbon
// Modified by:
// Created:     21/03/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001, 2003-2006 Mattia Barbon
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
    case 'E':
        r( wxEVT_COMMAND_HTML_CELL_CLICKED );
        r( wxEVT_COMMAND_HTML_CELL_HOVER );
        r( wxEVT_COMMAND_HTML_LINK_CLICKED );
        break;

    case 'H':
        r( wxHF_TOOLBAR );
        r( wxHF_FLATTOOLBAR );
        r( wxHF_FLAT_TOOLBAR );
        r( wxHF_CONTENTS );
        r( wxHF_INDEX );
        r( wxHF_SEARCH );
        r( wxHF_BOOKMARKS );
        r( wxHF_OPENFILES );
        r( wxHF_OPEN_FILES );
        r( wxHF_PRINT );
        r( wxHF_DEFAULTSTYLE );
        r( wxHF_MERGE_BOOKS );
        r( wxHF_ICONS_BOOK );
        r( wxHF_ICONS_BOOK_CHAPTER );
        r( wxHF_ICONS_FOLDER );

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
        r( wxHW_NO_SELECTION );
#endif
        r( wxHW_SCROLLBAR_NEVER );

        r( wxHTML_ALIGN_LEFT );
        r( wxHTML_ALIGN_CENTER );
        r( wxHTML_ALIGN_RIGHT );
        r( wxHTML_ALIGN_BOTTOM );
        r( wxHTML_ALIGN_TOP );

        r( wxHTML_CLR_FOREGROUND );
        r( wxHTML_CLR_BACKGROUND );

        r( wxHTML_UNITS_PIXELS );
        r( wxHTML_UNITS_PERCENT );

        r( wxHTML_INDENT_LEFT );
        r( wxHTML_INDENT_RIGHT );
        r( wxHTML_INDENT_TOP );
        r( wxHTML_INDENT_BOTTOM );

        r( wxHTML_INDENT_HORIZONTAL );
        r( wxHTML_INDENT_VERTICAL );
        r( wxHTML_INDENT_ALL );

        r( wxHTML_COND_ISANCHOR );
        r( wxHTML_COND_ISIMAGEMAP );
        r( wxHTML_COND_USER );

#if WXPERL_W_VERSION_GE( 2, 5, 1 )
        r( wxHTML_FIND_EXACT );
        r( wxHTML_FIND_NEAREST_BEFORE );
        r( wxHTML_FIND_NEAREST_AFTER );
#endif

#if WXPERL_W_VERSION_LT( 2, 7, 0 )
        r( wxHTML_FONT_SIZE_1 );
        r( wxHTML_FONT_SIZE_2 );
        r( wxHTML_FONT_SIZE_3 );
        r( wxHTML_FONT_SIZE_4 );
        r( wxHTML_FONT_SIZE_5 );
        r( wxHTML_FONT_SIZE_6 );
        r( wxHTML_FONT_SIZE_7 );
#endif
        break;
    case 'P':
#if wxPERL_USE_PRINTING_ARCHITECTURE
        r( wxPAGE_ODD );
        r( wxPAGE_EVEN );
        r( wxPAGE_ALL );
#endif
        break;
    }
#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants html_module( &html_constant );
