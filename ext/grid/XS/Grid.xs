#############################################################################
## Name:        Grid.xs
## Purpose:     XS for Wx::Grid
## Author:      Mattia Barbon
## Modified by:
## Created:      4/12/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/grid.h>

MODULE=Wx PACKAGE=Wx::GridCellCoords

Wx_GridCellCoords*
Wx_GridCellCoords::new( r, c )
    int r
    int c

void
Wx_GridCellCoords::DESTROY()

int
Wx_GridCellCoords::GetRow()

int
Wx_GridCellCoords::GetCol()

void
Wx_GridCellCoords::SetRow( r )
    int r

void
Wx_GridCellCoords::SetCol( c )
    int c

void
Wx_GridCellCoords::Set( r, c )
    int r
    int c

MODULE=Wx PACKAGE=Wx::Grid

Wx_Grid*
Wx_Grid::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxWANTS_CHARS, name = wxPanelNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxGrid( parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

bool
Wx_Grid::AppendCols( numCols = 1, updateLabels = TRUE )
    int numCols
    bool updateLabels

bool
Wx_Grid::AppendRows( numRows = 1, updateLabels = TRUE )
    int numRows
    bool updateLabels

void
Wx_Grid::AutoSize()

void
Wx_Grid::AutoSizeColumn( col, setAsMin = TRUE )
    int col
    bool setAsMin

void
Wx_Grid::AutoSizeColumns( setAsMin = TRUE )
    bool setAsMin

void
Wx_Grid::AutoSizeRow( row, setAsMin = TRUE )
    int row
    bool setAsMin

void
Wx_Grid::AutoSizeRows( setAsMin = TRUE )
    bool setAsMin

void
Wx_Grid::BeginBatch()

Wx_Rect*
Wx_Grid::BlockToDeviceRect( topLeft, bottomRight )
    Wx_GridCellCoords* topLeft
    Wx_GridCellCoords* bottomRight
  CODE:
    RETVAL = new wxRect( THIS->BlockToDeviceRect( *topLeft, *bottomRight ) );
  OUTPUT:
    RETVAL

bool
Wx_Grid::CanDragColSize()

bool
Wx_Grid::CanDragRowSize()

bool
Wx_Grid::CanDragGridSize()

bool
Wx_Grid::CanEnableCellControl()

Wx_Rect*
Wx_Grid::CellToRectXY( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxRect( THIS->CellToRect( row, col ) );
  OUTPUT:
    RETVAL

Wx_Rect*
Wx_Grid::CellToRectCo( coords )
    Wx_GridCellCoords* coords
  CODE:
    RETVAL = new wxRect( THIS->CellToRect( *coords ) );
  OUTPUT:
    RETVAL

void
Wx_Grid::ClearGrid()

void
Wx_Grid::ClearSelection()

bool
Wx_Grid::CreateGrid( numRows, numCols, selMode = wxGrid::wxGridSelectCells )
    int numRows
    int numCols
    wxGridSelectionModes selMode

bool
Wx_Grid::DeleteCols( pos = 0, numCols = 1, updateLabels = TRUE )
    int pos
    int numCols
    bool updateLabels

bool
Wx_Grid::DeleteRows( pos = 0, numRows = 1, updateLabels = TRUE )
    int pos
    int numRows
    bool updateLabels

void
Wx_Grid::DisableCellEditControl()

void
Wx_Grid::DisableDragGridSize()

void
Wx_Grid::DisableDragRowSize()

void
Wx_Grid::EnableCellEditControl( enable = TRUE )
    bool enable

void
Wx_Grid::EnableDragColSize( enable = TRUE )
    bool enable

void
Wx_Grid::EnableDragGridSize( enable = TRUE )
    bool enable

void
Wx_Grid::EnableDragRowSize( enable = TRUE )
    bool enable

void
Wx_Grid::EnableEditing( enable = TRUE )
    bool enable

void
Wx_Grid::EnableGridLines( enable = TRUE )
    bool enable

void
Wx_Grid::EndBatch()

#if WXPERL_W_VERSION_GE( 2, 3, 1 )

void
Wx_Grid::ForceRefresh()

#endif

int
Wx_Grid::GetBatchCount()

void
Wx_Grid::GetCellAlignment( row, col )
    int row
    int col
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetCellAlignment( row, col, &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

Wx_Colour*
Wx_Grid::GetCellBackgroundColour( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxColour( THIS->GetCellBackgroundColour( row, col ) );
  OUTPUT:
    RETVAL

Wx_GridCellEditor*
Wx_Grid::GetCellEditor( row, col )
    int row
    int col

Wx_GridCellRenderer*
Wx_Grid::GetCellRenderer( row, col )
    int row
    int col

Wx_Font*
Wx_Grid::GetCellFont( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxFont( THIS->GetCellFont( row, col ) );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_Grid::GetCellTextColour( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxColour( THIS->GetCellTextColour( row, col ) );
  OUTPUT:
    RETVAL

wxString
Wx_Grid::GetCellValueXY( row, col )
    int row
    int col
  CODE:
    RETVAL = THIS->GetCellValue( row, col );
  OUTPUT:
    RETVAL

wxString
Wx_Grid::GetCellValueCo( coord )
    Wx_GridCellCoords* coord
  CODE:
    RETVAL = THIS->GetCellValue( *coord );
  OUTPUT:
    RETVAL

void
Wx_Grid::GetColLabelAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetColLabelAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

int
Wx_Grid::GetColLabelSize()

wxString
Wx_Grid::GetColLabelValue( col )
    int col

int
Wx_Grid::GetColSize( col )
    int col

void
Wx_Grid::GetDefaultCellAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetDefaultCellAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

Wx_Colour*
Wx_Grid::GetDefaultCellBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetDefaultCellBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_Grid::GetDefaultCellFont()
  CODE:
    RETVAL = new wxFont( THIS->GetDefaultCellFont() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_Grid::GetDefaultCellTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetDefaultCellTextColour() );
  OUTPUT:
    RETVAL

int
Wx_Grid::GetDefaultColLabelSize()

int
Wx_Grid::GetDefaultColSize()

Wx_GridCellEditor*
Wx_Grid::GetDefaultEditor()

Wx_GridCellEditor*
Wx_Grid::GetDefaultEditorForType( typeName )
    wxString typeName

Wx_GridCellEditor*
Wx_Grid::GetDefaultEditorForCellCo( coords )
    Wx_GridCellCoords* coords
  CODE:
    RETVAL = THIS->GetDefaultEditorForCell( *coords );
  OUTPUT:
    RETVAL

Wx_GridCellEditor*
Wx_Grid::GetDefaultEditorForCellXY( x, y )
    int x
    int y
  CODE:
    RETVAL = THIS->GetDefaultEditorForCell( x, y );
  OUTPUT:
    RETVAL

Wx_GridCellRenderer*
Wx_Grid::GetDefaultRenderer()

Wx_GridCellRenderer*
Wx_Grid::GetDefaultRendererForType( typeName )
    wxString typeName

##Wx_GridCellRenderer*
##Wx_Grid::GetDefaultRendererForCellCo( coords )
##    Wx_GridCellCoords* coords
##  CODE:
##    RETVAL = THIS->GetDefaultRendererForCell( *coords );
##  OUTPUT:
##    RETVAL

Wx_GridCellRenderer*
Wx_Grid::GetDefaultRendererForCell( x, y )
    int x
    int y
  CODE:
    RETVAL = THIS->GetDefaultRendererForCell( x, y );
  OUTPUT:
    RETVAL

void
Wx_Grid::GetRowLabelAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetRowLabelAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

int
Wx_Grid::GetDefaultRowLabelSize()

int
Wx_Grid::GetDefaultRowSize()

int
Wx_Grid::GetGridCursorCol()

int
Wx_Grid::GetGridCursorRow()

Wx_Colour*
Wx_Grid::GetGridLineColour()
  CODE:
    RETVAL = new wxColour( THIS->GetGridLineColour() );
  OUTPUT:
    RETVAL

bool
Wx_Grid::GridLinesEnabled()

Wx_Colour*
Wx_Grid::GetLabelBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetLabelBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_Grid::GetLabelFont()
  CODE:
    RETVAL = new wxFont( THIS->GetLabelFont() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_Grid::GetLabelTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetLabelTextColour() );
  OUTPUT:
    RETVAL

int
Wx_Grid::GetNumberCols()

int
Wx_Grid::GetNumberRows()

int
Wx_Grid::GetRowLabelSize()

wxString
Wx_Grid::GetRowLabelValue( row )
    int row

int
Wx_Grid::GetRowSize( row )
    int row

Wx_Colour*
Wx_Grid::GetSelectionBackground()
  CODE:
    RETVAL = new wxColour( THIS->GetSelectionBackground() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_Grid::GetSelectionForeground()
  CODE:
    RETVAL = new wxColour( THIS->GetSelectionForeground() );
  OUTPUT:
    RETVAL

int
Wx_Grid::GetViewWidth()

void
Wx_Grid::HideCellEditControl()

bool
Wx_Grid::InsertCols( pos = 0, numCols = 1, updateLabels = TRUE )
    int pos
    int numCols
    bool updateLabels

bool
Wx_Grid::InsertRows( pos = 0, numRows = 1, updateLabels = TRUE )
    int pos
    int numRows
    bool updateLabels

bool
Wx_Grid::IsCellEditControlEnabled()

bool
Wx_Grid::IsCurrentCellReadOnly()

bool
Wx_Grid::IsEditable()

bool
Wx_Grid::IsInSelectionXY( row, col )
    int row
    int col
  CODE:
    RETVAL = THIS->IsInSelection( row, col );
  OUTPUT:
    RETVAL

bool
Wx_Grid::IsInSelectionCo( coords )
    Wx_GridCellCoords* coords
  CODE:
    RETVAL = THIS->IsInSelection( *coords );
  OUTPUT:
    RETVAL

bool
Wx_Grid::IsReadOnly( row, col )
    int row
    int col

bool
Wx_Grid::IsSelection()

bool
Wx_Grid::IsVisibleXY( row, col, wholeCellVisible = TRUE )
    int row
    int col
    bool wholeCellVisible
  CODE:
    RETVAL = THIS->IsVisible( row, col, wholeCellVisible );
  OUTPUT:
    RETVAL

bool
Wx_Grid::IsVisibleCo( coords, wholeCellVisible = TRUE )
    Wx_GridCellCoords* coords
    bool wholeCellVisible
  CODE:
    RETVAL = THIS->IsVisible( *coords, wholeCellVisible );
  OUTPUT:
    RETVAL

void
Wx_Grid::MakeCellVisibleXY( row, col )
    int row
    int col
  CODE:
    THIS->MakeCellVisible( row, col );

void
Wx_Grid::MakeCellVisibleCo( coords )
    Wx_GridCellCoords* coords
  CODE:
    THIS->MakeCellVisible( *coords );

bool
Wx_Grid::MoveCursorDown( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorLeft( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorRight( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorUp( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorDownBlock( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorLeftBlock( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorRightBlock( expandSelection )
    bool expandSelection

bool
Wx_Grid::MoveCursorUpBlock( expandSelection )
    bool expandSelection

bool
Wx_Grid::MovePageDown()

bool
Wx_Grid::MovePageUp()

void
Wx_Grid::RegisterDataType( typeName, renderer, editor )
    wxString typeName
    Wx_GridCellRenderer* renderer
    Wx_GridCellEditor* editor

void
Wx_Grid::SaveEditControlValue()

void
Wx_Grid::SelectAll()

void
Wx_Grid::SelectBlockXYWH( topRow, leftCol, bottomRow, rightCol, addToSelected = FALSE )
    int topRow
    int leftCol
    int bottomRow
    int rightCol
    bool addToSelected
  CODE:
    THIS->SelectBlock( topRow, leftCol, bottomRow, rightCol, addToSelected );

void
Wx_Grid::SelectBlockPP( topLeft, bottomRight, addToSelected = FALSE )
    Wx_GridCellCoords* topLeft
    Wx_GridCellCoords* bottomRight
    bool addToSelected
  CODE:
    THIS->SelectBlock( *topLeft, *bottomRight, addToSelected );

void
Wx_Grid::SelectCol( col, addToSelected = FALSE )
    int col
    bool addToSelected

void
Wx_Grid::SelectRow( row, addToSelected = FALSE )
    int row
    bool addToSelected

void
Wx_Grid::SetCellAlignment( row, col, horiz, vert )
    int row
    int col
    int horiz
    int vert

void
Wx_Grid::SetCellBackgroundColour( row, col, colour )
    int row
    int col
    Wx_Colour colour

void
Wx_Grid::SetCellEditor( row, col, editor )
    int row
    int col
    Wx_GridCellEditor* editor
  CODE:
    editor->IncRef();
    THIS->SetCellEditor( row, col, editor );

void
Wx_Grid::SetCellRenderer( row, col, renderer )
    int row
    int col
    Wx_GridCellRenderer* renderer
  CODE:
    renderer->IncRef();
    THIS->SetCellRenderer( row, col, renderer );

void
Wx_Grid::SetCellFont( row, col, font )
    int row
    int col
    Wx_Font* font
  CODE:
    THIS->SetCellFont( row, col, *font );

void
Wx_Grid::SetCellTextColour( row, col, colour )
    int row
    int col
    Wx_Colour colour

void
Wx_Grid::SetCellValueXY( row, col, s )
    int row
    int col
    wxString s
  CODE:
    THIS->SetCellValue( row, col, s );

void
Wx_Grid::SetCellValueCo( coords, s )
    Wx_GridCellCoords* coords
    wxString s
  CODE:
    THIS->SetCellValue( *coords, s );

void
Wx_Grid::SetDefaultCellAlignment( horiz, vert )
    int horiz
    int vert

void
Wx_Grid::SetDefaultCellBackgroundColour( colour )
    Wx_Colour colour

void
Wx_Grid::SetDefaultCellFont( font )
    Wx_Font* font
  CODE:
    THIS->SetDefaultCellFont( *font );

void
Wx_Grid::SetDefaultCellTextColour( colour )
    Wx_Colour colour

void
Wx_Grid::SetDefaultColSize( width, resizeExistingCols = FALSE )
    int width
    bool resizeExistingCols

void
Wx_Grid::SetDefaultEditor( editor )
    Wx_GridCellEditor* editor
  CODE:
    editor->IncRef();
    THIS->SetDefaultEditor( editor );

void
Wx_Grid::SetDefaultRenderer( renderer )
    Wx_GridCellRenderer* renderer
  CODE:
    renderer->IncRef();
    THIS->SetDefaultRenderer( renderer );

void
Wx_Grid::SetDefaultRowSize( height, resizeExistingCols = FALSE )
    int height
    bool resizeExistingCols

void
Wx_Grid::SetColAttr( col, attr )
    int col
    Wx_GridCellAttr* attr
  CODE:
    attr->IncRef();
    THIS->SetColAttr( col, attr );

void
Wx_Grid::SetColFormatBool( col )
    int col

void
Wx_Grid::SetColFormatNumber( col )
    int col

void
Wx_Grid::SetColFormatFloat( col, width = -1, precision = -1 )
    int col
    int width
    int precision

void
Wx_Grid::SetColFormatCustom( col, typeName )
    int col
    wxString typeName

void
Wx_Grid::SetColLabelAlignment( horiz, vert )
    int horiz
    int vert

void
Wx_Grid::SetColLabelSize( height )
    int height

void
Wx_Grid::SetColLabelValue( col, value )
    int col
    wxString value

void
Wx_Grid::SetColMinimalWidth( col, width )
    int col
    int width

void
Wx_Grid::SetColSize( col, height )
    int col
    int height

void
Wx_Grid::SetGridCursor( row, col )
    int row
    int col

void
Wx_Grid::SetGridLineColour( colour )
    Wx_Colour colour

void
Wx_Grid::SetLabelBackgroundColour( colour )
    Wx_Colour colour

void
Wx_Grid::SetLabelFont( font )
    Wx_Font* font
  CODE:
    THIS->SetLabelFont( *font );

void
Wx_Grid::SetLabelTextColour( colour )
    Wx_Colour colour

void
Wx_Grid::SetMargins( extraWidth, extraHeight )
    int extraWidth
    int extraHeight

void
Wx_Grid::SetReadOnly( row, col, isReadOnly = TRUE )
    int row
    int col
    bool isReadOnly

void
Wx_Grid::SetRowAttr( row, attr )
    int row
    Wx_GridCellAttr* attr
  CODE:
    attr->IncRef();
    THIS->SetRowAttr( row, attr );

void
Wx_Grid::SetRowLabelAlignment( horiz, vert )
    int horiz
    int vert

void
Wx_Grid::SetRowLabelSize( width )
    int width

void
Wx_Grid::SetRowLabelValue( row, value )
    int row
    wxString value

void
Wx_Grid::SetRowMinimalHeight( row, height )
    int row
    int height

void
Wx_Grid::SetRowSize( row, height )
    int row
    int height

void
Wx_Grid::SetSelectionBackground( colour )
    Wx_Colour colour

void
Wx_Grid::SetSelectionForeground( colour )
    Wx_Colour colour

void
Wx_Grid::SetSelectionMode( selmode )
    wxGridSelectionModes selmode

void
Wx_Grid::ShowCellEditControl()

int
Wx_Grid::XToCol( x )
    int x

int
Wx_Grid::XToEdgeOfCol( x )
    int x

int
Wx_Grid::YToRow( y )
    int y

int
Wx_Grid::YToEdgeOfRow( y )
    int y
