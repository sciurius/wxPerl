#############################################################################
## Name:        GridCellEditor.xs
## Purpose:     XS for Wx::GridCellEditor*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridCellEditor

## XXX threads
void
Wx_GridCellEditor::DESTROY()
  CODE:
    if( THIS )
        THIS->DecRef();

bool
Wx_GridCellEditor::IsCreated()

Wx_Control*
Wx_GridCellEditor::GetControl()

void
Wx_GridCellEditor::SetControl( control )
    Wx_Control* control

void
Wx_GridCellEditor::SetSize( rect )
    Wx_Rect* rect
  CODE:
    THIS->SetSize( *rect );

void
Wx_GridCellEditor::Show( show, attr )
    bool show
    Wx_GridCellAttr* attr

void
Wx_GridCellEditor::PaintBackground( rectCell, attr )
    Wx_Rect* rectCell
    Wx_GridCellAttr* attr
  CODE:
    THIS->PaintBackground( *rectCell, attr );

void
Wx_GridCellEditor::BeginEdit( row, col, grid )
    int row
    int col
    Wx_Grid* grid

bool
Wx_GridCellEditor::EndEdit( row, col, grid )
    int row
    int col
    Wx_Grid* grid

void
Wx_GridCellEditor::Reset()

bool
Wx_GridCellEditor::IsAcceptedKey( event )
    Wx_KeyEvent* event
  CODE:
    RETVAL = THIS->IsAcceptedKey( *event );
  OUTPUT:
    RETVAL

void
Wx_GridCellEditor::StartingKey( event )
    Wx_KeyEvent* event
  CODE:
    THIS->StartingKey( *event );

void
Wx_GridCellEditor::StartingClick()

void
Wx_GridCellEditor::HandleReturn( event )
    Wx_KeyEvent* event
  CODE:
    THIS->HandleReturn( *event );

void
Wx_GridCellEditor::Destroy()

MODULE=Wx PACKAGE=Wx::GridCellTextEditor

Wx_GridCellTextEditor*
Wx_GridCellTextEditor::new()

MODULE=Wx PACKAGE=Wx::GridCellNumberEditor

Wx_GridCellNumberEditor*
Wx_GridCellNumberEditor::new( min = -1, max = -1 )
    int min
    int max

MODULE=Wx PACKAGE=Wx::GridCellFloatEditor

Wx_GridCellFloatEditor*
Wx_GridCellFloatEditor::new( width = -1, precision = -1 )
    int width
    int precision

MODULE=Wx PACKAGE=Wx::GridCellBoolEditor

Wx_GridCellBoolEditor*
Wx_GridCellBoolEditor::new()

MODULE=Wx PACKAGE=Wx::GridCellChoiceEditor

Wx_GridCellChoiceEditor*
Wx_GridCellChoiceEditor::new( choices, allowOthers = FALSE )
    SV* choices
    bool allowOthers
  PREINIT:
    wxString* chs;
    int n;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    RETVAL = new wxGridCellChoiceEditor( n, chs, allowOthers );
    delete[] chs;
  OUTPUT:
    RETVAL
