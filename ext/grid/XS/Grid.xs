############################################################################
## Name:        ext/grid/XS/Grid.xs
## Purpose:     XS for Wx::Grid
## Author:      Mattia Barbon
## Modified by:
## Created:     04/12/2001
## RCS-ID:      $Id: Grid.xs,v 1.24 2005/04/13 20:12:49 mbarbon Exp $
## Copyright:   (c) 2001-2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/grid.h>

MODULE=Wx PACKAGE=Wx::GridCellCoords

wxGridCellCoords*
wxGridCellCoords::new( r, c )
    int r
    int c

## XXX threads
void
wxGridCellCoords::DESTROY()

int
wxGridCellCoords::GetRow()

int
wxGridCellCoords::GetCol()

void
wxGridCellCoords::SetRow( r )
    int r

void
wxGridCellCoords::SetCol( c )
    int c

void
wxGridCellCoords::Set( r, c )
    int r
    int c

MODULE=Wx PACKAGE=Wx::Grid

wxGrid*
wxGrid::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxWANTS_CHARS, name = wxPanelNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxGrid( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxGrid::AppendCols( numCols = 1, updateLabels = true )
    int numCols
    bool updateLabels

bool
wxGrid::AppendRows( numRows = 1, updateLabels = true )
    int numRows
    bool updateLabels

void
wxGrid::AutoSize()

void
wxGrid::AutoSizeColumn( col, setAsMin = true )
    int col
    bool setAsMin

void
wxGrid::AutoSizeColumns( setAsMin = true )
    bool setAsMin

void
wxGrid::AutoSizeRow( row, setAsMin = true )
    int row
    bool setAsMin

void
wxGrid::AutoSizeRows( setAsMin = true )
    bool setAsMin

void
wxGrid::BeginBatch()

wxRect*
wxGrid::BlockToDeviceRect( topLeft, bottomRight )
    wxGridCellCoords* topLeft
    wxGridCellCoords* bottomRight
  CODE:
    RETVAL = new wxRect( THIS->BlockToDeviceRect( *topLeft, *bottomRight ) );
  OUTPUT:
    RETVAL

bool
wxGrid::CanDragColSize()

bool
wxGrid::CanDragRowSize()

bool
wxGrid::CanDragGridSize()

bool
wxGrid::CanEnableCellControl()

wxRect*
wxGrid::CellToRectXY( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxRect( THIS->CellToRect( row, col ) );
  OUTPUT:
    RETVAL

wxRect*
wxGrid::CellToRectCo( coords )
    wxGridCellCoords* coords
  CODE:
    RETVAL = new wxRect( THIS->CellToRect( *coords ) );
  OUTPUT:
    RETVAL

void
wxGrid::ClearGrid()

void
wxGrid::ClearSelection()

bool
wxGrid::CreateGrid( numRows, numCols, selMode = wxGrid::wxGridSelectCells )
    int numRows
    int numCols
    wxGridSelectionModes selMode

bool
wxGrid::DeleteCols( pos = 0, numCols = 1, updateLabels = true )
    int pos
    int numCols
    bool updateLabels

bool
wxGrid::DeleteRows( pos = 0, numRows = 1, updateLabels = true )
    int pos
    int numRows
    bool updateLabels

void
wxGrid::DisableCellEditControl()

void
wxGrid::DisableDragGridSize()

void
wxGrid::DisableDragRowSize()

void
wxGrid::DisableDragColSize()

void
wxGrid::EnableCellEditControl( enable = true )
    bool enable

void
wxGrid::EnableDragColSize( enable = true )
    bool enable

void
wxGrid::EnableDragGridSize( enable = true )
    bool enable

void
wxGrid::EnableDragRowSize( enable = true )
    bool enable

void
wxGrid::EnableEditing( enable = true )
    bool enable

void
wxGrid::EnableGridLines( enable = true )
    bool enable

void
wxGrid::EndBatch()

void
wxGrid::ForceRefresh()

int
wxGrid::GetBatchCount()

void
wxGrid::GetCellAlignment( row, col )
    int row
    int col
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetCellAlignment( row, col, &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxColour*
wxGrid::GetCellBackgroundColour( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxColour( THIS->GetCellBackgroundColour( row, col ) );
  OUTPUT:
    RETVAL

wxGridCellEditor*
wxGrid::GetCellEditor( row, col )
    int row
    int col

wxGridCellRenderer*
wxGrid::GetCellRenderer( row, col )
    int row
    int col

wxFont*
wxGrid::GetCellFont( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxFont( THIS->GetCellFont( row, col ) );
  OUTPUT:
    RETVAL

wxColour*
wxGrid::GetCellTextColour( row, col )
    int row
    int col
  CODE:
    RETVAL = new wxColour( THIS->GetCellTextColour( row, col ) );
  OUTPUT:
    RETVAL

wxString
wxGrid::GetCellValueXY( row, col )
    int row
    int col
  CODE:
    RETVAL = THIS->GetCellValue( row, col );
  OUTPUT:
    RETVAL

wxString
wxGrid::GetCellValueCo( coord )
    wxGridCellCoords* coord
  CODE:
    RETVAL = THIS->GetCellValue( *coord );
  OUTPUT:
    RETVAL

void
wxGrid::GetColLabelAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetColLabelAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

int
wxGrid::GetColLabelSize()

wxString
wxGrid::GetColLabelValue( col )
    int col

int
wxGrid::GetColSize( col )
    int col

void
wxGrid::GetDefaultCellAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetDefaultCellAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxColour*
wxGrid::GetDefaultCellBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetDefaultCellBackgroundColour() );
  OUTPUT:
    RETVAL

wxFont*
wxGrid::GetDefaultCellFont()
  CODE:
    RETVAL = new wxFont( THIS->GetDefaultCellFont() );
  OUTPUT:
    RETVAL

wxColour*
wxGrid::GetDefaultCellTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetDefaultCellTextColour() );
  OUTPUT:
    RETVAL

int
wxGrid::GetDefaultColLabelSize()

int
wxGrid::GetDefaultColSize()

int
wxGrid::GetColMinimalAcceptableWidth()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxGridCellAttr*
wxGrid::GetOrCreateCellAttr( row, col )
    int row
    int col

#endif

int
wxGrid::GetRowMinimalAcceptableHeight()

wxGridCellEditor*
wxGrid::GetDefaultEditor()

wxGridCellEditor*
wxGrid::GetDefaultEditorForType( typeName )
    wxString typeName

wxGridCellEditor*
wxGrid::GetDefaultEditorForCellCo( coords )
    wxGridCellCoords* coords
  CODE:
    RETVAL = THIS->GetDefaultEditorForCell( *coords );
  OUTPUT:
    RETVAL

wxGridCellEditor*
wxGrid::GetDefaultEditorForCellXY( x, y )
    int x
    int y
  CODE:
    RETVAL = THIS->GetDefaultEditorForCell( x, y );
  OUTPUT:
    RETVAL

wxGridCellRenderer*
wxGrid::GetDefaultRenderer()

wxGridCellRenderer*
wxGrid::GetDefaultRendererForType( typeName )
    wxString typeName

##wxGridCellRenderer*
##wxGrid::GetDefaultRendererForCellCo( coords )
##    wxGridCellCoords* coords
##  CODE:
##    RETVAL = THIS->GetDefaultRendererForCell( *coords );
##  OUTPUT:
##    RETVAL

wxGridCellRenderer*
wxGrid::GetDefaultRendererForCell( x, y )
    int x
    int y
  CODE:
    RETVAL = THIS->GetDefaultRendererForCell( x, y );
  OUTPUT:
    RETVAL

void
wxGrid::GetRowLabelAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetRowLabelAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

int
wxGrid::GetDefaultRowLabelSize()

int
wxGrid::GetDefaultRowSize()

int
wxGrid::GetGridCursorCol()

int
wxGrid::GetGridCursorRow()

wxColour*
wxGrid::GetGridLineColour()
  CODE:
    RETVAL = new wxColour( THIS->GetGridLineColour() );
  OUTPUT:
    RETVAL

wxGridTableBase*
wxGrid::GetTable()

bool
wxGrid::GridLinesEnabled()

wxColour*
wxGrid::GetLabelBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetLabelBackgroundColour() );
  OUTPUT:
    RETVAL

wxFont*
wxGrid::GetLabelFont()
  CODE:
    RETVAL = new wxFont( THIS->GetLabelFont() );
  OUTPUT:
    RETVAL

wxColour*
wxGrid::GetLabelTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetLabelTextColour() );
  OUTPUT:
    RETVAL

int
wxGrid::GetNumberCols()

int
wxGrid::GetNumberRows()

int
wxGrid::GetRowLabelSize()

wxString
wxGrid::GetRowLabelValue( row )
    int row

int
wxGrid::GetRowSize( row )
    int row

void
wxGrid::GetSelectedCells()
  PPCODE:
    PUTBACK;
    wxPli_nonobjarray_push<wxGridCellCoordsArray, wxGridCellCoords>
        ( aTHX_ THIS->GetSelectedCells(), "Wx::GridCellCoords" );
    SPAGAIN;

void
wxGrid::GetSelectionBlockTopLeft()
  PPCODE:
    PUTBACK;
    wxPli_nonobjarray_push<wxGridCellCoordsArray, wxGridCellCoords>
        ( aTHX_ THIS->GetSelectionBlockTopLeft(), "Wx::GridCellCoords" );
    SPAGAIN;

void
wxGrid::GetSelectionBlockBottomRight()
  PPCODE:
    PUTBACK;
    wxPli_nonobjarray_push<wxGridCellCoordsArray, wxGridCellCoords>
        ( aTHX_ THIS->GetSelectionBlockBottomRight(), "Wx::GridCellCoords" );
    SPAGAIN;

void
wxGrid::GetSelectedCols()
  PPCODE:
    PUTBACK;
    wxPli_intarray_push( aTHX_ THIS->GetSelectedCols() );
    SPAGAIN;

void
wxGrid::GetSelectedRows()
  PPCODE:
    PUTBACK;
    wxPli_intarray_push( aTHX_ THIS->GetSelectedRows() );
    SPAGAIN;

wxColour*
wxGrid::GetSelectionBackground()
  CODE:
    RETVAL = new wxColour( THIS->GetSelectionBackground() );
  OUTPUT:
    RETVAL

wxColour*
wxGrid::GetSelectionForeground()
  CODE:
    RETVAL = new wxColour( THIS->GetSelectionForeground() );
  OUTPUT:
    RETVAL

int
wxGrid::GetViewWidth()

void
wxGrid::HideCellEditControl()

bool
wxGrid::InsertCols( pos = 0, numCols = 1, updateLabels = true )
    int pos
    int numCols
    bool updateLabels

bool
wxGrid::InsertRows( pos = 0, numRows = 1, updateLabels = true )
    int pos
    int numRows
    bool updateLabels

bool
wxGrid::IsCellEditControlEnabled()

bool
wxGrid::IsCurrentCellReadOnly()

bool
wxGrid::IsEditable()

bool
wxGrid::IsInSelectionXY( row, col )
    int row
    int col
  CODE:
    RETVAL = THIS->IsInSelection( row, col );
  OUTPUT:
    RETVAL

bool
wxGrid::IsInSelectionCo( coords )
    wxGridCellCoords* coords
  CODE:
    RETVAL = THIS->IsInSelection( *coords );
  OUTPUT:
    RETVAL

bool
wxGrid::IsReadOnly( row, col )
    int row
    int col

bool
wxGrid::IsSelection()

bool
wxGrid::IsVisibleXY( row, col, wholeCellVisible = true )
    int row
    int col
    bool wholeCellVisible
  CODE:
    RETVAL = THIS->IsVisible( row, col, wholeCellVisible );
  OUTPUT:
    RETVAL

bool
wxGrid::IsVisibleCo( coords, wholeCellVisible = true )
    wxGridCellCoords* coords
    bool wholeCellVisible
  CODE:
    RETVAL = THIS->IsVisible( *coords, wholeCellVisible );
  OUTPUT:
    RETVAL

void
wxGrid::MakeCellVisibleXY( row, col )
    int row
    int col
  CODE:
    THIS->MakeCellVisible( row, col );

void
wxGrid::MakeCellVisibleCo( coords )
    wxGridCellCoords* coords
  CODE:
    THIS->MakeCellVisible( *coords );

bool
wxGrid::MoveCursorDown( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorLeft( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorRight( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorUp( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorDownBlock( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorLeftBlock( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorRightBlock( expandSelection )
    bool expandSelection

bool
wxGrid::MoveCursorUpBlock( expandSelection )
    bool expandSelection

bool
wxGrid::MovePageDown()

bool
wxGrid::MovePageUp()

bool
wxGrid::ProcessTableMessage( msg )
    wxGridTableMessage* msg
  C_ARGS: *msg

void
wxGrid::RegisterDataType( typeName, renderer, editor )
    wxString typeName
    wxGridCellRenderer* renderer
    wxGridCellEditor* editor
  CODE:
    renderer->IncRef();
    editor->IncRef();
    THIS->RegisterDataType( typeName, renderer, editor );

void
wxGrid::SaveEditControlValue()

void
wxGrid::SelectAll()

void
wxGrid::SelectBlockXYWH( topRow, leftCol, bottomRow, rightCol, addToSelected = false )
    int topRow
    int leftCol
    int bottomRow
    int rightCol
    bool addToSelected
  CODE:
    THIS->SelectBlock( topRow, leftCol, bottomRow, rightCol, addToSelected );

void
wxGrid::SelectBlockPP( topLeft, bottomRight, addToSelected = false )
    wxGridCellCoords* topLeft
    wxGridCellCoords* bottomRight
    bool addToSelected
  CODE:
    THIS->SelectBlock( *topLeft, *bottomRight, addToSelected );

void
wxGrid::SelectCol( col, addToSelected = false )
    int col
    bool addToSelected

void
wxGrid::SelectRow( row, addToSelected = false )
    int row
    bool addToSelected

void
wxGrid::SetCellAlignment( row, col, horiz, vert )
    int row
    int col
    int horiz
    int vert

void
wxGrid::SetCellBackgroundColour( row, col, colour )
    int row
    int col
    wxColour colour

void
wxGrid::SetCellHighlightColour( colour )
    wxColour* colour
  C_ARGS: *colour

void
wxGrid::SetCellHighlightPenWidth( width )
    int width

void
wxGrid::SetCellHighlightROPenWidth( width )
    int width

void
wxGrid::SetCellEditor( row, col, editor )
    int row
    int col
    wxGridCellEditor* editor
  CODE:
    editor->IncRef();
    THIS->SetCellEditor( row, col, editor );

void
wxGrid::SetCellRenderer( row, col, renderer )
    int row
    int col
    wxGridCellRenderer* renderer
  CODE:
    renderer->IncRef();
    THIS->SetCellRenderer( row, col, renderer );

void
wxGrid::SetCellFont( row, col, font )
    int row
    int col
    wxFont* font
  CODE:
    THIS->SetCellFont( row, col, *font );

void
wxGrid::SetCellTextColour( row, col, colour )
    int row
    int col
    wxColour colour

void
wxGrid::SetCellValueXY( row, col, s )
    int row
    int col
    wxString s
  CODE:
    THIS->SetCellValue( row, col, s );

void
wxGrid::SetCellValueCo( coords, s )
    wxGridCellCoords* coords
    wxString s
  CODE:
    THIS->SetCellValue( *coords, s );

void
wxGrid::SetDefaultCellAlignment( horiz, vert )
    int horiz
    int vert

void
wxGrid::SetDefaultCellBackgroundColour( colour )
    wxColour colour

void
wxGrid::SetDefaultCellFont( font )
    wxFont* font
  CODE:
    THIS->SetDefaultCellFont( *font );

void
wxGrid::SetDefaultCellTextColour( colour )
    wxColour colour

void
wxGrid::SetDefaultColSize( width, resizeExistingCols = false )
    int width
    bool resizeExistingCols

void
wxGrid::SetDefaultEditor( editor )
    wxGridCellEditor* editor
  CODE:
    editor->IncRef();
    THIS->SetDefaultEditor( editor );

void
wxGrid::SetDefaultRenderer( renderer )
    wxGridCellRenderer* renderer
  CODE:
    renderer->IncRef();
    THIS->SetDefaultRenderer( renderer );

void
wxGrid::SetDefaultRowSize( height, resizeExistingCols = false )
    int height
    bool resizeExistingCols

void
wxGrid::SetColAttr( col, attr )
    int col
    wxGridCellAttr* attr
  CODE:
    attr->IncRef();
    THIS->SetColAttr( col, attr );

void
wxGrid::SetColFormatBool( col )
    int col

void
wxGrid::SetColFormatNumber( col )
    int col

void
wxGrid::SetColFormatFloat( col, width = -1, precision = -1 )
    int col
    int width
    int precision

void
wxGrid::SetColFormatCustom( col, typeName )
    int col
    wxString typeName

void
wxGrid::SetColLabelAlignment( horiz, vert )
    int horiz
    int vert

void
wxGrid::SetColLabelSize( height )
    int height

void
wxGrid::SetColLabelValue( col, value )
    int col
    wxString value

void
wxGrid::SetColMinimalAcceptableWidth( int width )

void
wxGrid::SetRowMinimalAcceptableHeight( int width )

void
wxGrid::SetColMinimalWidth( col, width )
    int col
    int width

void
wxGrid::SetColSize( col, height )
    int col
    int height

void
wxGrid::SetGridCursor( row, col )
    int row
    int col

void
wxGrid::SetGridLineColour( colour )
    wxColour colour

void
wxGrid::SetLabelBackgroundColour( colour )
    wxColour colour

void
wxGrid::SetLabelFont( font )
    wxFont* font
  CODE:
    THIS->SetLabelFont( *font );

void
wxGrid::SetLabelTextColour( colour )
    wxColour colour

void
wxGrid::SetMargins( extraWidth, extraHeight )
    int extraWidth
    int extraHeight

void
wxGrid::SetReadOnly( row, col, isReadOnly = true )
    int row
    int col
    bool isReadOnly

void
wxGrid::SetRowAttr( row, attr )
    int row
    wxGridCellAttr* attr
  CODE:
    attr->IncRef();
    THIS->SetRowAttr( row, attr );

void
wxGrid::SetRowLabelAlignment( horiz, vert )
    int horiz
    int vert

void
wxGrid::SetRowLabelSize( width )
    int width

void
wxGrid::SetRowLabelValue( row, value )
    int row
    wxString value

void
wxGrid::SetRowMinimalHeight( row, height )
    int row
    int height

void
wxGrid::SetRowSize( row, height )
    int row
    int height

void
wxGrid::SetSelectionBackground( colour )
    wxColour colour

void
wxGrid::SetSelectionForeground( colour )
    wxColour colour

void
wxGrid::SetSelectionMode( selmode )
    wxGridSelectionModes selmode

void
wxGrid::SetTable( table, selMode = wxGrid::wxGridSelectCells )
    wxGridTableBase* table
    wxGridSelectionModes selMode

void
wxGrid::ShowCellEditControl()

int
wxGrid::XToCol( x )
    int x

int
wxGrid::XToEdgeOfCol( x )
    int x

int
wxGrid::YToRow( y )
    int y

int
wxGrid::YToEdgeOfRow( y )
    int y

wxWindow*
wxGrid::GetGridWindow()

wxWindow*
wxGrid::GetGridRowLabelWindow()

wxWindow*
wxGrid::GetGridColLabelWindow()
