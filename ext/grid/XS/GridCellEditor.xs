#############################################################################
## Name:        ext/grid/XS/GridCellEditor.xs
## Purpose:     XS for Wx::GridCellEditor*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      $Id: GridCellEditor.xs,v 1.7 2004/08/04 20:13:57 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridCellEditor

## XXX threads
void
wxGridCellEditor::DESTROY()
  CODE:
    if( THIS )
        THIS->DecRef();

bool
wxGridCellEditor::IsCreated()

wxControl*
wxGridCellEditor::GetControl()

void
wxGridCellEditor::SetControl( control )
    wxControl* control

void
wxGridCellEditor::SetSize( rect )
    wxRect* rect
  CODE:
    THIS->SetSize( *rect );

void
wxGridCellEditor::Show( show, attr )
    bool show
    wxGridCellAttr* attr

void
wxGridCellEditor::PaintBackground( rectCell, attr )
    wxRect* rectCell
    wxGridCellAttr* attr
  CODE:
    THIS->PaintBackground( *rectCell, attr );

void
wxGridCellEditor::BeginEdit( row, col, grid )
    int row
    int col
    wxGrid* grid

bool
wxGridCellEditor::EndEdit( row, col, grid )
    int row
    int col
    wxGrid* grid

void
wxGridCellEditor::Reset()

bool
wxGridCellEditor::IsAcceptedKey( event )
    wxKeyEvent* event
  CODE:
    RETVAL = THIS->IsAcceptedKey( *event );
  OUTPUT:
    RETVAL

void
wxGridCellEditor::StartingKey( event )
    wxKeyEvent* event
  CODE:
    THIS->StartingKey( *event );

void
wxGridCellEditor::StartingClick()

void
wxGridCellEditor::HandleReturn( event )
    wxKeyEvent* event
  CODE:
    THIS->HandleReturn( *event );

void
wxGridCellEditor::Destroy()

MODULE=Wx PACKAGE=Wx::GridCellTextEditor

wxGridCellTextEditor*
wxGridCellTextEditor::new()

MODULE=Wx PACKAGE=Wx::GridCellNumberEditor

wxGridCellNumberEditor*
wxGridCellNumberEditor::new( min = -1, max = -1 )
    int min
    int max

MODULE=Wx PACKAGE=Wx::GridCellFloatEditor

wxGridCellFloatEditor*
wxGridCellFloatEditor::new( width = -1, precision = -1 )
    int width
    int precision

MODULE=Wx PACKAGE=Wx::GridCellBoolEditor

wxGridCellBoolEditor*
wxGridCellBoolEditor::new()

MODULE=Wx PACKAGE=Wx::GridCellChoiceEditor

wxGridCellChoiceEditor*
wxGridCellChoiceEditor::new( choices, allowOthers = false )
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

MODULE=Wx PACKAGE=Wx::PlGridCellEditor

#include "cpp/editor.h"

SV*
wxPlGridCellEditor::new()
  CODE:
    wxPlGridCellEditor* r = new wxPlGridCellEditor( CLASS );
    RETVAL = r->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT: RETVAL
