/////////////////////////////////////////////////////////////////////////////
// Name:        ext/ribbon/Ribbon.xs
// Purpose:     XS for Wx::Ribbon
// Author:      Mark Dootson
// Modified by:
// Created:     01/03/2012
// SVN-ID:      $Id: RichText.xs 3134 2012-02-27 23:15:23Z mdootson $
// Copyright:   (c) 2012 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/constants.h"
#include "cpp/overload.h"

// re-include for client data
#include <wx/clntdata.h>
#include "cpp/helpers.h"
#include "cpp/array_helpers.h"

#undef THIS

#if WXPERL_W_VERSION_GE( 2, 9, 3 ) && wxUSE_RIBBON

#define wxNullBitmapPtr (wxBitmap*)&wxNullBitmap
#define wxDefaultValidatorPtr (wxValidator*)&wxDefaultValidator

#include <wx/ribbon/art.h>
#include <wx/ribbon/bar.h>
#include <wx/ribbon/buttonbar.h>
#include <wx/ribbon/control.h>
#include <wx/ribbon/gallery.h>
#include <wx/ribbon/page.h>
#include <wx/ribbon/panel.h>
#include <wx/ribbon/toolbar.h>

#endif

MODULE=Wx__Ribbon

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

#if WXPERL_W_VERSION_GE( 2, 9, 3 ) && wxUSE_RIBBON

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonGallery.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonBar.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonButtonBar.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonControl.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonPage.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonPanel.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonToolBar.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/RibbonArtProvider.xsp

MODULE=Wx__Ribbon PACKAGE=Wx::Ribbon

#include "cpp/ovl_const.cpp"
#include <cpp/ribbon_constants.cpp>

#endif

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Ribbon
