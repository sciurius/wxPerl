#############################################################################
## Name:        Notebook.xs
## Purpose:     XS for Wx::RadioBox
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: RadioBox.xs,v 1.13 2003/05/05 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::RadioBox

Wx_RadioBox*
Wx_RadioBox::new( parent, id, label, point = wxDefaultPosition, size = wxDefaultSize, choices = 0, majorDimension = 0, style = wxRA_SPECIFY_COLS, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioBoxNameStr )
    Wx_Window* parent
    wxWindowID id
    wxString label
    Wx_Point point
    Wx_Size size
    SV* choices
    int majorDimension
    long style
    Wx_Validator* validator
    wxString name
  PREINIT:
    int n;
    wxString* chs;
  CODE:
    if( choices )
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );
    else {
        n = 0;
        chs = 0;
    }
    RETVAL = new wxPliRadioBox( CLASS, parent, id, label, point, size,
        n, chs, majorDimension, style, *validator, name );
    delete[] chs;
  OUTPUT:
    RETVAL

void
Wx_RadioBox::EnableItem( n, enable )
    int n
    bool enable
  CODE:
    THIS->Enable( n, enable );

int
Wx_RadioBox::FindString( string )
    wxString string

wxString
Wx_RadioBox::GetString( n )
    int n

wxString
Wx_RadioBox::GetItemLabel( n )
    int n
  CODE:
    RETVAL = THIS->GetString( n );
  OUTPUT:
    RETVAL

int
Wx_RadioBox::GetSelection()

wxString
Wx_RadioBox::GetStringSelection()

void
Wx_RadioBox::SetString( n, label )
    int n
    wxString label

void
Wx_RadioBox::SetItemLabel( n, label )
    int n
    wxString label
  CODE:
    THIS->SetString( n, label );

void
Wx_RadioBox::SetSelection( n )
    int n

void
Wx_RadioBox::SetStringSelection( string )
    wxString string

void
Wx_RadioBox::ShowItem( n, show )
    int n
    bool show
  CODE:
    THIS->Show( n, show );
