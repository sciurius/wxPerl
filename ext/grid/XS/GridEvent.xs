#############################################################################
## Name:        ext/grid/XS/GridEvent.xs
## Purpose:     XS for Wx::Grid*Event
## Author:      Mattia Barbon
## Modified by:
## Created:     08/12/2001
## RCS-ID:      $Id: GridEvent.xs,v 1.6 2004/02/29 14:30:40 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridEvent

wxGridEvent*
wxGridEvent::new( id, type, obj, row = -1, col = -1, x = -1, y = -1, sel = TRUE, control = TRUE, shift = TRUE, alt = TRUE, meta = TRUE )
    int id
    wxEventType type
    wxObject* obj
    int row
    int col
    int x
    int y
    bool sel
    bool control
    bool shift
    bool alt
    bool meta

int
wxGridEvent::GetRow()

int
wxGridEvent::GetCol()

wxPoint*
wxGridEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

bool
wxGridEvent::Selecting()

bool
wxGridEvent::ControlDown()

bool
wxGridEvent::AltDown()

bool
wxGridEvent::MetaDown()

bool
wxGridEvent::ShiftDown()

MODULE=Wx PACKAGE=Wx::GridSizeEvent

wxGridSizeEvent*
wxGridSizeEvent::new( id, type, obj, rowOrCol = -1, x = -1, y = -1, control = TRUE, shift = TRUE, alt = TRUE, meta = TRUE )
    int id
    wxEventType type
    wxObject* obj
    int rowOrCol
    int x
    int y
    bool control
    bool shift
    bool alt
    bool meta

int
wxGridSizeEvent::GetRowOrCol()

wxPoint*
wxGridSizeEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

bool
wxGridSizeEvent::ControlDown()

bool
wxGridSizeEvent::AltDown()

bool
wxGridSizeEvent::MetaDown()

bool
wxGridSizeEvent::ShiftDown()

MODULE=Wx PACKAGE=Wx::GridRangeSelectEvent

wxGridRangeSelectEvent*
wxGridRangeSelectEvent::new( id, type, obj, topLeft, bottomRight, sel = TRUE, control = FALSE, shift = FALSE, alt = FALSE, meta = FALSE )
    int id
    wxEventType type
    wxObject* obj
    wxGridCellCoords* topLeft
    wxGridCellCoords* bottomRight
    bool sel
    bool control
    bool shift
    bool alt
    bool meta
  CODE:
    RETVAL = new wxGridRangeSelectEvent( id, type, obj, *topLeft,
        *bottomRight, sel, control, shift, alt, meta );
  OUTPUT:
    RETVAL

wxGridCellCoords*
wxGridRangeSelectEvent::GetTopLeftCoords()
  CODE:
    RETVAL = new wxGridCellCoords( THIS->GetTopLeftCoords() );
  OUTPUT:
    RETVAL

wxGridCellCoords*
wxGridRangeSelectEvent::GetBottomRightCoords()
  CODE:
    RETVAL = new wxGridCellCoords( THIS->GetBottomRightCoords() );
  OUTPUT:
    RETVAL

int
wxGridRangeSelectEvent::GetTopRow()

int
wxGridRangeSelectEvent::GetBottomRow()

int
wxGridRangeSelectEvent::GetLeftCol()

int
wxGridRangeSelectEvent::GetRightCol()

bool
wxGridRangeSelectEvent::Selecting()

bool
wxGridRangeSelectEvent::ControlDown()

bool
wxGridRangeSelectEvent::MetaDown()

bool
wxGridRangeSelectEvent::AltDown()

bool
wxGridRangeSelectEvent::ShiftDown()

MODULE=Wx PACKAGE=Wx::GridEditorCreatedEvent

wxGridEditorCreatedEvent*
wxGridEditorCreatedEvent::new( id, type, obj, row, col, ctrl )
    int id
    wxEventType type
    wxObject* obj
    int row
    int col
    wxControl* ctrl

int
wxGridEditorCreatedEvent::GetRow()

int
wxGridEditorCreatedEvent::GetCol()

wxControl*
wxGridEditorCreatedEvent::GetControl()

void
wxGridEditorCreatedEvent::SetRow( row )
    int row

void
wxGridEditorCreatedEvent::SetCol( col )
    int col

void
wxGridEditorCreatedEvent::SetControl( control )
    wxControl* control
