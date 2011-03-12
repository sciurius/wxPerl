/////////////////////////////////////////////////////////////////////////////
// Name:        ext/grid/Grid.xs
// Purpose:     XS for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:     04/12/2001
// RCS-ID:      $Id: Grid.xs 3002 2011-02-13 12:55:08Z mbarbon $
// Copyright:   (c) 2001-2004, 2006-2011 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"

#undef THIS

#include <wx/control.h>
#include <wx/grid.h>
#include <wx/generic/gridctrl.h>

#define wxGridCellAttr__wxAttrKind wxGridCellAttr::wxAttrKind

inline wxGridCellAttr* convert_GridCellAttrOut(pTHX_ SV* value)
{
     wxGridCellAttr* attr = (wxGridCellAttr*)wxPli_sv_2_object( aTHX_ value, "Wx::GridCellAttr" );

     attr->IncRef();

     return attr;
}

typedef wxGrid::wxGridSelectionModes wxGridSelectionModes;
typedef wxGridCellAttr::wxAttrKind wxAttrKind;

// event macros
#define SEVT( NAME, ARGS )    wxPli_StdEvent( NAME, ARGS )
#define EVT( NAME, ARGS, ID ) wxPli_Event( NAME, ARGS, ID )

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*S?EVT\(\s*(\w+)\s*\,> }

static wxPliEventDescription evts[] =
{
    EVT( EVT_GRID_CMD_CELL_LEFT_CLICK, 3, wxEVT_GRID_CELL_LEFT_CLICK )
    EVT( EVT_GRID_CMD_CELL_RIGHT_CLICK, 3, wxEVT_GRID_CELL_RIGHT_CLICK )
    EVT( EVT_GRID_CMD_CELL_LEFT_DCLICK, 3, wxEVT_GRID_CELL_LEFT_DCLICK )
    EVT( EVT_GRID_CMD_CELL_RIGHT_DCLICK, 3, wxEVT_GRID_CELL_RIGHT_DCLICK )
    EVT( EVT_GRID_CMD_LABEL_LEFT_CLICK, 3, wxEVT_GRID_LABEL_LEFT_CLICK )
    EVT( EVT_GRID_CMD_LABEL_RIGHT_CLICK, 3, wxEVT_GRID_LABEL_RIGHT_CLICK )
    EVT( EVT_GRID_CMD_LABEL_LEFT_DCLICK, 3, wxEVT_GRID_LABEL_LEFT_DCLICK )
    EVT( EVT_GRID_CMD_LABEL_RIGHT_DCLICK, 3, wxEVT_GRID_LABEL_RIGHT_DCLICK )
    EVT( EVT_GRID_CMD_ROW_SIZE, 3, wxEVT_GRID_ROW_SIZE )
    EVT( EVT_GRID_CMD_COL_SIZE, 3, wxEVT_GRID_COL_SIZE )
    EVT( EVT_GRID_CMD_RANGE_SELECT, 3, wxEVT_GRID_RANGE_SELECT )
#if WXPERL_W_VERSION_LT( 2, 9, 0 )
    EVT( EVT_GRID_CMD_CELL_CHANGE, 3, wxEVT_GRID_CELL_CHANGE )
    EVT( EVT_GRID_CMD_CELL_CHANGED, 3, wxEVT_GRID_CELL_CHANGE )
#else
    EVT( EVT_GRID_CMD_CELL_CHANGE, 3, wxEVT_GRID_CELL_CHANGED )
    EVT( EVT_GRID_CMD_CELL_CHANGED, 3, wxEVT_GRID_CELL_CHANGED )
    EVT( EVT_GRID_CMD_CELL_CHANGING, 3, wxEVT_GRID_CELL_CHANGING )
#endif
    EVT( EVT_GRID_CMD_SELECT_CELL, 3, wxEVT_GRID_SELECT_CELL )
    EVT( EVT_GRID_CMD_EDITOR_SHOWN, 3, wxEVT_GRID_EDITOR_SHOWN )
    EVT( EVT_GRID_CMD_EDITOR_HIDDEN, 3, wxEVT_GRID_EDITOR_HIDDEN )
    EVT( EVT_GRID_CMD_EDITOR_CREATED, 3, wxEVT_GRID_EDITOR_CREATED )
    EVT( EVT_GRID_CMD_CELL_BEGIN_DRAG, 3, wxEVT_GRID_CELL_BEGIN_DRAG )
    SEVT( EVT_GRID_CELL_LEFT_CLICK, 2 )
    SEVT( EVT_GRID_CELL_RIGHT_CLICK, 2 )
    SEVT( EVT_GRID_CELL_LEFT_DCLICK, 2 )
    SEVT( EVT_GRID_CELL_RIGHT_DCLICK, 2 )
    SEVT( EVT_GRID_LABEL_LEFT_CLICK, 2 )
    SEVT( EVT_GRID_LABEL_RIGHT_CLICK, 2 )
    SEVT( EVT_GRID_LABEL_LEFT_DCLICK, 2 )
    SEVT( EVT_GRID_LABEL_RIGHT_DCLICK, 2 )
    SEVT( EVT_GRID_ROW_SIZE, 2 )
    SEVT( EVT_GRID_COL_SIZE, 2 )
    SEVT( EVT_GRID_RANGE_SELECT, 2 )
#if WXPERL_W_VERSION_LT( 2, 9, 0 )
    SEVT( EVT_GRID_CELL_CHANGE, 2 )
    EVT( EVT_GRID_CELL_CHANGED, 2, wxEVT_GRID_CELL_CHANGE )
#else
    EVT( EVT_GRID_CELL_CHANGE, 2, wxEVT_GRID_CELL_CHANGED )
    SEVT( EVT_GRID_CELL_CHANGING, 2 )
    SEVT( EVT_GRID_CELL_CHANGED, 2 )
#endif
    SEVT( EVT_GRID_SELECT_CELL, 2 )
    SEVT( EVT_GRID_EDITOR_SHOWN, 2 )
    SEVT( EVT_GRID_EDITOR_HIDDEN, 2 )
    SEVT( EVT_GRID_EDITOR_CREATED, 2 )
    SEVT( EVT_GRID_CELL_BEGIN_DRAG, 2 )
    { 0, 0, 0 }
};

MODULE=Wx__Grid

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/Grid.xs
INCLUDE: XS/GridCellAttr.xs
INCLUDE: XS/GridEvent.xs
INCLUDE: XS/GridCellRenderer.xs
INCLUDE: XS/GridCellEditor.xs

INCLUDE_COMMAND: $^X -I../.. -MExtUtils::XSpp::Cmd -e xspp -- -t ../../typemap.xsp ../../interface/wx/grid/gridtablebase.h

INCLUDE_COMMAND: $^X -MExtUtils::XSpp::Cmd -e xspp -- -t ../../typemap.xsp XS/GridTableMessage.xsp

MODULE=Wx__Grid PACKAGE=Wx::Grid

void
SetEvents()
  CODE:
    wxPli_set_events( evts );

#include "cpp/gr_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Grid
