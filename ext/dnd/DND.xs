/////////////////////////////////////////////////////////////////////////////
// Name:        DND.xs
// Purpose:     XS for Drag'n'Drop and Clipboard
// Author:      Mattia Barbon
// Modified by:
// Created:     12/ 8/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>
#include <stdarg.h>

#include "cpp/compat.h"
#include "cpp/chkconfig.h"

WXPL_EXTERN_C_START
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
WXPL_EXTERN_C_END

#undef bool
#undef Move
#undef Copy
#undef Pause
#undef New
#undef read
#undef eof
#undef write
#ifdef __WXMSW__
#undef form
#undef vform
#endif

#undef THIS

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#if !WXPL_MSW_EXPORTS
#define _WXP_DEFINE_CLASSNAME 1
#endif
#include "cpp/typedef.h"
#include "cpp/helpers.h"
#include "cpp/dn_typedef.h"

#include <wx/dataobj.h>
#include "cpp/dn_constants.cpp"

typedef wxDataObjectBase::Direction Direction;
typedef wxDataFormat::NativeFormat  NativeFormat;

#include <wx/dataobj.h>

void SetDNDConstants()
{
    SV* tmp;

    tmp = get_sv( "Wx::_df_invalid", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_INVALID ) );

    tmp = get_sv( "Wx::_df_text", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_TEXT ) );

    tmp = get_sv( "Wx::_df_bitmap", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_BITMAP ) );

    tmp = get_sv( "Wx::_df_metafile", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_METAFILE ) );

    tmp = get_sv( "Wx::_df_filename", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxDF_FILENAME ) );
}

MODULE=Wx__DND

BOOT:
#if !WXPL_MSW_EXPORTS
  INIT_PLI_HELPERS( wx_pli_helpers );
#endif
  
INCLUDE: XS/DataObject.xs
INCLUDE: XS/DropFiles.xs
INCLUDE: XS/Clipboard.xs
INCLUDE: XS/DropSource.xs
INCLUDE: XS/DropTarget.xs

MODULE=Wx__DND PACKAGE=Wx

void
SetDNDConstants()

#  //FIXME//tricky
#if __WXMSW__
#undef XS
#define XS( name ) __declspec(dllexport) void name( pTHXo_ CV* cv )
#endif

MODULE=Wx__DND
