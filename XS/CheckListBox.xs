#############################################################################
## Name:        CheckListBox.xs
## Purpose:     XS for Wx::CheckListBox
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::CheckListBox

Wx_CheckListBox*
Wx_CheckListBox::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
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
        n = wxPli_av_2_stringarray( choices, &chs );
    else
    {
        n = 0;
        chs = 0;
    }
        
    RETVAL = new wxPliCheckListBox( CLASS, parent, id, pos, size, n, chs, 
        style|wxLB_OWNERDRAW, *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

void
Wx_CheckListBox::Check( item, check = FALSE )
    int item
    bool check

bool
Wx_CheckListBox::IsChecked( item )
    int item
