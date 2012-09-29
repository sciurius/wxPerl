/////////////////////////////////////////////////////////////////////////////
// Name:        PerlTest.xs
// Purpose:     XS for PerlTest
// Author:      Mark Dootson
// Modified by:
// Created:     2012-09-28
// RCS-ID:      $Id:$
// Copyright:   (c) 2012 Mark Dootson
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

#undef THIS

#include <cpp/src/perltest.cpp>

MODULE = Wx__PerlTest

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

#include "cpp/include/perltest.h"

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PerlTest.xsp

MODULE = Wx__PerlTest
