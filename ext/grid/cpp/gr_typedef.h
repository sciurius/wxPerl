/////////////////////////////////////////////////////////////////////////////
// Name:        gr_typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:      4/12/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_GRID_TYPEDEF_H
#define _WXPERL_GRID_TYPEDEF_H

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

FD_TD(Grid);
FD_TD(GridCellCoords);
FD_TD(GridCellAttr);
FD_TD(GridEvent);
FD_TD(GridSizeEvent);
FD_TD(GridRangeSelectEvent);
FD_TD(GridEditorCreatedEvent);

#undef FD_TD

#endif
  // _WXPERL_GRID_TYPEDEF_H

// Local variables: //
// mode: c++ //
// End: //

