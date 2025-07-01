/////////////////////////////////////////////////////////////////////////////
// Name:        ext/stc/cpp/st_constants.cpp
// Purpose:     constants for Wx::STC
// Author:      Marcus Friedlaender and Mattia Barbon
// Created:     23/05/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002-2006, 2008, 2010 Marcus Friedlaender and Mattia Barbon
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
    case '4':
#if WXPERL_W_VERSION_GE( 2, 9, 0 ) && WXPERL_W_VERSION_LE( 3, 1, 0)
        r( wxSTC_4GL_BLOCK );
        r( wxSTC_4GL_BLOCK_ );
        r( wxSTC_4GL_CHARACTER );
        r( wxSTC_4GL_CHARACTER_ );
        r( wxSTC_4GL_COMMENT1 );
        r( wxSTC_4GL_COMMENT1_ );
        r( wxSTC_4GL_COMMENT2 );
        r( wxSTC_4GL_COMMENT2_ );
        r( wxSTC_4GL_COMMENT3 );
        r( wxSTC_4GL_COMMENT3_ );
        r( wxSTC_4GL_COMMENT4 );
        r( wxSTC_4GL_COMMENT4_ );
        r( wxSTC_4GL_COMMENT5 );
        r( wxSTC_4GL_COMMENT5_ );
        r( wxSTC_4GL_COMMENT6 );
        r( wxSTC_4GL_COMMENT6_ );
        r( wxSTC_4GL_DEFAULT );
        r( wxSTC_4GL_DEFAULT_ );
        r( wxSTC_4GL_END );
        r( wxSTC_4GL_END_ );
        r( wxSTC_4GL_IDENTIFIER );
        r( wxSTC_4GL_IDENTIFIER_ );
        r( wxSTC_4GL_NUMBER );
        r( wxSTC_4GL_NUMBER_ );
        r( wxSTC_4GL_OPERATOR );
        r( wxSTC_4GL_OPERATOR_ );
        r( wxSTC_4GL_PREPROCESSOR );
        r( wxSTC_4GL_PREPROCESSOR_ );
        r( wxSTC_4GL_STRING );
        r( wxSTC_4GL_STRING_ );
        r( wxSTC_4GL_WORD );
        r( wxSTC_4GL_WORD_ );
#endif
        break;
    case 'A':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_A68K_DEFAULT );
        r( wxSTC_A68K_COMMENT );
        r( wxSTC_A68K_NUMBER_DEC );
        r( wxSTC_A68K_NUMBER_BIN );
        r( wxSTC_A68K_NUMBER_HEX );
        r( wxSTC_A68K_STRING1 );
        r( wxSTC_A68K_OPERATOR );
        r( wxSTC_A68K_CPUINSTRUCTION );
        r( wxSTC_A68K_EXTINSTRUCTION );
        r( wxSTC_A68K_REGISTER );
        r( wxSTC_A68K_DIRECTIVE );
        r( wxSTC_A68K_MACRO_ARG );
        r( wxSTC_A68K_LABEL );
        r( wxSTC_A68K_STRING2 );
        r( wxSTC_A68K_IDENTIFIER );
        r( wxSTC_A68K_MACRO_DECLARATION );
        r( wxSTC_A68K_COMMENT_WORD );
        r( wxSTC_A68K_COMMENT_SPECIAL );
        r( wxSTC_A68K_COMMENT_DOXYGEN );
        r( wxSTC_ASM_COMMENTDIRECTIVE );
        r( wxSTC_AVS_DEFAULT );
        r( wxSTC_AVS_COMMENTBLOCK );
        r( wxSTC_AVS_COMMENTBLOCKN );
        r( wxSTC_AVS_COMMENTLINE );
        r( wxSTC_AVS_NUMBER );
        r( wxSTC_AVS_OPERATOR );
        r( wxSTC_AVS_IDENTIFIER );
        r( wxSTC_AVS_STRING );
        r( wxSTC_AVS_TRIPLESTRING );
        r( wxSTC_AVS_KEYWORD );
        r( wxSTC_AVS_FILTER );
        r( wxSTC_AVS_PLUGIN );
        r( wxSTC_AVS_FUNCTION );
        r( wxSTC_AVS_CLIPPROP );
        r( wxSTC_AVS_USERDFN );
#endif        
        r( wxSTC_AVE_DEFAULT );
        r( wxSTC_AVE_COMMENT );
        r( wxSTC_AVE_NUMBER );
        r( wxSTC_AVE_WORD );
        r( wxSTC_AVE_STRING );
        r( wxSTC_AVE_ENUM );
        r( wxSTC_AVE_STRINGEOL );
        r( wxSTC_AVE_IDENTIFIER );
        r( wxSTC_AVE_OPERATOR );
        r( wxSTC_ADA_DEFAULT );
        r( wxSTC_ADA_NUMBER );
        r( wxSTC_ADA_WORD );
        r( wxSTC_ADA_STRING );
        r( wxSTC_ADA_CHARACTER );
        r( wxSTC_ADA_IDENTIFIER );
        r( wxSTC_ADA_STRINGEOL );
        r( wxSTC_ASM_DEFAULT );
        r( wxSTC_ASM_COMMENT );
        r( wxSTC_ASM_NUMBER );
        r( wxSTC_ASM_STRING );
        r( wxSTC_ASM_OPERATOR );
        r( wxSTC_ASM_IDENTIFIER );
        r( wxSTC_ASM_CPUINSTRUCTION );
        r( wxSTC_ASM_MATHINSTRUCTION );
        r( wxSTC_ASM_REGISTER );
        r( wxSTC_ASM_DIRECTIVE );
        r( wxSTC_ASM_DIRECTIVEOPERAND );
#if WXPERL_W_VERSION_GE( 2, 5, 2 )
        r( wxSTC_ASM_COMMENTBLOCK );
        r( wxSTC_ASM_CHARACTER );
        r( wxSTC_ASM_STRINGEOL );
        r( wxSTC_ASM_EXTINSTRUCTION );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_ABAQUS_ARGUMENT );
        r( wxSTC_ABAQUS_COMMAND );
        r( wxSTC_ABAQUS_COMMENT );
        r( wxSTC_ABAQUS_COMMENTBLOCK );
        r( wxSTC_ABAQUS_DEFAULT );
        r( wxSTC_ABAQUS_FUNCTION );
        r( wxSTC_ABAQUS_NUMBER );
        r( wxSTC_ABAQUS_OPERATOR );
        r( wxSTC_ABAQUS_PROCESSOR );
        r( wxSTC_ABAQUS_SLASHCOMMAND );
        r( wxSTC_ABAQUS_STARCOMMAND );
        r( wxSTC_ABAQUS_STRING );
        r( wxSTC_ABAQUS_WORD );
#endif
        r( wxSTC_ADA_CHARACTEREOL );
        r( wxSTC_ADA_COMMENTLINE );
        r( wxSTC_ADA_DELIMITER );
        r( wxSTC_ADA_ILLEGAL );
        r( wxSTC_ADA_LABEL );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_ALPHA_NOALPHA );
        r( wxSTC_ALPHA_OPAQUE );
        r( wxSTC_ALPHA_TRANSPARENT );
#endif
        r( wxSTC_APDL_COMMAND );
        r( wxSTC_APDL_COMMENT );
        r( wxSTC_APDL_COMMENTBLOCK );
        r( wxSTC_APDL_DEFAULT );
        r( wxSTC_APDL_FUNCTION );
        r( wxSTC_APDL_NUMBER );
        r( wxSTC_APDL_PROCESSOR );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_APDL_ARGUMENT );
        r( wxSTC_APDL_OPERATOR );
        r( wxSTC_APDL_SLASHCOMMAND );
        r( wxSTC_APDL_STARCOMMAND );
#endif
        r( wxSTC_APDL_STRING );
        r( wxSTC_APDL_WORD );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_ASN1_ATTRIBUTE );
        r( wxSTC_ASN1_COMMENT );
        r( wxSTC_ASN1_DEFAULT );
        r( wxSTC_ASN1_DESCRIPTOR );
        r( wxSTC_ASN1_IDENTIFIER );
        r( wxSTC_ASN1_KEYWORD );
        r( wxSTC_ASN1_OID );
        r( wxSTC_ASN1_OPERATOR );
        r( wxSTC_ASN1_SCALAR );
        r( wxSTC_ASN1_STRING );
        r( wxSTC_ASN1_TYPE );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_ASY_CHARACTER );
        r( wxSTC_ASY_COMMENT );
        r( wxSTC_ASY_COMMENTLINE );
        r( wxSTC_ASY_COMMENTLINEDOC );
        r( wxSTC_ASY_DEFAULT );
        r( wxSTC_ASY_IDENTIFIER );
        r( wxSTC_ASY_NUMBER );
        r( wxSTC_ASY_OPERATOR );
        r( wxSTC_ASY_STRING );
        r( wxSTC_ASY_STRINGEOL );
        r( wxSTC_ASY_WORD );
        r( wxSTC_ASY_WORD2 );
#endif
        r( wxSTC_AU3_COMMENT );
        r( wxSTC_AU3_COMMENTBLOCK );
        r( wxSTC_AU3_DEFAULT );
        r( wxSTC_AU3_FUNCTION );
        r( wxSTC_AU3_KEYWORD );
        r( wxSTC_AU3_MACRO );
        r( wxSTC_AU3_NUMBER );
        r( wxSTC_AU3_OPERATOR );
        r( wxSTC_AU3_PREPROCESSOR );
        r( wxSTC_AU3_SENT );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_AU3_SPECIAL );
#endif
        r( wxSTC_AU3_STRING );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_AU3_COMOBJ );
        r( wxSTC_AU3_EXPAND );
        r( wxSTC_AU3_UDF );
#endif
        r( wxSTC_AU3_VARIABLE );
        r( wxSTC_AVE_WORD1 );
        r( wxSTC_AVE_WORD2 );
        r( wxSTC_AVE_WORD3 );
        r( wxSTC_AVE_WORD4 );
        r( wxSTC_AVE_WORD5 );
        r( wxSTC_AVE_WORD6 );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_ANNOTATION_HIDDEN );
        r( wxSTC_ANNOTATION_STANDARD );
        r( wxSTC_ANNOTATION_BOXED );
#endif
        break;
    case 'B':
        r( wxSTC_B_DEFAULT );
        r( wxSTC_B_COMMENT );
        r( wxSTC_B_NUMBER );
        r( wxSTC_B_KEYWORD );
        r( wxSTC_B_STRING );
        r( wxSTC_B_PREPROCESSOR );
        r( wxSTC_B_OPERATOR );
        r( wxSTC_B_IDENTIFIER );
        r( wxSTC_B_DATE );
        r( wxSTC_BAT_DEFAULT );
        r( wxSTC_BAT_COMMENT );
        r( wxSTC_BAT_WORD );
        r( wxSTC_BAT_LABEL );
        r( wxSTC_BAT_HIDE );
        r( wxSTC_BAT_COMMAND );
        r( wxSTC_BAT_IDENTIFIER );
        r( wxSTC_BAT_OPERATOR );
        r( wxSTC_BAAN_DEFAULT );
        r( wxSTC_BAAN_COMMENT );
        r( wxSTC_BAAN_COMMENTDOC );
        r( wxSTC_BAAN_NUMBER );
        r( wxSTC_BAAN_WORD );
        r( wxSTC_BAAN_STRING );
        r( wxSTC_BAAN_PREPROCESSOR );
        r( wxSTC_BAAN_OPERATOR );
        r( wxSTC_BAAN_IDENTIFIER );
        r( wxSTC_BAAN_STRINGEOL );
        r( wxSTC_BAAN_WORD2 );
        r( wxSTC_B_ASM );
        r( wxSTC_B_CONSTANT );
        r( wxSTC_B_KEYWORD2 );
        r( wxSTC_B_KEYWORD3 );
        r( wxSTC_B_KEYWORD4 );
        r( wxSTC_B_STRINGEOL );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_B_BINNUMBER );
        r( wxSTC_B_ERROR );
        r( wxSTC_B_HEXNUMBER );
        r( wxSTC_B_LABEL );
#endif
        break;
    case 'C':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_C_STRINGRAW );
        r( wxSTC_C_TRIPLEVERBATIM );
        r( wxSTC_C_HASHQUOTEDSTRING );
        r( wxSTC_C_PREPROCESSORCOMMENT );
        r( wxSTC_CASEINSENSITIVEBEHAVIOUR_RESPECTCASE );
        r( wxSTC_CASEINSENSITIVEBEHAVIOUR_IGNORECASE );
        r( wxSTC_CARETSTICKY_OFF );
        r( wxSTC_CARETSTICKY_ON );
        r( wxSTC_CARETSTICKY_WHITESPACE );
        r( wxSTC_COFFEESCRIPT_DEFAULT );
        r( wxSTC_COFFEESCRIPT_COMMENT );
        r( wxSTC_COFFEESCRIPT_COMMENTLINE );
        r( wxSTC_COFFEESCRIPT_COMMENTDOC );
        r( wxSTC_COFFEESCRIPT_NUMBER );
        r( wxSTC_COFFEESCRIPT_WORD );
        r( wxSTC_COFFEESCRIPT_STRING );
        r( wxSTC_COFFEESCRIPT_CHARACTER );
        r( wxSTC_COFFEESCRIPT_UUID );
        r( wxSTC_COFFEESCRIPT_PREPROCESSOR );
        r( wxSTC_COFFEESCRIPT_OPERATOR );
        r( wxSTC_COFFEESCRIPT_IDENTIFIER );
        r( wxSTC_COFFEESCRIPT_STRINGEOL );
        r( wxSTC_COFFEESCRIPT_VERBATIM );
        r( wxSTC_COFFEESCRIPT_REGEX );
        r( wxSTC_COFFEESCRIPT_COMMENTLINEDOC );
        r( wxSTC_COFFEESCRIPT_WORD2 );
        r( wxSTC_COFFEESCRIPT_COMMENTDOCKEYWORD );
        r( wxSTC_COFFEESCRIPT_COMMENTDOCKEYWORDERROR );
        r( wxSTC_COFFEESCRIPT_GLOBALCLASS );
        r( wxSTC_COFFEESCRIPT_STRINGRAW );
        r( wxSTC_COFFEESCRIPT_TRIPLEVERBATIM );
        r( wxSTC_COFFEESCRIPT_COMMENTBLOCK );
        r( wxSTC_COFFEESCRIPT_VERBOSE_REGEX );
        r( wxSTC_COFFEESCRIPT_VERBOSE_REGEX_COMMENT );
        r( wxSTC_CSS_MEDIA );
        r( wxSTC_CSS_VARIABLE );
        r( wxSTC_CURSORARROW );
        r( wxSTC_CURSORREVERSEARROW );
#endif        
        r( wxSTC_CHARSET_ANSI );
        r( wxSTC_CHARSET_DEFAULT );
        r( wxSTC_CHARSET_BALTIC );
        r( wxSTC_CHARSET_CHINESEBIG5 );
        r( wxSTC_CHARSET_EASTEUROPE );
        r( wxSTC_CHARSET_GB2312 );
        r( wxSTC_CHARSET_GREEK );
        r( wxSTC_CHARSET_HANGUL );
        r( wxSTC_CHARSET_MAC );
        r( wxSTC_CHARSET_OEM );
        r( wxSTC_CHARSET_RUSSIAN );
        r( wxSTC_CHARSET_SHIFTJIS );
        r( wxSTC_CHARSET_SYMBOL );
        r( wxSTC_CHARSET_TURKISH );
        r( wxSTC_CHARSET_JOHAB );
        r( wxSTC_CHARSET_HEBREW );
        r( wxSTC_CHARSET_ARABIC );
        r( wxSTC_CHARSET_VIETNAMESE );
        r( wxSTC_CHARSET_THAI );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_CHARSET_8859_15 );
        r( wxSTC_CHARSET_CYRILLIC );
#endif
        r( wxSTC_CASE_MIXED );
        r( wxSTC_CASE_UPPER );
        r( wxSTC_CASE_LOWER );
        r( wxSTC_CACHE_NONE );
        r( wxSTC_CACHE_CARET );
        r( wxSTC_CACHE_PAGE );
        r( wxSTC_CACHE_DOCUMENT );
        r( wxSTC_CURSORNORMAL );
        r( wxSTC_CURSORWAIT );
        r( wxSTC_CARET_SLOP );
        r( wxSTC_CARET_STRICT );
        r( wxSTC_CARET_JUMPS );
        r( wxSTC_CARET_EVEN );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_CARETSTYLE_BLOCK );
        r( wxSTC_CARETSTYLE_INVISIBLE );
        r( wxSTC_CARETSTYLE_LINE );
#endif
        r( wxSTC_C_DEFAULT );
        r( wxSTC_C_COMMENT );
        r( wxSTC_C_COMMENTLINE );
        r( wxSTC_C_COMMENTDOC );
        r( wxSTC_C_NUMBER );
        r( wxSTC_C_WORD );
        r( wxSTC_C_STRING );
        r( wxSTC_C_CHARACTER );
        r( wxSTC_C_UUID );
        r( wxSTC_C_PREPROCESSOR );
        r( wxSTC_C_OPERATOR );
        r( wxSTC_C_IDENTIFIER );
        r( wxSTC_C_STRINGEOL );
        r( wxSTC_C_VERBATIM );
        r( wxSTC_C_REGEX );
        r( wxSTC_C_COMMENTLINEDOC );
        r( wxSTC_C_WORD2 );
        r( wxSTC_C_COMMENTDOCKEYWORD );
        r( wxSTC_C_COMMENTDOCKEYWORDERROR );
        r( wxSTC_C_GLOBALCLASS );
        r( wxSTC_CONF_DEFAULT );
        r( wxSTC_CONF_COMMENT );
        r( wxSTC_CONF_NUMBER );
        r( wxSTC_CONF_IDENTIFIER );
        r( wxSTC_CONF_EXTENSION );
        r( wxSTC_CONF_PARAMETER );
        r( wxSTC_CONF_STRING );
        r( wxSTC_CONF_OPERATOR );
        r( wxSTC_CONF_IP );
        r( wxSTC_CONF_DIRECTIVE );
        r( wxSTC_CMD_REDO );
        r( wxSTC_CMD_SELECTALL );
        r( wxSTC_CMD_UNDO );
        r( wxSTC_CMD_CUT );
        r( wxSTC_CMD_COPY );
        r( wxSTC_CMD_PASTE );
        r( wxSTC_CMD_LINEDOWN );
        r( wxSTC_CMD_LINEDOWNEXTEND );
        r( wxSTC_CMD_LINEUP );
        r( wxSTC_CMD_LINEUPEXTEND );
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
        r( wxSTC_CMD_LINECOPY );
#endif
        r( wxSTC_CMD_CHARLEFT );
        r( wxSTC_CMD_CHARLEFTEXTEND );
        r( wxSTC_CMD_CHARRIGHT );
        r( wxSTC_CMD_CHARRIGHTEXTEND );
        r( wxSTC_CMD_WORDLEFT );
        r( wxSTC_CMD_WORDLEFTEXTEND );
        r( wxSTC_CMD_WORDRIGHT );
        r( wxSTC_CMD_WORDRIGHTEXTEND );
        r( wxSTC_CMD_HOME );
        r( wxSTC_CMD_HOMEEXTEND );
        r( wxSTC_CMD_LINEEND );
        r( wxSTC_CMD_LINEENDEXTEND );
        r( wxSTC_CMD_DOCUMENTSTART );
        r( wxSTC_CMD_DOCUMENTSTARTEXTEND );
        r( wxSTC_CMD_DOCUMENTEND );
        r( wxSTC_CMD_DOCUMENTENDEXTEND );
        r( wxSTC_CMD_PAGEUP );
        r( wxSTC_CMD_PAGEUPEXTEND );
        r( wxSTC_CMD_PAGEDOWN );
        r( wxSTC_CMD_PAGEDOWNEXTEND );
        r( wxSTC_CMD_PARADOWN );
        r( wxSTC_CMD_PARADOWNEXTEND );
        r( wxSTC_CMD_PARAUP );
        r( wxSTC_CMD_PARAUPEXTEND );
        r( wxSTC_CMD_EDITTOGGLEOVERTYPE );
        r( wxSTC_CMD_CANCEL );
        r( wxSTC_CMD_DELETEBACK );
        r( wxSTC_CMD_TAB );
        r( wxSTC_CMD_BACKTAB );
        r( wxSTC_CMD_NEWLINE );
        r( wxSTC_CMD_FORMFEED );
        r( wxSTC_CMD_VCHOME );
        r( wxSTC_CMD_VCHOMEEXTEND );
        r( wxSTC_CMD_ZOOMIN );
        r( wxSTC_CMD_ZOOMOUT );
        r( wxSTC_CMD_DELWORDLEFT );
        r( wxSTC_CMD_DELWORDRIGHT );
        r( wxSTC_CMD_LINECUT );
        r( wxSTC_CMD_LINEDELETE );
        r( wxSTC_CMD_LINETRANSPOSE );
        r( wxSTC_CMD_LOWERCASE );
        r( wxSTC_CMD_UPPERCASE );
        r( wxSTC_CMD_LINESCROLLDOWN );
        r( wxSTC_CMD_LINESCROLLUP );
        r( wxSTC_CMD_DELETEBACKNOTLINE );
        r( wxSTC_CMD_HOMEDISPLAY );
        r( wxSTC_CMD_HOMEDISPLAYEXTEND );
        r( wxSTC_CMD_LINEENDDISPLAY );
        r( wxSTC_CMD_LINEENDDISPLAYEXTEND );
        r( wxSTC_CMD_CLEAR );
        r( wxSTC_CMD_WORDPARTLEFT );
        r( wxSTC_CMD_WORDPARTLEFTEXTEND );
        r( wxSTC_CMD_WORDPARTRIGHT );
        r( wxSTC_CMD_WORDPARTRIGHTEXTEND );
        r( wxSTC_CMD_DELLINELEFT );
        r( wxSTC_CMD_DELLINERIGHT );
        r( wxSTC_CSS_DEFAULT );
        r( wxSTC_CSS_TAG );
        r( wxSTC_CSS_CLASS );
        r( wxSTC_CSS_PSEUDOCLASS );
        r( wxSTC_CSS_UNKNOWN_PSEUDOCLASS );
        r( wxSTC_CSS_OPERATOR );
        r( wxSTC_CSS_IDENTIFIER );
        r( wxSTC_CSS_UNKNOWN_IDENTIFIER );
        r( wxSTC_CSS_VALUE );
        r( wxSTC_CSS_COMMENT );
        r( wxSTC_CSS_ID );
        r( wxSTC_CSS_IMPORTANT );
        r( wxSTC_CSS_DIRECTIVE );
        r( wxSTC_CSS_DOUBLESTRING );
        r( wxSTC_CSS_SINGLESTRING );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_CSS_ATTRIBUTE );
#endif
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_CSS_IDENTIFIER2 );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_CSS_IDENTIFIER3 );
        r( wxSTC_CSS_PSEUDOELEMENT );
        r( wxSTC_CSS_EXTENDED_IDENTIFIER );
        r( wxSTC_CSS_EXTENDED_PSEUDOCLASS );
        r( wxSTC_CSS_EXTENDED_PSEUDOELEMENT );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_CAML_CHAR );
        r( wxSTC_CAML_COMMENT );
        r( wxSTC_CAML_COMMENT1 );
        r( wxSTC_CAML_COMMENT2 );
        r( wxSTC_CAML_COMMENT3 );
        r( wxSTC_CAML_DEFAULT );
        r( wxSTC_CAML_IDENTIFIER );
        r( wxSTC_CAML_KEYWORD );
        r( wxSTC_CAML_KEYWORD2 );
        r( wxSTC_CAML_KEYWORD3 );
        r( wxSTC_CAML_LINENUM );
        r( wxSTC_CAML_NUMBER );
        r( wxSTC_CAML_OPERATOR );
        r( wxSTC_CAML_STRING );
        r( wxSTC_CAML_TAGNAME );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_CAML_WHITE );
#endif
        r( wxSTC_CLW_ATTRIBUTE );
        r( wxSTC_CLW_BUILTIN_PROCEDURES_FUNCTION );
        r( wxSTC_CLW_COMMENT );
        r( wxSTC_CLW_COMPILER_DIRECTIVE );
        r( wxSTC_CLW_DEFAULT );
        r( wxSTC_CLW_ERROR );
        r( wxSTC_CLW_INTEGER_CONSTANT );
        r( wxSTC_CLW_KEYWORD );
        r( wxSTC_CLW_LABEL );
        r( wxSTC_CLW_PICTURE_STRING );
        r( wxSTC_CLW_REAL_CONSTANT );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_CLW_DEPRECATED );
        r( wxSTC_CLW_RUNTIME_EXPRESSIONS );
#endif
        r( wxSTC_CLW_STANDARD_EQUATE );
        r( wxSTC_CLW_STRING );
        r( wxSTC_CLW_STRUCTURE_DATA_TYPE );
        r( wxSTC_CLW_USER_IDENTIFIER );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_CMAKE_COMMANDS );
        r( wxSTC_CMAKE_COMMENT );
        r( wxSTC_CMAKE_DEFAULT );
        r( wxSTC_CMAKE_FOREACHDEF );
        r( wxSTC_CMAKE_IFDEFINEDEF );
        r( wxSTC_CMAKE_MACRODEF );
        r( wxSTC_CMAKE_NUMBER );
        r( wxSTC_CMAKE_PARAMETERS );
        r( wxSTC_CMAKE_STRINGDQ );
        r( wxSTC_CMAKE_STRINGLQ );
        r( wxSTC_CMAKE_STRINGRQ );
        r( wxSTC_CMAKE_STRINGVAR );
        r( wxSTC_CMAKE_USERDEFINED );
        r( wxSTC_CMAKE_VARIABLE );
        r( wxSTC_CMAKE_WHILEDEF );
#endif
        r( wxSTC_CMD_CHARLEFTRECTEXTEND );
        r( wxSTC_CMD_CHARRIGHTRECTEXTEND );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_CMD_DELWORDRIGHTEND );
#endif
        r( wxSTC_CMD_HOMERECTEXTEND );
        r( wxSTC_CMD_HOMEWRAP );
        r( wxSTC_CMD_HOMEWRAPEXTEND );
        r( wxSTC_CMD_LINEDOWNRECTEXTEND );
        r( wxSTC_CMD_LINEDUPLICATE );
        r( wxSTC_CMD_LINEENDRECTEXTEND );
        r( wxSTC_CMD_LINEENDWRAP );
        r( wxSTC_CMD_LINEENDWRAPEXTEND );
        r( wxSTC_CMD_LINEUPRECTEXTEND );
        r( wxSTC_CMD_PAGEDOWNRECTEXTEND );
        r( wxSTC_CMD_PAGEUPRECTEXTEND );
        r( wxSTC_CMD_STUTTEREDPAGEDOWN );
        r( wxSTC_CMD_STUTTEREDPAGEDOWNEXTEND );
        r( wxSTC_CMD_STUTTEREDPAGEUP );
        r( wxSTC_CMD_STUTTEREDPAGEUPEXTEND );
        r( wxSTC_CMD_VCHOMERECTEXTEND );
        r( wxSTC_CMD_VCHOMEWRAP );
        r( wxSTC_CMD_VCHOMEWRAPEXTEND );
        r( wxSTC_CMD_WORDLEFTEND );
        r( wxSTC_CMD_WORDLEFTENDEXTEND );
        r( wxSTC_CMD_WORDRIGHTEND );
        r( wxSTC_CMD_WORDRIGHTENDEXTEND );
#if WXPERL_W_VERSION_LT( 2, 9, 5 )
        r( wxSTC_CP_DBCS );
#endif        
        r( wxSTC_CP_UTF8 );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_CSOUND_ARATE_VAR );
        r( wxSTC_CSOUND_COMMENT );
        r( wxSTC_CSOUND_COMMENTBLOCK );
        r( wxSTC_CSOUND_DEFAULT );
        r( wxSTC_CSOUND_GLOBAL_VAR );
        r( wxSTC_CSOUND_HEADERSTMT );
        r( wxSTC_CSOUND_IDENTIFIER );
        r( wxSTC_CSOUND_INSTR );
        r( wxSTC_CSOUND_IRATE_VAR );
        r( wxSTC_CSOUND_KRATE_VAR );
        r( wxSTC_CSOUND_NUMBER );
        r( wxSTC_CSOUND_OPCODE );
        r( wxSTC_CSOUND_OPERATOR );
        r( wxSTC_CSOUND_PARAM );
        r( wxSTC_CSOUND_STRINGEOL );
        r( wxSTC_CSOUND_USERKEYWORD );
#endif
        break;
    case 'D':
        r( wxSTC_DIFF_DEFAULT );
        r( wxSTC_DIFF_COMMENT );
        r( wxSTC_DIFF_COMMAND );
        r( wxSTC_DIFF_HEADER );
        r( wxSTC_DIFF_POSITION );
        r( wxSTC_DIFF_DELETED );
        r( wxSTC_DIFF_ADDED );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )        
        r( wxSTC_DIFF_CHANGED );
#endif           
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_D_CHARACTER );
        r( wxSTC_D_COMMENT );
        r( wxSTC_D_COMMENTDOC );
        r( wxSTC_D_COMMENTDOCKEYWORD );
        r( wxSTC_D_COMMENTDOCKEYWORDERROR );
        r( wxSTC_D_COMMENTLINE );
        r( wxSTC_D_COMMENTLINEDOC );
        r( wxSTC_D_COMMENTNESTED );
        r( wxSTC_D_DEFAULT );
        r( wxSTC_D_IDENTIFIER );
        r( wxSTC_D_NUMBER );
        r( wxSTC_D_OPERATOR );
        r( wxSTC_D_STRING );
        r( wxSTC_D_STRINGEOL );
        r( wxSTC_D_TYPEDEF );
        r( wxSTC_D_WORD );
        r( wxSTC_D_WORD2 );
        r( wxSTC_D_WORD3 );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_D_STRINGR );
        r( wxSTC_D_WORD5 );
        r( wxSTC_D_WORD6 );
        r( wxSTC_D_WORD7 );
#endif
        break;
    case 'E':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_ECL_DEFAULT );
        r( wxSTC_ECL_COMMENT );
        r( wxSTC_ECL_COMMENTLINE );
        r( wxSTC_ECL_NUMBER );
        r( wxSTC_ECL_STRING );
        r( wxSTC_ECL_WORD0 );
        r( wxSTC_ECL_OPERATOR );
        r( wxSTC_ECL_CHARACTER );
        r( wxSTC_ECL_UUID );
        r( wxSTC_ECL_PREPROCESSOR );
        r( wxSTC_ECL_UNKNOWN );
        r( wxSTC_ECL_IDENTIFIER );
        r( wxSTC_ECL_STRINGEOL );
        r( wxSTC_ECL_VERBATIM );
        r( wxSTC_ECL_REGEX );
        r( wxSTC_ECL_COMMENTLINEDOC );
        r( wxSTC_ECL_WORD1 );
        r( wxSTC_ECL_COMMENTDOCKEYWORD );
        r( wxSTC_ECL_COMMENTDOCKEYWORDERROR );
        r( wxSTC_ECL_WORD2 );
        r( wxSTC_ECL_WORD3 );
        r( wxSTC_ECL_WORD4 );
        r( wxSTC_ECL_WORD5 );
        r( wxSTC_ECL_COMMENTDOC );
        r( wxSTC_ECL_ADDED );
        r( wxSTC_ECL_DELETED );
        r( wxSTC_ECL_CHANGED );
        r( wxSTC_ECL_MOVED );
#endif        
        r( wxSTC_EOL_CR );
        r( wxSTC_EOL_LF );
        r( wxSTC_EOL_CRLF );
        r( wxSTC_EDGE_NONE );
        r( wxSTC_EDGE_LINE );
        r( wxSTC_EDGE_BACKGROUND );
        r( wxSTC_ERR_DEFAULT );
        r( wxSTC_ERR_PYTHON );
        r( wxSTC_ERR_GCC );
        r( wxSTC_ERR_MS );
        r( wxSTC_ERR_CMD );
        r( wxSTC_ERR_BORLAND );
        r( wxSTC_ERR_PERL );
        r( wxSTC_ERR_NET );
        r( wxSTC_ERR_LUA );
        r( wxSTC_ERR_CTAG );
        r( wxSTC_ERR_DIFF_CHANGED );
        r( wxSTC_ERR_DIFF_ADDITION );
        r( wxSTC_ERR_DIFF_DELETION );
        r( wxSTC_ERR_DIFF_MESSAGE );
        r( wxSTC_EIFFEL_DEFAULT );
        r( wxSTC_EIFFEL_COMMENTLINE );
        r( wxSTC_EIFFEL_NUMBER );
        r( wxSTC_EIFFEL_WORD );
        r( wxSTC_EIFFEL_STRING );
        r( wxSTC_EIFFEL_CHARACTER );
        r( wxSTC_EIFFEL_OPERATOR );
        r( wxSTC_EIFFEL_IDENTIFIER );
        r( wxSTC_EIFFEL_STRINGEOL );
        r( wxSTC_ERLANG_ATOM );
        r( wxSTC_ERLANG_CHARACTER );
        r( wxSTC_ERLANG_COMMENT );
        r( wxSTC_ERLANG_DEFAULT );
        r( wxSTC_ERLANG_FUNCTION_NAME );
        r( wxSTC_ERLANG_KEYWORD );
        r( wxSTC_ERLANG_MACRO );
        r( wxSTC_ERLANG_NODE_NAME );
        r( wxSTC_ERLANG_NUMBER );
        r( wxSTC_ERLANG_OPERATOR );
        r( wxSTC_ERLANG_RECORD );
#if WXPERL_W_VERSION_LT( 2, 9, 1 )
        r( wxSTC_ERLANG_SEPARATOR );
#endif
        r( wxSTC_ERLANG_STRING );
        r( wxSTC_ERLANG_UNKNOWN );
        r( wxSTC_ERLANG_VARIABLE );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_ERLANG_PREPROC );
        r( wxSTC_ERLANG_COMMENT_FUNCTION );
        r( wxSTC_ERLANG_COMMENT_MODULE );
        r( wxSTC_ERLANG_COMMENT_DOC );
        r( wxSTC_ERLANG_COMMENT_DOC );
        r( wxSTC_ERLANG_ATOM_QUOTED );
        r( wxSTC_ERLANG_MACRO_QUOTED );
        r( wxSTC_ERLANG_RECORD_QUOTED );
        r( wxSTC_ERLANG_NODE_NAME_QUOTED );
        r( wxSTC_ERLANG_BIFS );
        r( wxSTC_ERLANG_MODULES );
        r( wxSTC_ERLANG_MODULES_ATT );
#endif
        r( wxSTC_ERR_ABSF );
        r( wxSTC_ERR_ELF );
        r( wxSTC_ERR_IFC );
        r( wxSTC_ERR_IFORT );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_ERR_JAVA_STACK );
#endif
        r( wxSTC_ERR_PHP );
        r( wxSTC_ERR_TIDY );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_ERR_VALUE );
#endif
        r( wxSTC_ESCRIPT_BRACE );
        r( wxSTC_ESCRIPT_COMMENT );
        r( wxSTC_ESCRIPT_COMMENTDOC );
        r( wxSTC_ESCRIPT_COMMENTLINE );
        r( wxSTC_ESCRIPT_DEFAULT );
        r( wxSTC_ESCRIPT_IDENTIFIER );
        r( wxSTC_ESCRIPT_NUMBER );
        r( wxSTC_ESCRIPT_OPERATOR );
        r( wxSTC_ESCRIPT_STRING );
        r( wxSTC_ESCRIPT_WORD );
        r( wxSTC_ESCRIPT_WORD2 );
        r( wxSTC_ESCRIPT_WORD3 );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_EFF_QUALITY_MASK ); 
        r( wxSTC_EFF_QUALITY_DEFAULT );
        r( wxSTC_EFF_QUALITY_NON_ANTIALIASED );
        r( wxSTC_EFF_QUALITY_ANTIALIASED );
        r( wxSTC_EFF_QUALITY_LCD_OPTIMIZED );
#endif
        break;
    case 'F':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_FONT_SIZE_MULTIPLIER );
#endif        
        r( wxSTC_FIND_WHOLEWORD );
        r( wxSTC_FIND_MATCHCASE );
        r( wxSTC_FIND_WORDSTART );
        r( wxSTC_FIND_REGEXP );
        r( wxSTC_FOLDLEVELBASE  );
        r( wxSTC_FOLDLEVELWHITEFLAG );
        r( wxSTC_FOLDLEVELHEADERFLAG );
        r( wxSTC_FOLDLEVELNUMBERMASK );
#if WXPERL_W_VERSION_GE( 2, 5, 2 )
        r( wxSTC_FORTH_DEFAULT );
        r( wxSTC_FORTH_COMMENT );
        r( wxSTC_FORTH_COMMENT_ML );
        r( wxSTC_FORTH_IDENTIFIER );
        r( wxSTC_FORTH_CONTROL );
        r( wxSTC_FORTH_KEYWORD );
        r( wxSTC_FORTH_DEFWORD );
        r( wxSTC_FORTH_PREWORD1 );
        r( wxSTC_FORTH_PREWORD2 );
        r( wxSTC_FORTH_NUMBER );
        r( wxSTC_FORTH_STRING );
        r( wxSTC_FORTH_LOCALE );
#endif
        r( wxSTC_F_DEFAULT );
        r( wxSTC_F_COMMENT );
        r( wxSTC_F_NUMBER );
        r( wxSTC_F_STRING1 );
        r( wxSTC_F_STRING2 );
        r( wxSTC_F_STRINGEOL );
        r( wxSTC_F_OPERATOR );
        r( wxSTC_F_IDENTIFIER );
        r( wxSTC_F_WORD );
        r( wxSTC_F_WORD2 );
        r( wxSTC_F_WORD3 );
        r( wxSTC_F_PREPROCESSOR );
        r( wxSTC_F_OPERATOR2 );
        r( wxSTC_F_LABEL );
        r( wxSTC_F_CONTINUATION );
        r( wxSTC_FIND_POSIX );
#if WXPERL_W_VERSION_LT( 2, 9, 1 )
        r( wxSTC_FOLDFLAG_BOX );
#endif
        r( wxSTC_FOLDFLAG_LEVELNUMBERS );
        r( wxSTC_FOLDFLAG_LINEAFTER_CONTRACTED );
        r( wxSTC_FOLDFLAG_LINEAFTER_EXPANDED );
        r( wxSTC_FOLDFLAG_LINEBEFORE_CONTRACTED );
        r( wxSTC_FOLDFLAG_LINEBEFORE_EXPANDED );
#if WXPERL_W_VERSION_LT( 2, 9, 1 )
        r( wxSTC_FOLDLEVELBOXFOOTERFLAG );
        r( wxSTC_FOLDLEVELBOXHEADERFLAG );
        r( wxSTC_FOLDLEVELCONTRACTED );
        r( wxSTC_FOLDLEVELUNINDENT );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
#if WXPERL_W_VERSION_LT( 2, 9, 5 )
        r( wxSTC_FS_ASM );
        r( wxSTC_FS_BINNUMBER );
        r( wxSTC_FS_ERROR );
        r( wxSTC_FS_HEXNUMBER );
        r( wxSTC_FS_LABEL );
#else
        r( wxSTC_FS_WORDOPERATOR );
        r( wxSTC_FS_DISABLEDCODE );
        r( wxSTC_FS_DEFAULT_C );
        r( wxSTC_FS_COMMENTDOC_C );
        r( wxSTC_FS_COMMENTLINEDOC_C );
        r( wxSTC_FS_KEYWORD_C );
        r( wxSTC_FS_KEYWORD2_C );
        r( wxSTC_FS_NUMBER_C );
        r( wxSTC_FS_STRING_C );
        r( wxSTC_FS_PREPROCESSOR_C );
        r( wxSTC_FS_OPERATOR_C );
        r( wxSTC_FS_IDENTIFIER_C );
        r( wxSTC_FS_STRINGEOL_C );
#endif
        r( wxSTC_FS_COMMENT );
        r( wxSTC_FS_COMMENTDOC );
        r( wxSTC_FS_COMMENTDOCKEYWORD );
        r( wxSTC_FS_COMMENTDOCKEYWORDERROR );
        r( wxSTC_FS_COMMENTLINE );
        r( wxSTC_FS_COMMENTLINEDOC );
        r( wxSTC_FS_CONSTANT );
        r( wxSTC_FS_DATE );
        r( wxSTC_FS_DEFAULT );
        r( wxSTC_FS_IDENTIFIER );
        r( wxSTC_FS_KEYWORD );
        r( wxSTC_FS_KEYWORD2 );
        r( wxSTC_FS_KEYWORD3 );
        r( wxSTC_FS_KEYWORD4 );
        r( wxSTC_FS_NUMBER );
        r( wxSTC_FS_OPERATOR );
        r( wxSTC_FS_PREPROCESSOR );
        r( wxSTC_FS_STRING );
        r( wxSTC_FS_STRINGEOL );
#endif
        break;
    case 'G':
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_GAP_CHAR );
        r( wxSTC_GAP_COMMENT );
        r( wxSTC_GAP_DEFAULT );
        r( wxSTC_GAP_IDENTIFIER );
        r( wxSTC_GAP_KEYWORD );
        r( wxSTC_GAP_KEYWORD2 );
        r( wxSTC_GAP_KEYWORD3 );
        r( wxSTC_GAP_KEYWORD4 );
        r( wxSTC_GAP_NUMBER );
        r( wxSTC_GAP_OPERATOR );
        r( wxSTC_GAP_STRING );
        r( wxSTC_GAP_STRINGEOL );
#endif
        r( wxSTC_GC_ATTRIBUTE );
        r( wxSTC_GC_COMMAND );
        r( wxSTC_GC_COMMENTBLOCK );
        r( wxSTC_GC_COMMENTLINE );
        r( wxSTC_GC_CONTROL );
        r( wxSTC_GC_DEFAULT );
        r( wxSTC_GC_EVENT );
        r( wxSTC_GC_GLOBAL );
        r( wxSTC_GC_OPERATOR );
        r( wxSTC_GC_STRING );
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
        r( wxSTC_H_TAGEND );
        r( wxSTC_H_XMLSTART );
        r( wxSTC_H_XMLEND );
        r( wxSTC_H_SCRIPT );
        r( wxSTC_H_ASP );
        r( wxSTC_H_ASPAT );
        r( wxSTC_H_CDATA );
        r( wxSTC_H_QUESTION );
        r( wxSTC_H_VALUE );
        r( wxSTC_H_XCCOMMENT );
        r( wxSTC_H_SGML_DEFAULT );
        r( wxSTC_H_SGML_COMMAND );
        r( wxSTC_H_SGML_1ST_PARAM );
        r( wxSTC_H_SGML_DOUBLESTRING );
        r( wxSTC_H_SGML_SIMPLESTRING );
        r( wxSTC_H_SGML_ERROR );
        r( wxSTC_H_SGML_SPECIAL );
        r( wxSTC_H_SGML_ENTITY );
        r( wxSTC_H_SGML_COMMENT );
        r( wxSTC_H_SGML_1ST_PARAM_COMMENT );
        r( wxSTC_H_SGML_BLOCK_DEFAULT );
        r( wxSTC_HJ_START );
        r( wxSTC_HJ_DEFAULT );
        r( wxSTC_HJ_COMMENT );
        r( wxSTC_HJ_COMMENTLINE );
        r( wxSTC_HJ_COMMENTDOC );
        r( wxSTC_HJ_NUMBER );
        r( wxSTC_HJ_WORD );
        r( wxSTC_HJ_KEYWORD );
        r( wxSTC_HJ_DOUBLESTRING );
        r( wxSTC_HJ_SINGLESTRING );
        r( wxSTC_HJ_SYMBOLS );
        r( wxSTC_HJ_STRINGEOL );
        r( wxSTC_HJ_REGEX );
        r( wxSTC_HJA_START );
        r( wxSTC_HJA_DEFAULT );
        r( wxSTC_HJA_COMMENT );
        r( wxSTC_HJA_COMMENTLINE );
        r( wxSTC_HJA_COMMENTDOC );
        r( wxSTC_HJA_NUMBER );
        r( wxSTC_HJA_WORD );
        r( wxSTC_HJA_KEYWORD );
        r( wxSTC_HJA_DOUBLESTRING );
        r( wxSTC_HJA_SINGLESTRING );
        r( wxSTC_HJA_SYMBOLS );
        r( wxSTC_HJA_STRINGEOL );
        r( wxSTC_HJA_REGEX );
        r( wxSTC_HB_START );
        r( wxSTC_HB_DEFAULT );
        r( wxSTC_HB_COMMENTLINE );
        r( wxSTC_HB_NUMBER );
        r( wxSTC_HB_WORD );
        r( wxSTC_HB_STRING );
        r( wxSTC_HB_IDENTIFIER );
        r( wxSTC_HB_STRINGEOL );
        r( wxSTC_HBA_START );
        r( wxSTC_HBA_DEFAULT );
        r( wxSTC_HBA_COMMENTLINE );
        r( wxSTC_HBA_NUMBER );
        r( wxSTC_HBA_WORD );
        r( wxSTC_HBA_STRING );
        r( wxSTC_HBA_IDENTIFIER );
        r( wxSTC_HBA_STRINGEOL );
        r( wxSTC_HP_START );
        r( wxSTC_HP_DEFAULT );
        r( wxSTC_HP_COMMENTLINE );
        r( wxSTC_HP_NUMBER );
        r( wxSTC_HP_STRING );
        r( wxSTC_HP_CHARACTER );
        r( wxSTC_HP_WORD );
        r( wxSTC_HP_TRIPLE );
        r( wxSTC_HP_TRIPLEDOUBLE );
        r( wxSTC_HP_CLASSNAME );
        r( wxSTC_HP_DEFNAME );
        r( wxSTC_HP_OPERATOR );
        r( wxSTC_HP_IDENTIFIER );
        r( wxSTC_HPA_START );
        r( wxSTC_HPA_DEFAULT );
        r( wxSTC_HPA_COMMENTLINE );
        r( wxSTC_HPA_NUMBER );
        r( wxSTC_HPA_STRING );
        r( wxSTC_HPA_CHARACTER );
        r( wxSTC_HPA_WORD );
        r( wxSTC_HPA_TRIPLE );
        r( wxSTC_HPA_TRIPLEDOUBLE );
        r( wxSTC_HPA_CLASSNAME );
        r( wxSTC_HPA_DEFNAME );
        r( wxSTC_HPA_OPERATOR );
        r( wxSTC_HPA_IDENTIFIER );
        r( wxSTC_HPHP_DEFAULT );
        r( wxSTC_HPHP_HSTRING );
        r( wxSTC_HPHP_SIMPLESTRING );
        r( wxSTC_HPHP_WORD );
        r( wxSTC_HPHP_NUMBER );
        r( wxSTC_HPHP_VARIABLE );
        r( wxSTC_HPHP_COMMENT );
        r( wxSTC_HPHP_COMMENTLINE );
        r( wxSTC_HPHP_HSTRING_VARIABLE );
        r( wxSTC_HPHP_OPERATOR );
        r( wxSTC_HPHP_COMPLEX_VARIABLE );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_HA_CAPITAL );
        r( wxSTC_HA_CHARACTER );
        r( wxSTC_HA_CLASS );
        r( wxSTC_HA_COMMENTBLOCK );
        r( wxSTC_HA_COMMENTBLOCK2 );
        r( wxSTC_HA_COMMENTBLOCK3 );
        r( wxSTC_HA_COMMENTLINE );
        r( wxSTC_HA_DATA );
        r( wxSTC_HA_DEFAULT );
        r( wxSTC_HA_IDENTIFIER );
        r( wxSTC_HA_IMPORT );
        r( wxSTC_HA_INSTANCE );
        r( wxSTC_HA_KEYWORD );
        r( wxSTC_HA_MODULE );
        r( wxSTC_HA_NUMBER );
        r( wxSTC_HA_OPERATOR );
        r( wxSTC_HA_STRING );
#endif
        break;
    case 'I':
        r( wxSTC_INDIC_MAX );
        r( wxSTC_INDIC_PLAIN );
        r( wxSTC_INDIC_SQUIGGLE );
        r( wxSTC_INDIC_TT );
        r( wxSTC_INDIC_DIAGONAL );
        r( wxSTC_INDIC_STRIKE );
        r( wxSTC_INDIC0_MASK );
        r( wxSTC_INDIC1_MASK );
        r( wxSTC_INDIC2_MASK );
        r( wxSTC_INDICS_MASK );
        r( wxSTC_INDIC_BOX );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_INDIC_CONTAINER );
#endif
        r( wxSTC_INDIC_HIDDEN );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_INDIC_ROUNDBOX );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_INDIC_STRAIGHTBOX );
        r( wxSTC_INDIC_DASH );
        r( wxSTC_INDIC_DOTS );
        r( wxSTC_INDIC_SQUIGGLELOW );
        r( wxSTC_INDIC_DOTBOX );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_INNO_COMMENT );
        r( wxSTC_INNO_COMMENT_PASCAL );
        r( wxSTC_INNO_DEFAULT );
        r( wxSTC_INNO_IDENTIFIER );
        r( wxSTC_INNO_KEYWORD );
        r( wxSTC_INNO_KEYWORD_PASCAL );
        r( wxSTC_INNO_KEYWORD_USER );
        r( wxSTC_INNO_PARAMETER );
        r( wxSTC_INNO_PREPROC );
#if WXPERL_W_VERSION_LT( 2, 9, 1 )
        r( wxSTC_INNO_PREPROC_INLINE );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_INNO_INLINE_EXPANSION );
#endif           
        r( wxSTC_INNO_SECTION );
        r( wxSTC_INNO_STRING_DOUBLE );
        r( wxSTC_INNO_STRING_SINGLE );
        r( wxSTC_INVALID_POSITION );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_IV_LOOKBOTH );
        r( wxSTC_IV_LOOKFORWARD );
        r( wxSTC_IV_NONE );
        r( wxSTC_IV_REAL );
#endif
        break;
    case 'K':
        r( wxSTC_KEY_DOWN );
        r( wxSTC_KEY_UP );
        r( wxSTC_KEY_LEFT );
        r( wxSTC_KEY_RIGHT );
        r( wxSTC_KEY_HOME );
        r( wxSTC_KEY_END );
        r( wxSTC_KEY_PRIOR );
        r( wxSTC_KEY_NEXT );
        r( wxSTC_KEY_DELETE );
        r( wxSTC_KEY_INSERT );
        r( wxSTC_KEY_ESCAPE );
        r( wxSTC_KEY_BACK );
        r( wxSTC_KEY_TAB );
        r( wxSTC_KEY_RETURN );
        r( wxSTC_KEY_ADD );
        r( wxSTC_KEY_SUBTRACT );
        r( wxSTC_KEY_DIVIDE );
        r( wxSTC_KEYWORDSET_MAX );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_KEY_MENU );
        r( wxSTC_KEY_RWIN );
        r( wxSTC_KEY_WIN );
#endif
        r( wxSTC_KIX_COMMENT );
        r( wxSTC_KIX_DEFAULT );
        r( wxSTC_KIX_FUNCTIONS );
        r( wxSTC_KIX_IDENTIFIER );
        r( wxSTC_KIX_KEYWORD );
        r( wxSTC_KIX_MACRO );
        r( wxSTC_KIX_NUMBER );
        r( wxSTC_KIX_OPERATOR );
        r( wxSTC_KIX_STRING1 );
        r( wxSTC_KIX_STRING2 );
        r( wxSTC_KIX_VAR );
        break;
    case 'L':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
    r( wxSTC_L_TAG2 );
        r( wxSTC_L_MATH2 );
        r( wxSTC_L_COMMENT2 );
        r( wxSTC_L_VERBATIM );
        r( wxSTC_L_SHORTCMD );
        r( wxSTC_L_SPECIAL );
        r( wxSTC_L_CMDOPT );
        r( wxSTC_L_ERROR );
        r( wxSTC_LUA_LABEL );
        r( wxSTC_LEX_TXT2TAGS );
        r( wxSTC_LEX_A68K );
        r( wxSTC_LEX_MODULA );
        r( wxSTC_LEX_COFFEESCRIPT );
        r( wxSTC_LEX_TCMD );
        r( wxSTC_LEX_AVS );
        r( wxSTC_LEX_ECL );
        r( wxSTC_LEX_OSCRIPT );
        r( wxSTC_LEX_VISUALPROLOG );
#endif        
        r( wxSTC_LEX_ADA );
        r( wxSTC_LEX_ASM );
#ifdef wxSTC_LEX_ASP
        r( wxSTC_LEX_ASP );
#endif
        r( wxSTC_LEX_AUTOMATIC );
        r( wxSTC_LEX_AVE );
        r( wxSTC_LEX_BAAN );
        r( wxSTC_LEX_BATCH );
        r( wxSTC_LEX_BULLANT );
        r( wxSTC_LEX_CONF );
        r( wxSTC_LEX_CONTAINER );
        r( wxSTC_LEX_CPP );
        r( wxSTC_LEX_CSS );
        r( wxSTC_LEX_DIFF );
        r( wxSTC_LEX_EIFFEL );
        r( wxSTC_LEX_EIFFELKW );
        r( wxSTC_LEX_ERRORLIST );
#if WXPERL_W_VERSION_GE( 2, 5, 2 )
        r( wxSTC_LEX_FORTH );
#endif
        r( wxSTC_LEX_FORTRAN );
        r( wxSTC_LEX_HTML );
        r( wxSTC_LEX_LATEX );
        r( wxSTC_LEX_LISP );
        r( wxSTC_LEX_LUA );
        r( wxSTC_LEX_MAKEFILE );
        r( wxSTC_LEX_MATLAB );
        r( wxSTC_LEX_NNCRONTAB );
        r( wxSTC_LEX_NULL );
        r( wxSTC_LEX_NSIS );
        r( wxSTC_LEX_PASCAL );
        r( wxSTC_LEX_PERL );
#ifdef wxSTC_LEX_PHP
        r( wxSTC_LEX_PHP );
#endif
#ifdef wxSTC_LEX_PHPSCRIPT
        r( wxSTC_LEX_PHPSCRIPT );
#endif
        r( wxSTC_LEX_PROPERTIES );
        r( wxSTC_LEX_PS );
        r( wxSTC_LEX_PYTHON );
        r( wxSTC_LEX_RUBY );
        r( wxSTC_LEX_SCRIPTOL );
        r( wxSTC_LEX_SQL );
        r( wxSTC_LEX_TCL );
#if WXPERL_W_VERSION_GE( 2, 5, 2 )
        r( wxSTC_LEX_YAML );
        r( wxSTC_LEX_TEX );
#endif
        r( wxSTC_LEX_VB );
        r( wxSTC_LEX_VBSCRIPT );
        r( wxSTC_LEX_XCODE );
        r( wxSTC_LEX_XML );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_ABAQUS );
#endif
        r( wxSTC_LEX_APDL );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_LEX_ASN1 );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_ASYMPTOTE );
#endif
        r( wxSTC_LEX_AU3 );
        r( wxSTC_LEX_BASH );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_BLITZBASIC );
        r( wxSTC_LEX_CAML );
        r( wxSTC_LEX_CLW );
#endif
        r( wxSTC_LEX_CLWNOCASE );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_CMAKE );
#endif
        r( wxSTC_LEX_CPPNOCASE );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_CSOUND );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_D );
#endif
        r( wxSTC_LEX_ERLANG );
        r( wxSTC_LEX_ESCRIPT );
        r( wxSTC_LEX_F77 );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_FLAGSHIP );
        r( wxSTC_LEX_FREEBASIC );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_GAP );
#endif
        r( wxSTC_LEX_GUI4CLI );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_HASKELL );
        r( wxSTC_LEX_INNOSETUP );
#endif
        r( wxSTC_LEX_KIX );
        r( wxSTC_LEX_LOT );
        r( wxSTC_LEX_LOUT );
        r( wxSTC_LEX_METAPOST );
        r( wxSTC_LEX_MMIXAL );
        r( wxSTC_LEX_MSSQL );
        r( wxSTC_LEX_OCTAVE );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_OPAL );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_PLM );
#endif
        r( wxSTC_LEX_POV );
        r( wxSTC_LEX_POWERBASIC );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_PROGRESS );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_PUREBASIC );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_LEX_R );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_REBOL );
        r( wxSTC_LEX_SMALLTALK );
#endif
        r( wxSTC_LEX_SPECMAN );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LEX_SPICE );
        r( wxSTC_LEX_TADS3 );
#endif
        r( wxSTC_LEX_VERILOG );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_LEX_VHDL );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_LEX_MAGIK );
        r( wxSTC_LEX_POWERSHELL );
        r( wxSTC_LEX_MYSQL );
        r( wxSTC_LEX_PO );
        r( wxSTC_LEX_TAL );
        r( wxSTC_LEX_COBOL );
        r( wxSTC_LEX_TACL );
        r( wxSTC_LEX_SORCUS );
        r( wxSTC_LEX_POWERPRO );
        r( wxSTC_LEX_NIMROD );
        r( wxSTC_LEX_SML );
        r( wxSTC_LEX_MARKDOWN );
#endif
        r( wxSTC_LASTSTEPINUNDOREDO );
        r( wxSTC_L_DEFAULT );
        r( wxSTC_L_COMMAND );
        r( wxSTC_L_TAG );
        r( wxSTC_L_MATH );
        r( wxSTC_L_COMMENT );
        r( wxSTC_LUA_DEFAULT );
        r( wxSTC_LUA_COMMENT );
        r( wxSTC_LUA_COMMENTLINE );
        r( wxSTC_LUA_COMMENTDOC );
        r( wxSTC_LUA_NUMBER );
        r( wxSTC_LUA_WORD );
        r( wxSTC_LUA_STRING );
        r( wxSTC_LUA_CHARACTER );
        r( wxSTC_LUA_LITERALSTRING );
        r( wxSTC_LUA_PREPROCESSOR );
        r( wxSTC_LUA_OPERATOR );
        r( wxSTC_LUA_IDENTIFIER );
        r( wxSTC_LUA_STRINGEOL );
        r( wxSTC_LUA_WORD2 );
        r( wxSTC_LUA_WORD3 );
        r( wxSTC_LUA_WORD4 );
        r( wxSTC_LUA_WORD5 );
        r( wxSTC_LUA_WORD6 );
        r( wxSTC_LISP_DEFAULT );
        r( wxSTC_LISP_COMMENT );
        r( wxSTC_LISP_NUMBER );
        r( wxSTC_LISP_KEYWORD );
        r( wxSTC_LISP_STRING );
        r( wxSTC_LISP_STRINGEOL );
        r( wxSTC_LISP_IDENTIFIER );
        r( wxSTC_LISP_OPERATOR );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_LISP_KEYWORD_KW );
        r( wxSTC_LISP_MULTI_COMMENT );
        r( wxSTC_LISP_SPECIAL );
        r( wxSTC_LISP_SYMBOL );
#endif
        r( wxSTC_LEXER_START );
        r( wxSTC_LOT_ABORT );
        r( wxSTC_LOT_BREAK );
        r( wxSTC_LOT_DEFAULT );
        r( wxSTC_LOT_FAIL );
        r( wxSTC_LOT_HEADER );
        r( wxSTC_LOT_PASS );
        r( wxSTC_LOT_SET );
        r( wxSTC_LOUT_COMMENT );
        r( wxSTC_LOUT_DEFAULT );
        r( wxSTC_LOUT_IDENTIFIER );
        r( wxSTC_LOUT_NUMBER );
        r( wxSTC_LOUT_OPERATOR );
        r( wxSTC_LOUT_STRING );
        r( wxSTC_LOUT_STRINGEOL );
        r( wxSTC_LOUT_WORD );
        r( wxSTC_LOUT_WORD2 );
        r( wxSTC_LOUT_WORD3 );
        r( wxSTC_LOUT_WORD4 );
        r( wxSTC_LUA_WORD7 );
        r( wxSTC_LUA_WORD8 );
        break;
    case 'M':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_MARGINOPTION_NONE );
        r( wxSTC_MARGINOPTION_SUBLINESELECT );
        r( wxSTC_MARK_RGBAIMAGE );
        r( wxSTC_MOD_LEXERSTATE );
        r( wxSTC_MODEVENTMASKALL );
        r( wxSTC_MODULA_DEFAULT );
        r( wxSTC_MODULA_COMMENT );
        r( wxSTC_MODULA_DOXYCOMM );
        r( wxSTC_MODULA_DOXYKEY );
        r( wxSTC_MODULA_KEYWORD );
        r( wxSTC_MODULA_RESERVED );
        r( wxSTC_MODULA_NUMBER );
        r( wxSTC_MODULA_BASENUM );
        r( wxSTC_MODULA_FLOAT );
        r( wxSTC_MODULA_STRING );
        r( wxSTC_MODULA_STRSPEC );
        r( wxSTC_MODULA_CHAR );
        r( wxSTC_MODULA_CHARSPEC );
        r( wxSTC_MODULA_PROC );
        r( wxSTC_MODULA_PRAGMA );
        r( wxSTC_MODULA_PRGKEY );
        r( wxSTC_MODULA_OPERATOR );
        r( wxSTC_MODULA_BADSTR );
        r( wxSTC_MULTIPASTE_ONCE );
        r( wxSTC_MULTIPASTE_EACH );
#endif        
        r( wxSTC_MARKER_MAX );
        r( wxSTC_MARK_CIRCLE );
        r( wxSTC_MARK_ROUNDRECT );
        r( wxSTC_MARK_ARROW );
        r( wxSTC_MARK_SMALLRECT );
        r( wxSTC_MARK_SHORTARROW );
        r( wxSTC_MARK_EMPTY );
        r( wxSTC_MARK_ARROWDOWN );
        r( wxSTC_MARK_MINUS );
        r( wxSTC_MARK_PLUS );
        r( wxSTC_MARK_VLINE );
        r( wxSTC_MARK_LCORNER );
        r( wxSTC_MARK_TCORNER );
        r( wxSTC_MARK_BOXPLUS );
        r( wxSTC_MARK_BOXPLUSCONNECTED );
        r( wxSTC_MARK_BOXMINUS );
        r( wxSTC_MARK_BOXMINUSCONNECTED );
        r( wxSTC_MARK_LCORNERCURVE );
        r( wxSTC_MARK_TCORNERCURVE );
        r( wxSTC_MARK_CIRCLEPLUS );
        r( wxSTC_MARK_CIRCLEPLUSCONNECTED );
        r( wxSTC_MARK_CIRCLEMINUS );
        r( wxSTC_MARK_CIRCLEMINUSCONNECTED );
        r( wxSTC_MARK_BACKGROUND );
        r( wxSTC_MARK_DOTDOTDOT );
        r( wxSTC_MARK_ARROWS );
        r( wxSTC_MARK_CHARACTER );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_MARK_FULLRECT );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_MARK_LEFTRECT );
        r( wxSTC_MARK_AVAILABLE );
        r( wxSTC_MARK_UNDERLINE );
        r( wxSTC_MARGIN_TEXT );
        r( wxSTC_MARGIN_RTEXT );
        r( wxSTC_MOD_CHANGEMARGIN );
        r( wxSTC_MOD_CHANGEANNOTATION );
        r( wxSTC_MOD_CONTAINER );
        r( wxSTC_MAGIK_DEFAULT );
        r( wxSTC_MAGIK_COMMENT );
        r( wxSTC_MAGIK_HYPER_COMMENT );
        r( wxSTC_MAGIK_STRING );
        r( wxSTC_MAGIK_CHARACTER );
        r( wxSTC_MAGIK_NUMBER );
        r( wxSTC_MAGIK_IDENTIFIER );
        r( wxSTC_MAGIK_OPERATOR );
        r( wxSTC_MAGIK_FLOW );
        r( wxSTC_MAGIK_CONTAINER );
        r( wxSTC_MAGIK_BRACKET_BLOCK );
        r( wxSTC_MAGIK_BRACE_BLOCK );
        r( wxSTC_MAGIK_SQBRACKET_BLOCK );
        r( wxSTC_MAGIK_UNKNOWN_KEYWORD );
        r( wxSTC_MAGIK_KEYWORD );
        r( wxSTC_MAGIK_PRAGMA );
        r( wxSTC_MAGIK_SYMBOL );
        r( wxSTC_MYSQL_DEFAULT );
        r( wxSTC_MYSQL_COMMENT );
        r( wxSTC_MYSQL_COMMENTLINE );
        r( wxSTC_MYSQL_VARIABLE );
        r( wxSTC_MYSQL_SYSTEMVARIABLE );
        r( wxSTC_MYSQL_KNOWNSYSTEMVARIABLE );
        r( wxSTC_MYSQL_NUMBER );
        r( wxSTC_MYSQL_MAJORKEYWORD );
        r( wxSTC_MYSQL_KEYWORD );
        r( wxSTC_MYSQL_DATABASEOBJECT );
        r( wxSTC_MYSQL_PROCEDUREKEYWORD );
        r( wxSTC_MYSQL_STRING );
        r( wxSTC_MYSQL_SQSTRING );
        r( wxSTC_MYSQL_DQSTRING );
        r( wxSTC_MYSQL_OPERATOR );
        r( wxSTC_MYSQL_FUNCTION );
        r( wxSTC_MYSQL_IDENTIFIER );
        r( wxSTC_MYSQL_QUOTEDIDENTIFIER );
        r( wxSTC_MYSQL_USER1 );
        r( wxSTC_MYSQL_USER2 );
        r( wxSTC_MYSQL_USER3 );
        r( wxSTC_MYSQL_HIDDENCOMMAND );
        r( wxSTC_MARKDOWN_DEFAULT );
        r( wxSTC_MARKDOWN_LINE_BEGIN );
        r( wxSTC_MARKDOWN_STRONG1 );
        r( wxSTC_MARKDOWN_STRONG2 );
        r( wxSTC_MARKDOWN_EM1 );
        r( wxSTC_MARKDOWN_EM2 );
        r( wxSTC_MARKDOWN_HEADER1 );
        r( wxSTC_MARKDOWN_HEADER2 );
        r( wxSTC_MARKDOWN_HEADER3 );
        r( wxSTC_MARKDOWN_HEADER4 );
        r( wxSTC_MARKDOWN_HEADER5 );
        r( wxSTC_MARKDOWN_HEADER6 );
        r( wxSTC_MARKDOWN_PRECHAR );
        r( wxSTC_MARKDOWN_ULIST_ITEM );
        r( wxSTC_MARKDOWN_OLIST_ITEM );
        r( wxSTC_MARKDOWN_BLOCKQUOTE );
        r( wxSTC_MARKDOWN_STRIKEOUT );
        r( wxSTC_MARKDOWN_HRULE );
        r( wxSTC_MARKDOWN_LINK );
        r( wxSTC_MARKDOWN_CODE );
        r( wxSTC_MARKDOWN_CODE2 );
        r( wxSTC_MARKDOWN_CODEBK );
#endif
        r( wxSTC_MARK_PIXMAP );
        r( wxSTC_MARKNUM_FOLDEREND );
        r( wxSTC_MARKNUM_FOLDEROPENMID );
        r( wxSTC_MARKNUM_FOLDERMIDTAIL );
        r( wxSTC_MARKNUM_FOLDERTAIL );
        r( wxSTC_MARKNUM_FOLDERSUB );
        r( wxSTC_MARKNUM_FOLDER );
        r( wxSTC_MARKNUM_FOLDEROPEN );
        r( wxSTC_MASK_FOLDERS );
        r( wxSTC_MARGIN_SYMBOL );
        r( wxSTC_MARGIN_NUMBER );
        r( wxSTC_MARGIN_COLOUR );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_MARGIN_BACK );
        r( wxSTC_MARGIN_FORE );
#endif
        r( wxSTC_MOD_INSERTTEXT );
        r( wxSTC_MOD_DELETETEXT );
        r( wxSTC_MOD_CHANGESTYLE );
        r( wxSTC_MOD_CHANGEFOLD );
        r( wxSTC_MOD_CHANGEMARKER );
        r( wxSTC_MOD_BEFOREINSERT );
        r( wxSTC_MOD_BEFOREDELETE );
        r( wxSTC_MODEVENTMASKALL );
        r( wxSTC_MAKE_DEFAULT );
        r( wxSTC_MAKE_COMMENT );
        r( wxSTC_MAKE_PREPROCESSOR );
        r( wxSTC_MAKE_IDENTIFIER );
        r( wxSTC_MAKE_OPERATOR );
        r( wxSTC_MAKE_TARGET );
        r( wxSTC_MAKE_IDEOL );
        r( wxSTC_MATLAB_DEFAULT );
        r( wxSTC_MATLAB_COMMENT );
        r( wxSTC_MATLAB_COMMAND );
        r( wxSTC_MATLAB_NUMBER );
        r( wxSTC_MATLAB_KEYWORD );
        r( wxSTC_MATLAB_STRING );
        r( wxSTC_MATLAB_OPERATOR );
        r( wxSTC_MATLAB_IDENTIFIER );
        r( wxSTC_MATLAB_DOUBLEQUOTESTRING );
        r( wxSTC_METAPOST_COMMAND );
        r( wxSTC_METAPOST_DEFAULT );
        r( wxSTC_METAPOST_EXTRA );
        r( wxSTC_METAPOST_GROUP );
        r( wxSTC_METAPOST_SPECIAL );
        r( wxSTC_METAPOST_SYMBOL );
        r( wxSTC_METAPOST_TEXT );
        r( wxSTC_MMIXAL_CHAR );
        r( wxSTC_MMIXAL_COMMENT );
        r( wxSTC_MMIXAL_HEX );
        r( wxSTC_MMIXAL_INCLUDE );
        r( wxSTC_MMIXAL_LABEL );
        r( wxSTC_MMIXAL_LEADWS );
        r( wxSTC_MMIXAL_NUMBER );
        r( wxSTC_MMIXAL_OPCODE );
        r( wxSTC_MMIXAL_OPCODE_POST );
        r( wxSTC_MMIXAL_OPCODE_PRE );
        r( wxSTC_MMIXAL_OPCODE_UNKNOWN );
        r( wxSTC_MMIXAL_OPCODE_VALID );
        r( wxSTC_MMIXAL_OPERANDS );
        r( wxSTC_MMIXAL_OPERATOR );
        r( wxSTC_MMIXAL_REF );
        r( wxSTC_MMIXAL_REGISTER );
        r( wxSTC_MMIXAL_STRING );
        r( wxSTC_MMIXAL_SYMBOL );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_MOD_CHANGEINDICATOR );
        r( wxSTC_MOD_CHANGELINESTATE );
#endif
        r( wxSTC_MSSQL_COLUMN_NAME );
        r( wxSTC_MSSQL_COLUMN_NAME_2 );
        r( wxSTC_MSSQL_COMMENT );
        r( wxSTC_MSSQL_DATATYPE );
        r( wxSTC_MSSQL_DEFAULT );
        r( wxSTC_MSSQL_DEFAULT_PREF_DATATYPE );
        r( wxSTC_MSSQL_FUNCTION );
        r( wxSTC_MSSQL_GLOBAL_VARIABLE );
        r( wxSTC_MSSQL_IDENTIFIER );
        r( wxSTC_MSSQL_LINE_COMMENT );
        r( wxSTC_MSSQL_NUMBER );
        r( wxSTC_MSSQL_OPERATOR );
        r( wxSTC_MSSQL_STATEMENT );
        r( wxSTC_MSSQL_STORED_PROCEDURE );
        r( wxSTC_MSSQL_STRING );
        r( wxSTC_MSSQL_SYSTABLE );
        r( wxSTC_MSSQL_VARIABLE );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_MULTILINEUNDOREDO );
        r( wxSTC_MULTISTEPUNDOREDO );
#endif
        break;
    case 'N':
        r( wxSTC_NNCRONTAB_DEFAULT );
        r( wxSTC_NNCRONTAB_COMMENT );
        r( wxSTC_NNCRONTAB_TASK );
        r( wxSTC_NNCRONTAB_SECTION );
        r( wxSTC_NNCRONTAB_KEYWORD );
        r( wxSTC_NNCRONTAB_MODIFIER );
        r( wxSTC_NNCRONTAB_ASTERISK );
        r( wxSTC_NNCRONTAB_NUMBER );
        r( wxSTC_NNCRONTAB_STRING );
        r( wxSTC_NNCRONTAB_ENVIRONMENT );
        r( wxSTC_NNCRONTAB_IDENTIFIER );

        r( wxSTC_NSIS_DEFAULT );
        r( wxSTC_NSIS_COMMENT );
        r( wxSTC_NSIS_STRINGDQ );
        r( wxSTC_NSIS_STRINGLQ );
        r( wxSTC_NSIS_STRINGRQ );
        r( wxSTC_NSIS_FUNCTION );
        r( wxSTC_NSIS_VARIABLE );
        r( wxSTC_NSIS_LABEL );
        r( wxSTC_NSIS_USERDEFINED );
        r( wxSTC_NSIS_SECTIONDEF );
        r( wxSTC_NSIS_SUBSECTIONDEF );
        r( wxSTC_NSIS_IFDEFINEDEF );
        r( wxSTC_NSIS_MACRODEF );
        r( wxSTC_NSIS_STRINGVAR );
        r( wxSTC_NSIS_NUMBER );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_NSIS_COMMENTBOX );
        r( wxSTC_NSIS_FUNCTIONDEF );
        r( wxSTC_NSIS_PAGEEX );
        r( wxSTC_NSIS_SECTIONGROUP );
#endif
        break;
    case 'O':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )        
        r( wxSTC_OSCRIPT_DEFAULT );
        r( wxSTC_OSCRIPT_LINE_COMMENT );
        r( wxSTC_OSCRIPT_BLOCK_COMMENT );
        r( wxSTC_OSCRIPT_DOC_COMMENT );
        r( wxSTC_OSCRIPT_PREPROCESSOR );
        r( wxSTC_OSCRIPT_NUMBER );
        r( wxSTC_OSCRIPT_SINGLEQUOTE_STRING );
        r( wxSTC_OSCRIPT_DOUBLEQUOTE_STRING );
        r( wxSTC_OSCRIPT_CONSTANT );
        r( wxSTC_OSCRIPT_IDENTIFIER );
        r( wxSTC_OSCRIPT_GLOBAL );
        r( wxSTC_OSCRIPT_KEYWORD );
        r( wxSTC_OSCRIPT_OPERATOR );
        r( wxSTC_OSCRIPT_LABEL );
        r( wxSTC_OSCRIPT_TYPE );
        r( wxSTC_OSCRIPT_FUNCTION );
        r( wxSTC_OSCRIPT_OBJECT );
        r( wxSTC_OSCRIPT_PROPERTY );
        r( wxSTC_OSCRIPT_METHOD );
#endif        
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_OPAL_BOOL_CONST );
        r( wxSTC_OPAL_COMMENT_BLOCK );
        r( wxSTC_OPAL_COMMENT_LINE );
        r( wxSTC_OPAL_DEFAULT );
        r( wxSTC_OPAL_INTEGER );
        r( wxSTC_OPAL_KEYWORD );
        r( wxSTC_OPAL_PAR );
        r( wxSTC_OPAL_SORT );
        r( wxSTC_OPAL_SPACE );
        r( wxSTC_OPAL_STRING );
#endif
        r( wxSTC_OPTIONAL_START );
        break;
    case 'P':
        r( wxSTC_PRINT_NORMAL );
        r( wxSTC_PRINT_INVERTLIGHT );
        r( wxSTC_PRINT_BLACKONWHITE );
        r( wxSTC_PRINT_COLOURONWHITE );
        r( wxSTC_PRINT_COLOURONWHITEDEFAULTBG );
        r( wxSTC_PERFORMED_USER );
        r( wxSTC_PERFORMED_UNDO );
        r( wxSTC_PERFORMED_REDO );
        r( wxSTC_P_DEFAULT );
        r( wxSTC_P_COMMENTLINE );
        r( wxSTC_P_NUMBER );
        r( wxSTC_P_STRING );
        r( wxSTC_P_CHARACTER );
        r( wxSTC_P_WORD );
        r( wxSTC_P_TRIPLE );
        r( wxSTC_P_TRIPLEDOUBLE );
        r( wxSTC_P_CLASSNAME );
        r( wxSTC_P_DEFNAME );
        r( wxSTC_P_OPERATOR );
        r( wxSTC_P_IDENTIFIER );
        r( wxSTC_P_COMMENTBLOCK );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_P_STRINGEOL );
        r( wxSTC_P_DECORATOR );
        r( wxSTC_P_WORD2 );
#endif
        r( wxSTC_PL_DEFAULT );
        r( wxSTC_PL_ERROR );
        r( wxSTC_PL_COMMENTLINE );
        r( wxSTC_PL_POD );
        r( wxSTC_PL_NUMBER );
        r( wxSTC_PL_WORD );
        r( wxSTC_PL_STRING );
        r( wxSTC_PL_CHARACTER );
        r( wxSTC_PL_PUNCTUATION );
        r( wxSTC_PL_PREPROCESSOR );
        r( wxSTC_PL_OPERATOR );
        r( wxSTC_PL_IDENTIFIER );
        r( wxSTC_PL_SCALAR );
        r( wxSTC_PL_ARRAY );
        r( wxSTC_PL_HASH );
        r( wxSTC_PL_SYMBOLTABLE );
        r( wxSTC_PL_REGEX );
        r( wxSTC_PL_REGSUBST );
        r( wxSTC_PL_LONGQUOTE );
        r( wxSTC_PL_BACKTICKS );
        r( wxSTC_PL_DATASECTION );
        r( wxSTC_PL_HERE_DELIM );
        r( wxSTC_PL_HERE_Q );
        r( wxSTC_PL_HERE_QQ );
        r( wxSTC_PL_HERE_QX );
        r( wxSTC_PL_STRING_Q );
        r( wxSTC_PL_STRING_QQ );
        r( wxSTC_PL_STRING_QX );
        r( wxSTC_PL_STRING_QR );
        r( wxSTC_PL_STRING_QW );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_PL_FORMAT );
        r( wxSTC_PL_FORMAT_IDENT );
        r( wxSTC_PL_SUB_PROTOTYPE );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_PL_STRING_VAR );
        r( wxSTC_PL_XLAT );
        r( wxSTC_PL_REGEX_VAR );
        r( wxSTC_PL_REGSUBST_VAR );
        r( wxSTC_PL_BACKTICKS_VAR );
        r( wxSTC_PL_HERE_QQ_VAR );
        r( wxSTC_PL_HERE_QX_VAR );
        r( wxSTC_PL_STRING_QQ_VAR );
        r( wxSTC_PL_STRING_QX_VAR );
        r( wxSTC_PL_STRING_QR_VAR );
        r( wxSTC_POWERSHELL_FUNCTION );
        r( wxSTC_POWERSHELL_USER1 );
        r( wxSTC_POWERSHELL_COMMENTSTREAM );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_PL_POD_VERB );
        r( wxSTC_PL_VARIABLE_INDEXER );
#endif
        r( wxSTC_PROPS_DEFAULT );
        r( wxSTC_PROPS_COMMENT );
        r( wxSTC_PROPS_SECTION );
        r( wxSTC_PROPS_ASSIGNMENT );
        r( wxSTC_PROPS_DEFVAL );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_PROPS_KEY );
#endif

        r( wxSTC_PS_DEFAULT );
        r( wxSTC_PS_COMMENT );
        r( wxSTC_PS_DSC_COMMENT );
        r( wxSTC_PS_DSC_VALUE );
        r( wxSTC_PS_NUMBER );
        r( wxSTC_PS_NAME );
        r( wxSTC_PS_KEYWORD );
        r( wxSTC_PS_LITERAL );
        r( wxSTC_PS_IMMEVAL );
        r( wxSTC_PS_PAREN_ARRAY );
        r( wxSTC_PS_PAREN_DICT );
        r( wxSTC_PS_PAREN_PROC );
        r( wxSTC_PS_TEXT );
        r( wxSTC_PS_HEXSTRING );
        r( wxSTC_PS_BASE85STRING );
        r( wxSTC_PS_BADSTRINGCHAR );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_PLM_COMMENT );
        r( wxSTC_PLM_CONTROL );
        r( wxSTC_PLM_DEFAULT );
        r( wxSTC_PLM_IDENTIFIER );
        r( wxSTC_PLM_KEYWORD );
        r( wxSTC_PLM_NUMBER );
        r( wxSTC_PLM_OPERATOR );
        r( wxSTC_PLM_STRING );
#endif
        r( wxSTC_POV_BADDIRECTIVE );
        r( wxSTC_POV_COMMENT );
        r( wxSTC_POV_COMMENTLINE );
        r( wxSTC_POV_DEFAULT );
        r( wxSTC_POV_DIRECTIVE );
        r( wxSTC_POV_IDENTIFIER );
        r( wxSTC_POV_NUMBER );
        r( wxSTC_POV_OPERATOR );
        r( wxSTC_POV_STRING );
        r( wxSTC_POV_STRINGEOL );
        r( wxSTC_POV_WORD2 );
        r( wxSTC_POV_WORD3 );
        r( wxSTC_POV_WORD4 );
        r( wxSTC_POV_WORD5 );
        r( wxSTC_POV_WORD6 );
        r( wxSTC_POV_WORD7 );
        r( wxSTC_POV_WORD8 );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_POWERSHELL_DEFAULT );
        r( wxSTC_POWERSHELL_COMMENT );
        r( wxSTC_POWERSHELL_STRING );
        r( wxSTC_POWERSHELL_CHARACTER );
        r( wxSTC_POWERSHELL_NUMBER );
        r( wxSTC_POWERSHELL_VARIABLE );
        r( wxSTC_POWERSHELL_OPERATOR );
        r( wxSTC_POWERSHELL_IDENTIFIER );
        r( wxSTC_POWERSHELL_KEYWORD );
        r( wxSTC_POWERSHELL_CMDLET );
        r( wxSTC_POWERSHELL_ALIAS );
        r( wxSTC_PO_DEFAULT );
        r( wxSTC_PO_COMMENT );
        r( wxSTC_PO_MSGID );
        r( wxSTC_PO_MSGID_TEXT );
        r( wxSTC_PO_MSGSTR );
        r( wxSTC_PO_MSGSTR_TEXT );
        r( wxSTC_PO_MSGCTXT );
        r( wxSTC_PO_MSGCTXT_TEXT );
        r( wxSTC_PO_FUZZY );
        r( wxSTC_PAS_DEFAULT );
        r( wxSTC_PAS_IDENTIFIER );
        r( wxSTC_PAS_COMMENT );
        r( wxSTC_PAS_COMMENT2 );
        r( wxSTC_PAS_COMMENTLINE );
        r( wxSTC_PAS_PREPROCESSOR );
        r( wxSTC_PAS_PREPROCESSOR2 );
        r( wxSTC_PAS_NUMBER );
        r( wxSTC_PAS_HEXNUMBER );
        r( wxSTC_PAS_WORD );
        r( wxSTC_PAS_STRING );
        r( wxSTC_PAS_STRINGEOL );
        r( wxSTC_PAS_CHARACTER );
        r( wxSTC_PAS_OPERATOR );
        r( wxSTC_PAS_ASM );
        r( wxSTC_POWERPRO_DEFAULT );
        r( wxSTC_POWERPRO_COMMENTBLOCK );
        r( wxSTC_POWERPRO_COMMENTLINE );
        r( wxSTC_POWERPRO_NUMBER );
        r( wxSTC_POWERPRO_WORD );
        r( wxSTC_POWERPRO_WORD2 );
        r( wxSTC_POWERPRO_WORD3 );
        r( wxSTC_POWERPRO_WORD4 );
        r( wxSTC_POWERPRO_DOUBLEQUOTEDSTRING );
        r( wxSTC_POWERPRO_SINGLEQUOTEDSTRING );
        r( wxSTC_POWERPRO_LINECONTINUE );
        r( wxSTC_POWERPRO_OPERATOR );
        r( wxSTC_POWERPRO_IDENTIFIER );
        r( wxSTC_POWERPRO_STRINGEOL );
        r( wxSTC_POWERPRO_VERBATIM );
        r( wxSTC_POWERPRO_ALTQUOTE );
        r( wxSTC_POWERPRO_FUNCTION );
#endif  
        break;
    case 'R':
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_RB_BACKTICKS );
        r( wxSTC_RB_CHARACTER );
        r( wxSTC_RB_CLASSNAME );
        r( wxSTC_RB_CLASS_VAR );
        r( wxSTC_RB_COMMENTLINE );
        r( wxSTC_RB_DATASECTION );
        r( wxSTC_RB_DEFAULT );
        r( wxSTC_RB_DEFNAME );
        r( wxSTC_RB_ERROR );
        r( wxSTC_RB_GLOBAL );
        r( wxSTC_RB_HERE_DELIM );
        r( wxSTC_RB_HERE_Q );
        r( wxSTC_RB_HERE_QQ );
        r( wxSTC_RB_HERE_QX );
        r( wxSTC_RB_IDENTIFIER );
        r( wxSTC_RB_INSTANCE_VAR );
        r( wxSTC_RB_MODULE_NAME );
        r( wxSTC_RB_NUMBER );
        r( wxSTC_RB_OPERATOR );
        r( wxSTC_RB_POD );
        r( wxSTC_RB_REGEX );
        r( wxSTC_RB_STDERR );
        r( wxSTC_RB_STDIN );
        r( wxSTC_RB_STDOUT );
        r( wxSTC_RB_STRING );
        r( wxSTC_RB_STRING_Q );
        r( wxSTC_RB_STRING_QQ );
        r( wxSTC_RB_STRING_QR );
        r( wxSTC_RB_STRING_QW );
        r( wxSTC_RB_STRING_QX );
        r( wxSTC_RB_SYMBOL );
        r( wxSTC_RB_UPPER_BOUND );
        r( wxSTC_RB_WORD );
        r( wxSTC_RB_WORD_DEMOTED );
        r( wxSTC_REBOL_BINARY );
        r( wxSTC_REBOL_BRACEDSTRING );
        r( wxSTC_REBOL_CHARACTER );
        r( wxSTC_REBOL_COMMENTBLOCK );
        r( wxSTC_REBOL_COMMENTLINE );
        r( wxSTC_REBOL_DATE );
        r( wxSTC_REBOL_DEFAULT );
        r( wxSTC_REBOL_EMAIL );
        r( wxSTC_REBOL_FILE );
        r( wxSTC_REBOL_IDENTIFIER );
        r( wxSTC_REBOL_ISSUE );
        r( wxSTC_REBOL_MONEY );
        r( wxSTC_REBOL_NUMBER );
        r( wxSTC_REBOL_OPERATOR );
        r( wxSTC_REBOL_PAIR );
        r( wxSTC_REBOL_PREFACE );
        r( wxSTC_REBOL_QUOTEDSTRING );
        r( wxSTC_REBOL_TAG );
        r( wxSTC_REBOL_TIME );
        r( wxSTC_REBOL_TUPLE );
        r( wxSTC_REBOL_URL );
        r( wxSTC_REBOL_WORD );
        r( wxSTC_REBOL_WORD2 );
        r( wxSTC_REBOL_WORD3 );
        r( wxSTC_REBOL_WORD4 );
        r( wxSTC_REBOL_WORD5 );
        r( wxSTC_REBOL_WORD6 );
        r( wxSTC_REBOL_WORD7 );
        r( wxSTC_REBOL_WORD8 );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_R_BASEKWORD );
        r( wxSTC_R_COMMENT );
        r( wxSTC_R_DEFAULT );
        r( wxSTC_R_IDENTIFIER );
        r( wxSTC_R_INFIX );
        r( wxSTC_R_INFIXEOL );
        r( wxSTC_R_KWORD );
        r( wxSTC_R_NUMBER );
        r( wxSTC_R_OPERATOR );
        r( wxSTC_R_OTHERKWORD );
        r( wxSTC_R_STRING );
        r( wxSTC_R_STRING2 );
#endif
        break;
    case 'S':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_SCMOD_META );
#endif        
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_STATUS_OK );
        r( wxSTC_STATUS_FAILURE );
        r( wxSTC_STATUS_BADALLOC );
        r( wxSTC_SCVS_NONE );
        r( wxSTC_SCVS_RECTANGULARSELECTION );
        r( wxSTC_SCVS_USERACCESSIBLE );
        r( wxSTC_SORCUS_DEFAULT );
        r( wxSTC_SORCUS_COMMAND );
        r( wxSTC_SORCUS_PARAMETER );
        r( wxSTC_SORCUS_COMMENTLINE );
        r( wxSTC_SORCUS_STRING );
        r( wxSTC_SORCUS_STRINGEOL );
        r( wxSTC_SORCUS_IDENTIFIER );
        r( wxSTC_SORCUS_OPERATOR );
        r( wxSTC_SORCUS_NUMBER );
        r( wxSTC_SORCUS_CONSTANT );
        r( wxSTC_SML_DEFAULT );
        r( wxSTC_SML_IDENTIFIER );
        r( wxSTC_SML_TAGNAME );
        r( wxSTC_SML_KEYWORD );
        r( wxSTC_SML_KEYWORD2 );
        r( wxSTC_SML_KEYWORD3 );
        r( wxSTC_SML_LINENUM );
        r( wxSTC_SML_OPERATOR );
        r( wxSTC_SML_NUMBER );
        r( wxSTC_SML_CHAR );
        r( wxSTC_SML_STRING );
        r( wxSTC_SML_COMMENT );
        r( wxSTC_SML_COMMENT1 );
        r( wxSTC_SML_COMMENT2 );
        r( wxSTC_SML_COMMENT3 );
#endif
        r( wxSTC_STYLE_DEFAULT );
        r( wxSTC_STYLE_LINENUMBER );
        r( wxSTC_STYLE_BRACELIGHT );
        r( wxSTC_STYLE_BRACEBAD );
        r( wxSTC_STYLE_CONTROLCHAR );
        r( wxSTC_STYLE_INDENTGUIDE );
        r( wxSTC_STYLE_LASTPREDEFINED );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_STYLE_CALLTIP );
#endif
        r( wxSTC_STYLE_MAX );
        r( wxSTC_SCMOD_SHIFT );
        r( wxSTC_SCMOD_CTRL );
        r( wxSTC_SCMOD_ALT );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_SCMOD_NORM );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_SCMOD_SUPER );
#endif
        r( wxSTC_SCRIPTOL_DEFAULT );
        r( wxSTC_SCRIPTOL_COMMENTLINE );
        r( wxSTC_SCRIPTOL_NUMBER );
        r( wxSTC_SCRIPTOL_STRING );
        r( wxSTC_SCRIPTOL_CHARACTER );
        r( wxSTC_SCRIPTOL_PREPROCESSOR );
        r( wxSTC_SCRIPTOL_OPERATOR );
        r( wxSTC_SCRIPTOL_IDENTIFIER );
        r( wxSTC_SCRIPTOL_STRINGEOL );
        r( wxSTC_SCRIPTOL_CLASSNAME );
        r( wxSTC_SCRIPTOL_COMMENTBLOCK );
        r( wxSTC_SCRIPTOL_CSTYLE );
        r( wxSTC_SCRIPTOL_KEYWORD );
        r( wxSTC_SCRIPTOL_PERSISTENT );
        r( wxSTC_SCRIPTOL_TRIPLE );
        r( wxSTC_SCRIPTOL_WHITE );
        r( wxSTC_SH_BACKTICKS );
        r( wxSTC_SH_CHARACTER );
        r( wxSTC_SH_COMMENTLINE );
        r( wxSTC_SH_DEFAULT );
        r( wxSTC_SH_ERROR );
        r( wxSTC_SH_HERE_DELIM );
        r( wxSTC_SH_HERE_Q );
        r( wxSTC_SH_IDENTIFIER );
        r( wxSTC_SH_NUMBER );
        r( wxSTC_SH_OPERATOR );
        r( wxSTC_SH_PARAM );
        r( wxSTC_SH_SCALAR );
        r( wxSTC_SH_STRING );
        r( wxSTC_SH_WORD );
        r( wxSTC_SN_CODE );
        r( wxSTC_SN_COMMENTLINE );
        r( wxSTC_SN_COMMENTLINEBANG );
        r( wxSTC_SN_DEFAULT );
        r( wxSTC_SN_IDENTIFIER );
        r( wxSTC_SN_NUMBER );
        r( wxSTC_SN_OPERATOR );
        r( wxSTC_SN_PREPROCESSOR );
        r( wxSTC_SN_REGEXTAG );
        r( wxSTC_SN_SIGNAL );
        r( wxSTC_SN_STRING );
        r( wxSTC_SN_STRINGEOL );
        r( wxSTC_SN_USER );
        r( wxSTC_SN_WORD );
        r( wxSTC_SN_WORD2 );
        r( wxSTC_SN_WORD3 );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_SPICE_COMMENTLINE );
        r( wxSTC_SPICE_DEFAULT );
        r( wxSTC_SPICE_DELIMITER );
        r( wxSTC_SPICE_IDENTIFIER );
        r( wxSTC_SPICE_KEYWORD );
        r( wxSTC_SPICE_KEYWORD2 );
        r( wxSTC_SPICE_KEYWORD3 );
        r( wxSTC_SPICE_NUMBER );
        r( wxSTC_SPICE_VALUE );
        r( wxSTC_SQL_CHARACTER );
        r( wxSTC_SQL_COMMENT );
        r( wxSTC_SQL_COMMENTDOC );
        r( wxSTC_SQL_COMMENTDOCKEYWORD );
        r( wxSTC_SQL_COMMENTDOCKEYWORDERROR );
        r( wxSTC_SQL_COMMENTLINE );
        r( wxSTC_SQL_COMMENTLINEDOC );
        r( wxSTC_SQL_DEFAULT );
        r( wxSTC_SQL_IDENTIFIER );
        r( wxSTC_SQL_NUMBER );
        r( wxSTC_SQL_OPERATOR );
        r( wxSTC_SQL_QUOTEDIDENTIFIER );
        r( wxSTC_SQL_SQLPLUS );
        r( wxSTC_SQL_SQLPLUS_COMMENT );
        r( wxSTC_SQL_SQLPLUS_PROMPT );
        r( wxSTC_SQL_STRING );
        r( wxSTC_SQL_USER1 );
        r( wxSTC_SQL_USER2 );
        r( wxSTC_SQL_USER3 );
        r( wxSTC_SQL_USER4 );
        r( wxSTC_SQL_WORD );
        r( wxSTC_SQL_WORD2 );
        r( wxSTC_ST_ASSIGN );
        r( wxSTC_ST_BINARY );
        r( wxSTC_ST_BOOL );
        r( wxSTC_ST_CHARACTER );
        r( wxSTC_ST_COMMENT );
        r( wxSTC_ST_DEFAULT );
        r( wxSTC_ST_GLOBAL );
        r( wxSTC_ST_KWSEND );
        r( wxSTC_ST_NIL );
        r( wxSTC_ST_NUMBER );
        r( wxSTC_ST_RETURN );
        r( wxSTC_ST_SELF );
        r( wxSTC_ST_SPECIAL );
        r( wxSTC_ST_SPEC_SEL );
        r( wxSTC_ST_STRING );
        r( wxSTC_ST_SUPER );
        r( wxSTC_ST_SYMBOL );
        r( wxSTC_START );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_STARTACTION );
#endif
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_SEL_STREAM );
        r( wxSTC_SEL_RECTANGLE );
        r( wxSTC_SEL_LINES );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_SEL_THIN );
#endif
        r( wxEVT_STC_CHANGE );
        r( wxEVT_STC_STYLENEEDED );
        r( wxEVT_STC_CHARADDED );
        r( wxEVT_STC_CLIPBOARD_COPY );
        r( wxEVT_STC_CLIPBOARD_PASTE );
        r( wxEVT_STC_SAVEPOINTREACHED );
        r( wxEVT_STC_SAVEPOINTLEFT );
        r( wxEVT_STC_ROMODIFYATTEMPT );
        r( wxEVT_STC_KEY );
        r( wxEVT_STC_DOUBLECLICK );
        r( wxEVT_STC_UPDATEUI );
        r( wxEVT_STC_MODIFIED );
        r( wxEVT_STC_MACRORECORD );
        r( wxEVT_STC_MARGINCLICK );
        r( wxEVT_STC_NEEDSHOWN );
#if WXPERL_W_VERSION_LT( 2, 5, 2 )
        r( wxEVT_STC_POSCHANGED );
#endif
        r( wxEVT_STC_PAINTED );
        r( wxEVT_STC_USERLISTSELECTION );
        r( wxEVT_STC_URIDROPPED );
        r( wxEVT_STC_DWELLSTART );
        r( wxEVT_STC_DWELLEND );
        r( wxEVT_STC_START_DRAG );
        r( wxEVT_STC_DRAG_OVER );
        r( wxEVT_STC_DO_DROP );
        r( wxEVT_STC_ZOOM );
        r( wxEVT_STC_HOTSPOT_CLICK );
        r( wxEVT_STC_HOTSPOT_DCLICK );
        r( wxEVT_STC_CALLTIP_CLICK );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxEVT_STC_AUTOCOMP_CANCELLED );
        r( wxEVT_STC_AUTOCOMP_CHAR_DELETED );
#endif
        break;
    case 'T':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_TCMD_DEFAULT );
        r( wxSTC_TCMD_COMMENT );
        r( wxSTC_TCMD_WORD );
        r( wxSTC_TCMD_LABEL );
        r( wxSTC_TCMD_HIDE );
        r( wxSTC_TCMD_COMMAND );
        r( wxSTC_TCMD_IDENTIFIER );
        r( wxSTC_TCMD_OPERATOR );
        r( wxSTC_TCMD_ENVIRONMENT );
        r( wxSTC_TCMD_EXPANSION );
        r( wxSTC_TCMD_CLABEL );
        r( wxSTC_TECHNOLOGY_DEFAULT );
        r( wxSTC_TECHNOLOGY_DIRECTWRITE );
        r( wxSTC_TXT2TAGS_DEFAULT );
        r( wxSTC_TXT2TAGS_LINE_BEGIN );
        r( wxSTC_TXT2TAGS_STRONG1 );
        r( wxSTC_TXT2TAGS_STRONG2 );
        r( wxSTC_TXT2TAGS_EM1 );
        r( wxSTC_TXT2TAGS_EM2 );
        r( wxSTC_TXT2TAGS_HEADER1 );
        r( wxSTC_TXT2TAGS_HEADER2 );
        r( wxSTC_TXT2TAGS_HEADER3 );
        r( wxSTC_TXT2TAGS_HEADER4 );
        r( wxSTC_TXT2TAGS_HEADER5 );
        r( wxSTC_TXT2TAGS_HEADER6 );
        r( wxSTC_TXT2TAGS_PRECHAR );
        r( wxSTC_TXT2TAGS_ULIST_ITEM );
        r( wxSTC_TXT2TAGS_OLIST_ITEM );
        r( wxSTC_TXT2TAGS_BLOCKQUOTE );
        r( wxSTC_TXT2TAGS_STRIKEOUT );
        r( wxSTC_TXT2TAGS_HRULE );
        r( wxSTC_TXT2TAGS_LINK );
        r( wxSTC_TXT2TAGS_CODE );
        r( wxSTC_TXT2TAGS_CODE2 );
        r( wxSTC_TXT2TAGS_CODEBK );
        r( wxSTC_TXT2TAGS_COMMENT );
        r( wxSTC_TXT2TAGS_OPTION );
        r( wxSTC_TXT2TAGS_PREPROC );
        r( wxSTC_TXT2TAGS_POSTPROC );
        r( wxSTC_TYPE_BOOLEAN );
        r( wxSTC_TYPE_INTEGER );
        r( wxSTC_TYPE_STRING );
#endif        
        r( wxSTC_TIME_FOREVER );
#if WXPERL_W_VERSION_GE( 2, 5, 2 )
        r( wxSTC_TEX_DEFAULT );
        r( wxSTC_TEX_SPECIAL );
        r( wxSTC_TEX_GROUP );
        r( wxSTC_TEX_SYMBOL );
        r( wxSTC_TEX_COMMAND );
        r( wxSTC_TEX_TEXT );
#endif
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_T3_BLOCK_COMMENT );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_T3_BRACE );
#endif
        r( wxSTC_T3_DEFAULT );
        r( wxSTC_T3_D_STRING );
        r( wxSTC_T3_HTML_DEFAULT );
        r( wxSTC_T3_HTML_STRING );
        r( wxSTC_T3_HTML_TAG );
        r( wxSTC_T3_IDENTIFIER );
        r( wxSTC_T3_KEYWORD );
        r( wxSTC_T3_LIB_DIRECTIVE );
        r( wxSTC_T3_LINE_COMMENT );
        r( wxSTC_T3_MSG_PARAM );
        r( wxSTC_T3_NUMBER );
        r( wxSTC_T3_OPERATOR );
        r( wxSTC_T3_PREPROCESSOR );
        r( wxSTC_T3_S_STRING );
        r( wxSTC_T3_USER1 );
        r( wxSTC_T3_USER2 );
        r( wxSTC_T3_USER3 );
        r( wxSTC_T3_X_DEFAULT );
        r( wxSTC_T3_X_STRING );
        r( wxSTC_TCL_BLOCK_COMMENT );
        r( wxSTC_TCL_COMMENT );
        r( wxSTC_TCL_COMMENTLINE );
        r( wxSTC_TCL_COMMENT_BOX );
        r( wxSTC_TCL_DEFAULT );
        r( wxSTC_TCL_EXPAND );
        r( wxSTC_TCL_IDENTIFIER );
        r( wxSTC_TCL_IN_QUOTE );
        r( wxSTC_TCL_MODIFIER );
        r( wxSTC_TCL_NUMBER );
        r( wxSTC_TCL_OPERATOR );
        r( wxSTC_TCL_SUBSTITUTION );
        r( wxSTC_TCL_SUB_BRACE );
        r( wxSTC_TCL_WORD );
        r( wxSTC_TCL_WORD2 );
        r( wxSTC_TCL_WORD3 );
        r( wxSTC_TCL_WORD4 );
        r( wxSTC_TCL_WORD5 );
        r( wxSTC_TCL_WORD6 );
        r( wxSTC_TCL_WORD7 );
        r( wxSTC_TCL_WORD8 );
        r( wxSTC_TCL_WORD_IN_QUOTE );
#endif
        break;
    case 'U':
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_UNDO_MAY_COALESCE );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_UPDATE_CONTENT );
        r( wxSTC_UPDATE_SELECTION );
        r( wxSTC_UPDATE_V_SCROLL );
        r( wxSTC_UPDATE_H_SCROLL );
#endif
        break;
    case 'V':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_VISUALPROLOG_DEFAULT );
        r( wxSTC_VISUALPROLOG_KEY_MAJOR );
        r( wxSTC_VISUALPROLOG_KEY_MINOR );
        r( wxSTC_VISUALPROLOG_KEY_DIRECTIVE );
        r( wxSTC_VISUALPROLOG_COMMENT_BLOCK );
        r( wxSTC_VISUALPROLOG_COMMENT_LINE );
        r( wxSTC_VISUALPROLOG_COMMENT_KEY );
        r( wxSTC_VISUALPROLOG_COMMENT_KEY_ERROR );
        r( wxSTC_VISUALPROLOG_IDENTIFIER );
        r( wxSTC_VISUALPROLOG_VARIABLE );
        r( wxSTC_VISUALPROLOG_ANONYMOUS );
        r( wxSTC_VISUALPROLOG_NUMBER );
        r( wxSTC_VISUALPROLOG_OPERATOR );
        r( wxSTC_VISUALPROLOG_CHARACTER );
        r( wxSTC_VISUALPROLOG_CHARACTER_TOO_MANY );
        r( wxSTC_VISUALPROLOG_CHARACTER_ESCAPE_ERROR );
        r( wxSTC_VISUALPROLOG_STRING );
        r( wxSTC_VISUALPROLOG_STRING_ESCAPE );
        r( wxSTC_VISUALPROLOG_STRING_ESCAPE_ERROR );
        r( wxSTC_VISUALPROLOG_STRING_EOL_OPEN );
        r( wxSTC_VISUALPROLOG_STRING_VERBATIM );
        r( wxSTC_VISUALPROLOG_STRING_VERBATIM_SPECIAL );
        r( wxSTC_VISUALPROLOG_STRING_VERBATIM_EOL );
#endif            
        r( wxSTC_VISIBLE_SLOP );
        r( wxSTC_VISIBLE_STRICT );
#if WXPERL_W_VERSION_GE( 2, 6, 0 )
        r( wxSTC_VHDL_ATTRIBUTE );
        r( wxSTC_VHDL_COMMENT );
        r( wxSTC_VHDL_COMMENTLINEBANG );
        r( wxSTC_VHDL_DEFAULT );
        r( wxSTC_VHDL_IDENTIFIER );
        r( wxSTC_VHDL_KEYWORD );
        r( wxSTC_VHDL_NUMBER );
        r( wxSTC_VHDL_OPERATOR );
        r( wxSTC_VHDL_STDFUNCTION );
        r( wxSTC_VHDL_STDOPERATOR );
        r( wxSTC_VHDL_STDPACKAGE );
        r( wxSTC_VHDL_STDTYPE );
        r( wxSTC_VHDL_STRING );
        r( wxSTC_VHDL_STRINGEOL );
        r( wxSTC_VHDL_USERWORD );
#endif
        r( wxSTC_V_COMMENT );
        r( wxSTC_V_COMMENTLINE );
        r( wxSTC_V_COMMENTLINEBANG );
        r( wxSTC_V_DEFAULT );
        r( wxSTC_V_IDENTIFIER );
        r( wxSTC_V_NUMBER );
        r( wxSTC_V_OPERATOR );
        r( wxSTC_V_PREPROCESSOR );
        r( wxSTC_V_STRING );
        r( wxSTC_V_STRINGEOL );
        r( wxSTC_V_USER );
        r( wxSTC_V_WORD );
        r( wxSTC_V_WORD2 );
        r( wxSTC_V_WORD3 );
        break;
    case 'W':
#if WXPERL_W_VERSION_GE( 2, 9, 5 )
        r( wxSTC_WEIGHT_NORMAL );
        r( wxSTC_WEIGHT_SEMIBOLD );
        r( wxSTC_WEIGHT_BOLD );
        r( wxSTC_WRAPVISUALFLAG_MARGIN );
#endif
        r( wxSTC_WRAP_NONE );
        r( wxSTC_WRAP_WORD );
#if WXPERL_W_VERSION_GE( 2, 7, 2 )
        r( wxSTC_WRAP_CHAR );
#endif

        r( wxSTC_WRAPVISUALFLAGLOC_DEFAULT );
        r( wxSTC_WRAPVISUALFLAGLOC_END_BY_TEXT );
        r( wxSTC_WRAPVISUALFLAGLOC_START_BY_TEXT );
        r( wxSTC_WRAPVISUALFLAG_END );
        r( wxSTC_WRAPVISUALFLAG_NONE );
        r( wxSTC_WRAPVISUALFLAG_START );

        r( wxSTC_WS_INVISIBLE );
        r( wxSTC_WS_VISIBLEALWAYS );
        r( wxSTC_WS_VISIBLEAFTERINDENT );
#if WXPERL_W_VERSION_GE( 2, 9, 4 )
        r( wxSTC_WRAPINDENT_FIXED );
        r( wxSTC_WRAPINDENT_SAME );
        r( wxSTC_WRAPINDENT_INDENT ); 
#endif
        break;
    case 'Y':
        r( wxSTC_YAML_COMMENT );
        r( wxSTC_YAML_DEFAULT );
        r( wxSTC_YAML_DOCUMENT );
        r( wxSTC_YAML_ERROR );
        r( wxSTC_YAML_IDENTIFIER );
        r( wxSTC_YAML_KEYWORD );
        r( wxSTC_YAML_NUMBER );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
        r( wxSTC_YAML_OPERATOR );
#endif
        r( wxSTC_YAML_REFERENCE );
        r( wxSTC_YAML_TEXT );
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants stc_module( &stc_constant );
