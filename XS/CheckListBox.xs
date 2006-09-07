#############################################################################
## Name:        XS/CheckListBox.xs
## Purpose:     XS for Wx::CheckListBox
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id: CheckListBox.xs,v 1.10 2006/09/07 20:45:28 mbarbon Exp $
## Copyright:   (c) 2000-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/checklst.h>

MODULE=Wx PACKAGE=Wx::CheckListBox

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::CheckListBox::new" )

wxCheckListBox*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxCheckListBox();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxCheckListBox*
newFull( CLASS, parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
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
        
    RETVAL = new wxCheckListBox( parent, id, pos, size, n, chs, 
        style|wxLB_OWNERDRAW, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );

    delete[] chs;
  OUTPUT:
    RETVAL

bool
wxCheckListBox::Create( parent, id = wxID_ANY, pos = wxDefaultPosition, size = wxDefaultSize, choices = 0, style = 0, validator = (wxValidator*)&wxDefaultValidator, name = wxListBoxNameStr )
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
        style|wxLB_OWNERDRAW, *validator, name );

    delete[] chs;
  OUTPUT: RETVAL

void
wxCheckListBox::Check( item, check = false )
    int item
    bool check

bool
wxCheckListBox::IsChecked( item )
    int item
