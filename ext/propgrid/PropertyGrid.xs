/////////////////////////////////////////////////////////////////////////////
// Name:        ext/propgrid/PropertyGrid.xs
// Purpose:     XS for Wx::PropertyGrid
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

#undef THIS

#if WXPERL_W_VERSION_GE( 2, 9, 3 ) && wxUSE_PROPGRID

#include <wx/propgrid/propgrid.h>
#include <wx/propgrid/advprops.h>
#include <wx/propgrid/manager.h>
#include <wx/propgrid/editors.h>
#include <wx/propgrid/props.h>
#include <wx/propgrid/propgriddefs.h>
#include <wx/statusbr.h>
#include <cpp/propgrid_declares.h>

#include "cpp/helpers.h"
#include "cpp/array_helpers.h"

#define wxNullColourPtr (wxColour*)&wxNullColour
#define wxNullPropertyPtr (wxPGProperty*)&wxNullProperty
#define wxNullBitmapPtr (wxBitmap*)&wxNullBitmap

#define wxPerl_build_default_propertyflags wxPG_ITERATE_PROPERTIES|wxPG_ITERATE_HIDDEN|wxPG_ITERATE_CATEGORIES

#endif

MODULE=Wx__PropertyGrid

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );
  
#if WXPERL_W_VERSION_GE( 2, 9, 3 ) && wxUSE_PROPGRID

##
## 
##

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PropertyGrid.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PGCell.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PGCellRenderer.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PGEditor.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PGProperty.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PropertyGridEvent.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PropertyGridManager.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PropertyGridPage.xsp

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t typemap.xsp -t ../../typemap.xsp XS/PropertyGridPageState.xsp


MODULE=Wx__PropertyGrid PACKAGE=Wx::PropertyGrid

## wxPerl implementations
## Cached strings

wxString
_get_wxPG_ATTR_UNITS()
  CODE:
    RETVAL = wxPG_ATTR_UNITS;
  OUTPUT: RETVAL
  
wxString
_get_wxPG_ATTR_HINT()
  CODE:
    RETVAL = wxPG_ATTR_HINT;
  OUTPUT: RETVAL
  
wxString
_get_wxPG_ATTR_DEFAULT_VALUE()
  CODE:
    RETVAL = wxPG_ATTR_DEFAULT_VALUE;
  OUTPUT: RETVAL
  
wxString
_get_wxPG_ATTR_MIN()
  CODE:
    RETVAL = wxPG_ATTR_MIN;
  OUTPUT: RETVAL
  
wxString
_get_wxPG_ATTR_MAX()
  CODE:
    RETVAL = wxPG_ATTR_MAX;
  OUTPUT: RETVAL


#include "cpp/ovl_const.cpp"
#include <cpp/propgrid_constants.cpp>

#endif

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__PropertyGrid
