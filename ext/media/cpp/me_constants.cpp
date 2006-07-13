/////////////////////////////////////////////////////////////////////////////
// Name:        ext/media/cpp/me_constants.cpp
// Purpose:     constants for wxMediaCtrl
// Author:      Mattia Barbon
// Modified by:
// Created:     04/03/2006
// RCS-ID:      $Id: me_constants.cpp,v 1.5 2006/07/13 18:27:21 mbarbon Exp $
// Copyright:   (c) 2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"

#if wxUSE_MEDIACTRL

#include "wx/mediactrl.h"

double media_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: media
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'E':
        r( wxEVT_MEDIA_FINISHED );
        r( wxEVT_MEDIA_STOP );
        r( wxEVT_MEDIA_LOADED );
    case 'M':
        r( wxMEDIASTATE_STOPPED );
        r( wxMEDIASTATE_PAUSED );
        r( wxMEDIASTATE_PLAYING );

        r( wxMEDIACTRLPLAYERCONTROLS_NONE );
        r( wxMEDIACTRLPLAYERCONTROLS_STEP );
        r( wxMEDIACTRLPLAYERCONTROLS_VOLUME );
        r( wxMEDIACTRLPLAYERCONTROLS_DEFAULT );
        break;
    }
#undef r

    WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants media_module( &media_constant );

#endif

