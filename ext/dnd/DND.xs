/////////////////////////////////////////////////////////////////////////////
// Name:        ext/dnd/DND.xs
// Purpose:     XS for Drag'n'Drop and Clipboard
// Author:      Mattia Barbon
// Modified by:
// Created:     12/08/2001
// RCS-ID:      $Id: DND.xs,v 1.16 2004/12/21 21:12:48 mbarbon Exp $
// Copyright:   (c) 2001-2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

#include <wx/dataobj.h>
#include "cpp/dn_constants.cpp"

typedef wxDataObjectBase::Direction Direction;
typedef wxDataFormat::NativeFormat  NativeFormat;

#include <wx/dataobj.h>

MODULE=Wx__DND

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/DataObject.xs
INCLUDE: XS/Clipboard.xs

#if wxPERL_USE_DRAG_AND_DROP

INCLUDE: XS/DropFiles.xs
INCLUDE: XS/DropSource.xs
INCLUDE: XS/DropTarget.xs

#endif

MODULE=Wx__DND PACKAGE=Wx

wxDataFormat*
wxDF_TEXT()
  CODE:
    RETVAL = new wxDataFormat( wxDF_TEXT );
  OUTPUT: RETVAL

wxDataFormat*
wxDF_BITMAP()
  CODE:
    RETVAL = new wxDataFormat( wxDF_BITMAP );
  OUTPUT: RETVAL

#if defined(__WXMSW__)

wxDataFormat*
wxDF_METAFILE()
  CODE:
    RETVAL = new wxDataFormat( wxDF_METAFILE );
  OUTPUT: RETVAL

#endif

wxDataFormat*
wxDF_FILENAME()
  CODE:
    RETVAL = new wxDataFormat( wxDF_FILENAME );
  OUTPUT: RETVAL

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__DND
