#############################################################################
## Name:        ListBox.xs
## Purpose:     XS for Wx::ListBox
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::ListBox

Wx_ListBox*
Wx_ListBox::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    SV* choices
    long style
    Wx_Validator* validator
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
        
    RETVAL = new wxPliListBox( CLASS, parent, id, pos, size, n, chs, 
        style, *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

void
Wx_ListBox::Clear()

void
Wx_ListBox::Deselect( n )
    int n

void
Wx_ListBox::GetSelections()
  PREINIT:
    wxArrayInt selections;
    int i, n;
  PPCODE:
    n = THIS->GetSelections( selections );
    EXTEND( SP, n );
    for( i = 0; i < n; ++i )
    {
        PUSHs( sv_2mortal( newSViv( selections[n] ) ) );
    }

void
Wx_ListBox::InsertItems( items, pos )
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
Wx_ListBox::Selected( n )
    int n

void
Wx_ListBox::SetString( n, string )
    int n
    wxString string

void
Wx_ListBox::SetSelection( n, select = TRUE )
    int n
    bool select

void
Wx_ListBox::SetStringSelection( string, select = TRUE )
    wxString string
    bool select
