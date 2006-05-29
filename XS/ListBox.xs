#############################################################################
## Name:        XS/ListBox.xs
## Purpose:     XS for Wx::ListBox
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id: ListBox.xs,v 1.12 2006/05/29 19:05:40 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ListBox

#include <wx/listbox.h>

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ListBox::new" )

wxListBox*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxListBox();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL


wxListBox*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    SV* choices
    long style
    wxValidator* validator
    wxString name
  PREINIT:
    wxString* chs;
    int n;
  CODE:
    if( choices ) 
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    else
    {
        n = 0;
        chs = 0;
    }
        
    RETVAL = new wxListBox( parent, id, pos, size, n, chs, 
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );

    delete[] chs;
  OUTPUT:
    RETVAL

bool
wxListBox::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    SV* choices
    long style
    wxValidator* validator
    wxString name
  PREINIT:
    wxString* chs;
    int n;
  CODE:
    if( choices ) 
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    else
    {
        n = 0;
        chs = 0;
    }
        
    RETVAL = THIS->Create( parent, id, pos, size, n, chs, 
        style, *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

void
wxListBox::Clear()

void
wxListBox::Deselect( n )
    int n

void
wxListBox::GetSelections()
  PREINIT:
    wxArrayInt selections;
    int i, n;
  PPCODE:
    n = THIS->GetSelections( selections );
    EXTEND( SP, n );
    for( i = 0; i < n; ++i )
    {
        PUSHs( sv_2mortal( newSViv( selections[i] ) ) );
    }

int
wxListBox::HitTest( point )
    wxPoint point

void
wxListBox::InsertItems( items, pos )
    SV* items
    int pos
  PREINIT:
    wxString* its;
    int n;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ items, &its );
    THIS->InsertItems( n, its, pos );

    delete[] its;

bool
wxListBox::IsSelected( n )
    int n

void
wxListBox::SetString( n, string )
    int n
    wxString string

void
wxListBox::SetSelection( n, select = true )
    int n
    bool select

void
wxListBox::SetStringSelection( string, select = true )
    wxString string
    bool select

void
wxListBox::SetFirstItem( n )
    int n

void
wxListBox::SetFirstItemString( str )
    wxString str
  CODE:
    THIS->SetFirstItem( str );

void
wxListBox::Set( choices )
    wxArrayString choices
