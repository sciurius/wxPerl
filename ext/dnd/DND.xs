/////////////////////////////////////////////////////////////////////////////
// Name:        DND.xs
// Purpose:     XS for Drag'n'Drop and Clipboard
// Author:      Mattia Barbon
// Modified by:
// Created:     12/ 8/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/dn_typedef.h"

#undef THIS

#include <wx/dataobj.h>
#include "cpp/dn_constants.cpp"

typedef wxDataObjectBase::Direction Direction;
typedef wxDataFormat::NativeFormat  NativeFormat;

#include <wx/dataobj.h>

void SetDNDConstants()
{
    dTHX;
    SV* tmp;

//    tmp = get_sv( "Wx::_df_invalid", 0 );
//    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_INVALID ) );

    tmp = get_sv( "Wx::_df_text", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_TEXT ) );

    tmp = get_sv( "Wx::_df_bitmap", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_BITMAP ) );

#ifndef __WXGTK__
    tmp = get_sv( "Wx::_df_metafile", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_METAFILE ) );
#endif

    tmp = get_sv( "Wx::_df_filename", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_FILENAME ) );
}

MODULE=Wx__DND

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );
  
INCLUDE: XS/DataObject.xs
INCLUDE: XS/DropFiles.xs
INCLUDE: XS/Clipboard.xs
INCLUDE: XS/DropSource.xs
INCLUDE: XS/DropTarget.xs

MODULE=Wx__DND PACKAGE=Wx

void
SetDNDConstants()

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__DND
