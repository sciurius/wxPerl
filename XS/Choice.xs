#############################################################################
## Name:        Choice.xs
## Purpose:     XS for Wx::Choice
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Choice

Wx_Choice*
Wx_Choice::new( parent, id, pos, size, choices, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxChoiceNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    SV* choices
    long style
    Wx_Validator* validator
    wxString name
  PREINIT:
    int n;
    wxString *chs;
  CODE:
    n = wxPli_av_2_stringarray( choices, &chs );

    RETVAL = new wxPliChoice( CLASS, parent, id, pos, size, n, chs, style, 
        *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

int
Wx_Choice::GetColumns()

void
Wx_Choice::SetColumns( n = 1 )
    int n

void
Wx_Choice::SetSelection( n )
    int n

void
Wx_Choice::SetStringSelection( string )
    wxString string
