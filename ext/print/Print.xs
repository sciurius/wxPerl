/////////////////////////////////////////////////////////////////////////////
// Name:        ext/print/Print.xs
// Purpose:     XS for Print Framework
// Author:      Mattia Barbon
// Modified by:
// Created:     04/05/2001
// RCS-ID:      $Id: Print.xs,v 1.15 2005/03/14 20:59:27 mbarbon Exp $
// Copyright:   (c) 2001-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

MODULE=Wx__Print

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

#if wxPERL_USE_PRINTING_ARCHITECTURE

INCLUDE: XS/PrintData.xs
INCLUDE: XS/PageSetupDialog.xs
INCLUDE: XS/PageSetupDialogData.xs
INCLUDE: XS/Printer.xs
INCLUDE: XS/PrintDialogData.xs
INCLUDE: XS/PrintPreview.xs
INCLUDE: XS/Printout.xs
INCLUDE: XS/PrintDialog.xs

INCLUDE: perl ../../script/xsubppp.pl --typemap ../../typemap.xsp XS/Preview.xs |

INCLUDE: perl ../../script/xsubppp.pl --typemap ../../typemap.xsp XS/PrintFactory.xsp |

#include "cpp/pr_constants.cpp"

#endif

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Print
