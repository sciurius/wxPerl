/////////////////////////////////////////////////////////////////////////////
// Name:        docview.xs
// Purpose:     XS for wxWindows Document/View Framework
// Author:      Simon Flack
// Modified by:
// Created:     11/ 9/2002
// RCS-ID:      
// Copyright:   (c) 2002 Simon Flack
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT

#include <wx/defs.h>
#include <stdarg.h>

#include "cpp/compat.h"
#include "cpp/chkconfig.h"

#include <wx/docview.h>


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

#include "cpp/typedef.h"
#include "cpp/dv_typedef.h"
#include "cpp/helpers.h"
#include "cpp/docview.h"

MODULE=Wx__DocView

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/DocManager.xs
INCLUDE: XS/DocTemplate.xs
INCLUDE: XS/Document.xs
INCLUDE: XS/View.xs
INCLUDE: XS/FileHistory.xs
INCLUDE: XS/DocParentFrame.xs
INCLUDE: XS/DocChildFrame.xs

#if wxUSE_MDI_ARCHITECTURE && wxUSE_DOC_VIEW_ARCHITECTURE

INCLUDE: XS/DocMDIParentFrame.xs
INCLUDE: XS/DocMDIChildFrame.xs

#endif

#include "cpp/dv_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__DocView
