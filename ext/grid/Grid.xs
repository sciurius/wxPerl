/////////////////////////////////////////////////////////////////////////////
// Name:        Grid.xs
// Purpose:     XS for Wx::Grid
// Author:      Mattia Barbon
// Modified by:
// Created:      4/12/2001
// RCS-ID:      
// Copyright:   (c) 2001-2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"
#include "cpp/gr_typedef.h"

#undef THIS

#include <wx/grid.h>
typedef wxGrid::wxGridSelectionModes wxGridSelectionModes;
#if WXPERL_W_VERSION_GE( 2, 3, 1 )
typedef wxGridCellAttr::wxAttrKind wxAttrKind;
#endif

MODULE=Wx__Grid

BOOT:
  INIT_PLI_HELPERS( wx_pli_helpers );

INCLUDE: XS/Grid.xs
INCLUDE: XS/GridCellAttr.xs
INCLUDE: XS/GridEvent.xs
INCLUDE: XS/GridCellRenderer.xs
INCLUDE: XS/GridCellEditor.xs

#include "cpp/gr_constants.cpp"

#  //FIXME//tricky
#if defined(__WXMSW__)
#undef XS
#define XS( name ) WXXS( name )
#endif

MODULE=Wx__Grid