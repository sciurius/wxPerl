#############################################################################
## Name:        SingleChoiceDialog.xs
## Purpose:     XS for Wx::SingleChoiceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/choicdlg.h>
#include "cpp/singlechoicedialog.h"

MODULE=Wx PACKAGE=Wx::SingleChoiceDialog

Wx_SingleChoiceDialog*
Wx_SingleChoiceDialog::new( parent, message, caption, chs, dt = &PL_sv_undef, style = wxCHOICEDLG_STYLE, pos = wxDefaultPosition )
    Wx_Window* parent
    wxString message
    wxString caption
    SV* chs
    SV* dt
    long style
    Wx_Point pos
  PREINIT:
    wxString* choices;
    SV** data;
    int n, n2;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ chs, &choices );
    if( !SvOK( dt ) )
    {
      RETVAL = new wxPliSingleChoiceDialog( parent, message, caption, n,
            choices, 0, style, pos );
    }
    else
    {
      n2 = wxPli_av_2_svarray( aTHX_ dt, &data );
      if( n != n2 )
      {
        delete[] choices;
        delete[] data;
        choices = 0; data = 0; n = 0;
        croak( "supplied arrays of different size" );
      }
      RETVAL = new wxPliSingleChoiceDialog( parent, message, caption, n,
            choices, data, style, pos );
      delete[] data;
    }
    delete[] choices;
  OUTPUT:
    RETVAL

int
Wx_SingleChoiceDialog::GetSelection()

SV*
Wx_SingleChoiceDialog::GetSelectionClientData()
  PREINIT:
    char* t;
  CODE:
    t = THIS->GetSelectionClientData();
    RETVAL = &PL_sv_undef;
    if( t )
    {
        RETVAL = (SV*)t;
    }
  OUTPUT:
    RETVAL

wxString
Wx_SingleChoiceDialog::GetStringSelection()

void
Wx_SingleChoiceDialog::SetSelection( selection )
    int selection

MODULE=Wx PACKAGE=Wx PREFIX=wx

#
# Function interface
#

wxString
wxGetSingleChoice( message, caption, chs, parent = 0, x = -1, y = -1, centre = TRUE, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    Wx_Window* parent
    int x
    int y
    bool centre
    int width
    int height
  PREINIT:
    wxString* choices;
    int n;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ chs, &choices );
    RETVAL = wxGetSingleChoice( message, caption, n, choices, parent, x, y,
        centre, width, height );
    delete[] choices;
  OUTPUT:
    RETVAL

int
wxGetSingleChoiceIndex( message, caption, chs, parent = 0, x = -1, y = -1, centre = TRUE, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    Wx_Window* parent
    int x
    int y
    bool centre
    int width
    int height
  PREINIT:
    wxString* choices;
    int n;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ chs, &choices );
    RETVAL = wxGetSingleChoiceIndex( message, caption, n, choices,
        parent, x, y, centre, width, height );
    delete[] choices;
  OUTPUT:
    RETVAL

SV*
wxGetSingleChoiceData( message, caption, chs, dt, parent = 0, x = -1, y = -1, centre = TRUE, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    SV* dt
    Wx_Window* parent
    int x
    int y
    bool centre
    int width
    int height
  PREINIT:
    wxString* choices;
    SV** data;
    int n, n2;
    void* rt;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ chs, &choices );
    n2 = wxPli_av_2_svarray( aTHX_ dt, &data );
    if( n != n2 )
    {
      delete[] choices;
      delete[] data;
      choices = 0; data = 0; n = 0;
      croak( "supplied arrays of different sizes" );
    }
    rt = wxGetSingleChoiceData( message, caption, n, choices, (void**)data,
        parent, x, y, centre, width, height );
    RETVAL = rt ? (SV*)rt : &PL_sv_undef;
    delete[] choices;
    delete[] data;
  OUTPUT:
    RETVAL
