#############################################################################
## Name:        GridEvent.xs
## Purpose:     XS for Wx::Grid*Event
## Author:      Mattia Barbon
## Modified by:
## Created:      8/12/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridEvent

Wx_GridEvent*
Wx_GridEvent::new( id, type, obj, row = -1, col = -1, x = -1, y = -1, sel = TRUE, control = TRUE, shift = TRUE, alt = TRUE, meta = TRUE )
    int id
    wxEventType type
    Wx_Object* obj
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
Wx_GridEvent::GetRow()

int
Wx_GridEvent::GetCol()

Wx_Point*
Wx_GridEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

bool
Wx_GridEvent::Selecting()

bool
Wx_GridEvent::ControlDown()

bool
Wx_GridEvent::AltDown()

bool
Wx_GridEvent::MetaDown()

bool
Wx_GridEvent::ShiftDown()

MODULE=Wx PACKAGE=Wx::GridSizeEvent

Wx_GridSizeEvent*
Wx_GridSizeEvent::new( id, type, obj, rowOrCol = -1, x = -1, y = -1, control = TRUE, shift = TRUE, alt = TRUE, meta = TRUE )
    int id
    wxEventType type
    Wx_Object* obj
    int rowOrCol
    int x
    int y
    bool control
    bool shift
    bool alt
    bool meta

int
Wx_GridSizeEvent::GetRowOrCol()

Wx_Point*
Wx_GridSizeEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

bool
Wx_GridSizeEvent::ControlDown()

bool
Wx_GridSizeEvent::AltDown()

bool
Wx_GridSizeEvent::MetaDown()

bool
Wx_GridSizeEvent::ShiftDown()

MODULE=Wx PACKAGE=Wx::GridRangeSelectEvent

Wx_GridRangeSelectEvent*
Wx_GridRangeSelectEvent::new( id, type, obj, topLeft, bottomRight, sel = TRUE, control = FALSE, shift = FALSE, alt = FALSE, meta = FALSE )
    int id
    wxEventType type
    Wx_Object* obj
    Wx_GridCellCoords* topLeft
    Wx_GridCellCoords* bottomRight
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

Wx_GridCellCoords*
Wx_GridRangeSelectEvent::GetTopLeftCoords()
  CODE:
    RETVAL = new wxGridCellCoords( THIS->GetTopLeftCoords() );
  OUTPUT:
    RETVAL

Wx_GridCellCoords*
Wx_GridRangeSelectEvent::GetBottomRightCoords()
  CODE:
    RETVAL = new wxGridCellCoords( THIS->GetBottomRightCoords() );
  OUTPUT:
    RETVAL

int
Wx_GridRangeSelectEvent::GetTopRow()

int
Wx_GridRangeSelectEvent::GetBottomRow()

int
Wx_GridRangeSelectEvent::GetLeftCol()

int
Wx_GridRangeSelectEvent::GetRightCol()

bool
Wx_GridRangeSelectEvent::Selecting()

bool
Wx_GridRangeSelectEvent::ControlDown()

bool
Wx_GridRangeSelectEvent::MetaDown()

bool
Wx_GridRangeSelectEvent::AltDown()

bool
Wx_GridRangeSelectEvent::ShiftDown()

MODULE=Wx PACKAGE=Wx::GridEditorCreatedEvent

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

Wx_GridEditorCreatedEvent*
Wx_GridEditorCreatedEvent::new( id, type, obj, row, col, ctrl )
    int id
    wxEventType type
    Wx_Object* obj
    int row
    int col
    Wx_Control* ctrl

int
Wx_GridEditorCreatedEvent::GetRow()

int
Wx_GridEditorCreatedEvent::GetCol()

Wx_Control*
Wx_GridEditorCreatedEvent::GetControl()

void
Wx_GridEditorCreatedEvent::SetRow( row )
    int row

void
Wx_GridEditorCreatedEvent::SetCol( col )
    int col

void
Wx_GridEditorCreatedEvent::SetControl( control )
    Wx_Control* control

#endif
