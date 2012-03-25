/////////////////////////////////////////////////////////////////////////////
// Name:        ribbon_constants.cpp
// Purpose:     wxRibbon constants
// Author:      Mark Dootson
// SVN ID:      $Id:  $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <cpp/constants.h>
#include <wx/ribbon/art.h>
#include <wx/ribbon/bar.h>
#include <wx/ribbon/buttonbar.h>
#include <wx/ribbon/control.h>
#include <wx/ribbon/gallery.h>
#include <wx/ribbon/page.h>
#include <wx/ribbon/panel.h>
#include <wx/ribbon/toolbar.h>

double ribbon_constant( const char* name, int arg )
{
    // !package: Wx
    // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
    // !tag: ribbon
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

    WX_PL_CONSTANT_INIT();

    switch( fl )
    {
    case 'R':
        r( wxRIBBON_BAR_SHOW_PAGE_LABELS );
        r( wxRIBBON_BAR_SHOW_PAGE_ICONS );
        r( wxRIBBON_BAR_FLOW_HORIZONTAL );
        r( wxRIBBON_BAR_FLOW_VERTICAL );
        r( wxRIBBON_BAR_SHOW_PANEL_EXT_BUTTONS );
        r( wxRIBBON_BAR_SHOW_PANEL_MINIMISE_BUTTONS );
        r( wxRIBBON_BAR_ALWAYS_SHOW_TABS );
        r( wxRIBBON_BAR_DEFAULT_STYLE );
        r( wxRIBBON_BAR_FOLDBAR_STYLE );
        
        r( wxRIBBON_PANEL_NO_AUTO_MINIMISE );
        r( wxRIBBON_PANEL_EXT_BUTTON );
        r( wxRIBBON_PANEL_MINIMISE_BUTTON );
        r( wxRIBBON_PANEL_DEFAULT_STYLE );
        
        r( wxRIBBON_TOOLBAR_TOOL_FIRST );
        r( wxRIBBON_TOOLBAR_TOOL_LAST );
        r( wxRIBBON_TOOLBAR_TOOL_POSITION_MASK );
        r( wxRIBBON_TOOLBAR_TOOL_NORMAL_HOVERED );
        r( wxRIBBON_TOOLBAR_TOOL_DROPDOWN_HOVERED );
        r( wxRIBBON_TOOLBAR_TOOL_HOVER_MASK );
        r( wxRIBBON_TOOLBAR_TOOL_NORMAL_HOVERED );
        r( wxRIBBON_TOOLBAR_TOOL_DROPDOWN_HOVERED );
        r( wxRIBBON_TOOLBAR_TOOL_NORMAL_ACTIVE );
        r( wxRIBBON_TOOLBAR_TOOL_DROPDOWN_ACTIVE );
        r( wxRIBBON_TOOLBAR_TOOL_ACTIVE_MASK );
        r( wxRIBBON_TOOLBAR_TOOL_NORMAL_ACTIVE );
        r( wxRIBBON_TOOLBAR_TOOL_DROPDOWN_ACTIVE );
        r( wxRIBBON_TOOLBAR_TOOL_DISABLED );
        r( wxRIBBON_TOOLBAR_TOOL_STATE_MASK );
        
        r( wxRIBBON_SCROLL_BTN_LEFT );
        r( wxRIBBON_SCROLL_BTN_RIGHT );
        r( wxRIBBON_SCROLL_BTN_UP );
        r( wxRIBBON_SCROLL_BTN_DOWN );
        r( wxRIBBON_SCROLL_BTN_DIRECTION_MASK );
        r( wxRIBBON_SCROLL_BTN_NORMAL );
        r( wxRIBBON_SCROLL_BTN_HOVERED );
        r( wxRIBBON_SCROLL_BTN_ACTIVE );
        r( wxRIBBON_SCROLL_BTN_STATE_MASK );
        r( wxRIBBON_SCROLL_BTN_FOR_OTHER );
        r( wxRIBBON_SCROLL_BTN_FOR_TABS );
        r( wxRIBBON_SCROLL_BTN_FOR_PAGE );
        r( wxRIBBON_SCROLL_BTN_FOR_MASK );
        
        r( wxRIBBON_BUTTON_NORMAL );
        r( wxRIBBON_BUTTON_DROPDOWN );
        r( wxRIBBON_BUTTON_HYBRID );
        r( wxRIBBON_BUTTON_TOGGLE );
        
        r( wxRIBBON_BUTTONBAR_BUTTON_SMALL );
        r( wxRIBBON_BUTTONBAR_BUTTON_MEDIUM );
        r( wxRIBBON_BUTTONBAR_BUTTON_LARGE );
        r( wxRIBBON_BUTTONBAR_BUTTON_SIZE_MASK );
        r( wxRIBBON_BUTTONBAR_BUTTON_NORMAL_HOVERED );
        r( wxRIBBON_BUTTONBAR_BUTTON_DROPDOWN_HOVERED );
        r( wxRIBBON_BUTTONBAR_BUTTON_HOVER_MASK );
        r( wxRIBBON_BUTTONBAR_BUTTON_NORMAL_ACTIVE  );
        r( wxRIBBON_BUTTONBAR_BUTTON_DROPDOWN_ACTIVE  );
        r( wxRIBBON_BUTTONBAR_BUTTON_DISABLED  );
        r( wxRIBBON_BUTTONBAR_BUTTON_TOGGLED  );
        r( wxRIBBON_BUTTONBAR_BUTTON_STATE_MASK );
        
        r( wxRIBBON_GALLERY_BUTTON_NORMAL );
        r( wxRIBBON_GALLERY_BUTTON_HOVERED );
        r( wxRIBBON_GALLERY_BUTTON_ACTIVE );
        r( wxRIBBON_GALLERY_BUTTON_DISABLED );
        break;
    case 'E':        
        r( wxEVT_COMMAND_RIBBONBAR_PAGE_CHANGED );
        r( wxEVT_COMMAND_RIBBONBAR_PAGE_CHANGING );
        r( wxEVT_COMMAND_RIBBONBAR_TAB_MIDDLE_DOWN );
        r( wxEVT_COMMAND_RIBBONBAR_TAB_MIDDLE_UP );
        r( wxEVT_COMMAND_RIBBONBAR_TAB_RIGHT_DOWN );
        r( wxEVT_COMMAND_RIBBONBAR_TAB_RIGHT_UP );
        r( wxEVT_COMMAND_RIBBONBAR_TAB_LEFT_DCLICK );
        r( wxEVT_COMMAND_RIBBONBUTTON_CLICKED );
        r( wxEVT_COMMAND_RIBBONBUTTON_DROPDOWN_CLICKED );
        r( wxEVT_COMMAND_RIBBONGALLERY_HOVER_CHANGED );
        r( wxEVT_COMMAND_RIBBONGALLERY_SELECTED );
        r( wxEVT_COMMAND_RIBBONGALLERY_CLICKED );
        r( wxEVT_COMMAND_RIBBONTOOL_CLICKED );
        r( wxEVT_COMMAND_RIBBONTOOL_DROPDOWN_CLICKED );
        
        break;
    default:
        break;
    }

#undef r

  WX_PL_CONSTANT_CLEANUP();
}

wxPlConstants ribbon_module( &ribbon_constant );

