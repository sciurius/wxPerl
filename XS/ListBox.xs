#############################################################################
## Name:        ListBox.xs
## Purpose:     XS for Wx::ListBox
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: ListBox.xs,v 1.7 2003/05/26 20:33:05 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ListBox

#include <wx/listbox.h>

wxListBox*
wxListBox::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
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
wxListBox::Selected( n )
    int n

void
wxListBox::SetString( n, string )
    int n
    wxString string

void
wxListBox::SetSelection( n, select = TRUE )
    int n
    bool select

void
wxListBox::SetStringSelection( string, select = TRUE )
    wxString string
    bool select
