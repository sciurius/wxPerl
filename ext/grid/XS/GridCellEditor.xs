#############################################################################
## Name:        ext/grid/XS/GridCellEditor.xs
## Purpose:     XS for Wx::GridCellEditor*
## Author:      Mattia Barbon
## Modified by:
## Created:     13/12/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2007, 2009 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridCellEditor

static void
wxGridCellEditor::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxGridCellEditor::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ),
                                SvRV( ST(0) ), ST(0) );
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

#if WXPERL_W_VERSION_GE( 2, 9, 0 )

bool
wxGridCellEditor::EndEdit( oldval, newval )
    wxString oldval
    wxString newval
  C_ARGS: oldval, &newval

void
wxGridCellEditor::ApplyEdit( row, col, grid )
    int row
    int col
    wxGrid* grid

#else

bool
wxGridCellEditor::EndEdit( row, col, grid )
    int row
    int col
    wxGrid* grid

#endif

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

void
wxGridCellTextEditor::SetParameters( params )
    wxString params

MODULE=Wx PACKAGE=Wx::GridCellAutoWrapStringEditor

wxGridCellAutoWrapStringEditor*
wxGridCellAutoWrapStringEditor::new()

MODULE=Wx PACKAGE=Wx::GridCellNumberEditor

wxGridCellNumberEditor*
wxGridCellNumberEditor::new( min = -1, max = -1 )
    int min
    int max

void
wxGridCellNumberEditor::SetParameters( params )
    wxString params

MODULE=Wx PACKAGE=Wx::GridCellFloatEditor

wxGridCellFloatEditor*
wxGridCellFloatEditor::new( width = -1, precision = -1 )
    int width
    int precision

void
wxGridCellChoiceEditor::SetParameters( params )
    wxString params

MODULE=Wx PACKAGE=Wx::GridCellBoolEditor

wxGridCellBoolEditor*
wxGridCellBoolEditor::new()

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

bool
IsTrueValue( value )
    wxString value
  CODE:
    RETVAL = wxGridCellBoolEditor::IsTrueValue( value );
  OUTPUT: RETVAL

void
UseStringValues( trueValue = wxT("1"), falseValue = wxT("") )
    wxString trueValue
    wxString falseValue
  CODE:
    wxGridCellBoolEditor::UseStringValues( trueValue, falseValue );

#endif

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

void
wxGridCellChoiceEditor::SetParameters( params )
    wxString params

MODULE=Wx PACKAGE=Wx::GridCellEnumEditor

wxGridCellEnumEditor*
wxGridCellEnumEditor::new( choices = wxEmptyString )
    wxString choices
    
MODULE=Wx PACKAGE=Wx::PlGridCellEditor

#include "cpp/editor.h"

SV*
wxPlGridCellEditor::new()
  CODE:
    wxPlGridCellEditor* r = new wxPlGridCellEditor( CLASS );
    r->SetClientObject( new wxPliUserDataCD( r->m_callback.GetSelf() ) );
    RETVAL = r->m_callback.GetSelf();
    SvREFCNT_inc( RETVAL );
  OUTPUT: RETVAL
