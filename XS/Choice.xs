#############################################################################
## Name:        XS/Choice.xs
## Purpose:     XS for Wx::Choice
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: Choice.xs,v 1.10 2003/05/29 20:04:23 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/choice.h>

MODULE=Wx PACKAGE=Wx::Choice

wxChoice*
wxChoice::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxChoiceNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    SV* choices
    long style
    wxValidator* validator
    wxString name
  PREINIT:
    int n = 0;
    wxString *chs = 0;
  CODE:
    if( choices )
        n = wxPli_av_2_stringarray( aTHX_ choices, &chs );

    RETVAL = new wxChoice( parent, id, pos, size, n, chs, style, 
        *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );

    delete[] chs;
  OUTPUT:
    RETVAL

void
wxChoice::Clear()

void
wxChoice::Delete( n )
    int n

#if !defined(__WXUNIVERSAL__)

int
wxChoice::GetColumns()

void
wxChoice::SetColumns( n = 1 )
    int n

#endif

void
wxChoice::SetSelection( n )
    int n

void
wxChoice::SetStringSelection( string )
    wxString string
