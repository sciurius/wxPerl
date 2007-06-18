#############################################################################
## Name:        XS/Choice.xs
## Purpose:     XS for Wx::Choice
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2003, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/choice.h>

MODULE=Wx PACKAGE=Wx::Choice

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Choice::new" )

wxChoice*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxChoice();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxChoice*
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxChoiceNameStr )
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

bool
wxChoice::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxChoiceNameStr )
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

    RETVAL = THIS->Create( parent, id, pos, size, n, chs, style, 
        *validator, name );

    delete[] chs;
  OUTPUT: RETVAL

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

#if WXPERL_W_VERSION_GE( 2, 7, 2 )

int
wxChoice::GetCurrentSelection()

#endif

void
wxChoice::SetSelection( n )
    int n

void
wxChoice::SetStringSelection( string )
    wxString string
