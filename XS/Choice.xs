#############################################################################
## Name:        Choice.xs
## Purpose:     XS for Wx::Choice
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: Choice.xs,v 1.9 2003/05/05 20:38:41 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Choice

Wx_Choice*
Wx_Choice::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxChoiceNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    SV* choices
    long style
    Wx_Validator* validator
    wxString name
  PREINIT:
    int n = 0;
    wxString *chs = 0;
  CODE:
    if( choices )
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );

    RETVAL = new wxPliChoice( CLASS, parent, id, pos, size, n, chs, style, 
        *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

void
Wx_Choice::Clear()

void
Wx_Choice::Delete( n )
    int n

#if !defined(__WXUNIVERSAL__)

int
Wx_Choice::GetColumns()

void
Wx_Choice::SetColumns( n = 1 )
    int n

#endif

void
Wx_Choice::SetSelection( n )
    int n

void
Wx_Choice::SetStringSelection( string )
    wxString string
