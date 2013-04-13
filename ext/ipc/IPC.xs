/////////////////////////////////////////////////////////////////////////////
// Name:        ext/ipc/IPC.xs
// Purpose:     XS for Inter-Process Communication Framework
// Author:      Mark Dootson
// Modified by:
// Created:     13 April 2013
// SVN-ID:      $Id:$
// Copyright:   (c) 2013 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#undef THIS

MODULE=Wx__IPC

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

#if wxPERL_USE_IPC

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t ../../typemap.xsp XS/IPC.xsp

#include "cpp/ovl_const.cpp"

#endif

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__IPC
