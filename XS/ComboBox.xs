#############################################################################
## Name:        XS/ComboBox.xs
## Purpose:     XS for Wx::ComboBox
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2004, 2006-2008, 2010-2011, 2014-2015 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/combobox.h>
#include <wx/textctrl.h>
#include "cpp/overload.h"

MODULE=Wx PACKAGE=Wx::ComboBox

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ComboBox::new" )

wxComboBox*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxComboBox();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL


wxComboBox*
newFull( CLASS, parent, id = wxID_ANY, value = wxEmptyString, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxComboBoxNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    SV* choices
    long style
    wxValidator* validator
    wxString name
  PREINIT:
    wxString* chs = 0;
    int n = 0;
  CODE:
    if( choices != 0 )
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    RETVAL = new wxComboBox( parent, id, value, pos, size, n, chs, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );

    delete[] chs;
  OUTPUT:
    RETVAL

bool
wxComboBox::Create( parent, id = wxID_ANY, value = wxEmptyString, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxComboBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    SV* choices
    long style
    wxValidator* validator
    wxString name
  PREINIT:
    wxString* chs = 0;
    int n = 0;
  CODE:
    if( choices != 0 )
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    RETVAL = THIS->Create( parent, id, value, pos, size, n, chs, 
        style, *validator, name );

    delete[] chs;
  OUTPUT: RETVAL

#if defined( __WXMAC__ ) || ( defined( __WXGTK__ ) && WXPERL_W_VERSION_LT( 2, 9, 0 ) )

#define WXPERL_IN_COMBOBOX

INCLUDE_COMMAND: $^X -pe "s/ItemContainerImmutable/ComboBox/g" XS/ItemContainerImmutable.xs

# the second regex is an horrible hack to solve ambiguity;
# see also OwnerDrawnComboBox.xsp
INCLUDE_COMMAND: $^X -pe "s/ItemContainer/ComboBox/g;s/->(?=[SG]etClientObject)/->wxItemContainer::/" XS/ItemContainer.xs

#undef WXPERL_IN_COMBOBOX

int
wxComboBox::GetCurrentSelection()

#endif

void
wxComboBox::SetEditable( bool editable )


#if WXPERL_W_VERSION_GE( 2, 9, 3 )

bool 
wxComboBox::IsListEmpty()

bool 
wxComboBox::IsTextEmpty()

#endif

void
wxComboBox::Copy()

void
wxComboBox::Cut()

bool
wxComboBox::CanCopy()

bool
wxComboBox::CanCut()

bool
wxComboBox::CanPaste()

void
wxComboBox::Undo()

void
wxComboBox::Redo()

bool
wxComboBox::CanUndo()

bool
wxComboBox::CanRedo()

long
wxComboBox::GetInsertionPoint()

wxTextPos
wxComboBox::GetLastPosition()

wxString
wxComboBox::GetValue()

void
wxComboBox::Paste()

#if WXPERL_W_VERSION_GE( 2, 9, 1 )

void
wxComboBox::Popup()

void
wxComboBox::Dismiss()

#endif

void
wxComboBox::Replace( from, to, text )
    long from
    long to
    wxString text

void
wxComboBox::Remove( from ,to )
    long from
    long to

void
wxComboBox::SetInsertionPoint( pos )
    long pos

void
wxComboBox::SetInsertionPointEnd()

void
wxComboBox::GetSelection()
  PREINIT:
    long from;
    long to;
    int  selindex;
  PPCODE:
    if( GIMME_V == G_ARRAY ) {
        THIS->GetSelection( &from, &to );
        EXTEND( SP, 2 );
        PUSHs( sv_2mortal( newSViv( from ) ) );
        PUSHs( sv_2mortal( newSViv( to ) ) );
    } else {
	selindex = THIS->GetSelection();
	EXTEND( SP, 1 );
        PUSHs( sv_2mortal( newSViv( selindex ) ) );
    }


void
wxComboBox::SetSelection( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, SetMark )
        MATCH_REDISP( wxPliOvl_n, SetSelectionN )
    END_OVERLOAD( Wx::ComboBox::SetSelection )

void
wxComboBox::SetSelectionN( n )
    int n
  CODE:
    THIS->SetSelection( n );

void
wxComboBox::SetMark( from, to )
    long from
    long to
  CODE:
    THIS->SetSelection( from, to );

void
wxComboBox::SetValue( string )
    wxString string

#if WXPERL_W_VERSION_GE( 2, 9, 2 )

void
wxComboBox::RemoveSelection()

void
wxComboBox::ChangeValue( string )
    wxString string

#endif

#if WXPERL_W_VERSION_GE( 2, 9, 3 )

bool
wxComboBox::AutoComplete( choices )
	wxArrayString choices
	
#bool
#wxComboBox::AutoComplete( completer )	
#    wxTextCompleter completer

bool
wxComboBox::AutoCompleteFileNames()

bool
wxComboBox::AutoCompleteDirectories()

#endif
