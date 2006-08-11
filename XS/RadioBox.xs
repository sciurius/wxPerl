#############################################################################
## Name:        XS/RadioBox.xs
## Purpose:     XS for Wx::RadioBox
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: RadioBox.xs,v 1.18 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/radiobox.h>
#include <wx/tooltip.h>

MODULE=Wx PACKAGE=Wx::RadioBox

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::RadioBox::new" )

wxRadioBox*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxRadioBox();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxRadioBox*
newFull( CLASS, parent, id, label, point = wxDefaultPosition, size = wxDefaultSize, choices = 0, majorDimension = 0, style = wxRA_SPECIFY_COLS, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioBoxNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint point
    wxSize size
    SV* choices
    int majorDimension
    long style
    wxValidator* validator
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

    RETVAL = new wxRadioBox( parent, id, label, point, size,
        n, chs, majorDimension, style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );

    delete[] chs;
  OUTPUT:
    RETVAL

bool
wxRadioBox::Create( parent, id, label, point = wxDefaultPosition, size = wxDefaultSize, choices = 0, majorDimension = 0, style = wxRA_SPECIFY_COLS, validator = (wxValidator*)&wxDefaultValidator, name = wxRadioBoxNameStr )
    wxWindow* parent
    wxWindowID id
    wxString label
    wxPoint point
    wxSize size
    SV* choices
    int majorDimension
    long style
    wxValidator* validator
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

    RETVAL = THIS->Create( parent, id, label, point, size,
        n, chs, majorDimension, style, *validator, name );

    delete[] chs;
  OUTPUT:
    RETVAL

void
wxRadioBox::EnableItem( n, enable )
    int n
    bool enable
  CODE:
    THIS->Enable( n, enable );

int
wxRadioBox::FindString( string )
    wxString string

wxString
wxRadioBox::GetString( n )
    int n

wxString
wxRadioBox::GetItemLabel( n )
    int n
  CODE:
    RETVAL = THIS->GetString( n );
  OUTPUT:
    RETVAL

int
wxRadioBox::GetSelection()

wxString
wxRadioBox::GetStringSelection()

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

bool
wxRadioBox::IsItemEnabled( unsigned int item )

bool
wxRadioBox::IsItemShown( unsigned int item )

#endif

void
wxRadioBox::SetString( n, label )
    int n
    wxString label

void
wxRadioBox::SetItemLabel( n, label )
    int n
    wxString label
  CODE:
    THIS->SetString( n, label );

#if wxPERL_USE_TOOLTIPS && WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxRadioBox::SetItemToolTip( item, text )
    unsigned int item
    wxString text

wxToolTip*
wxRadioBox::GetItemToolTip( item )
    unsigned int item

#endif

#if wxPERL_USE_HELP && WXPERL_W_VERSION_GE( 2, 7, 0 )

void
wxRadioBox::SetItemHelpText( item, text )
    unsigned int item
    wxString text

wxString
wxRadioBox::GetItemHelpText( item )
    unsigned int item

#endif

void
wxRadioBox::SetSelection( n )
    int n

void
wxRadioBox::SetStringSelection( string )
    wxString string

void
wxRadioBox::ShowItem( n, show )
    int n
    bool show
  CODE:
    THIS->Show( n, show );
