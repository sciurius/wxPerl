#############################################################################
## Name:        XS/SingleChoiceDialog.xs
## Purpose:     XS for Wx::SingleChoiceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     03/02/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2002, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/choicdlg.h>
#include "cpp/singlechoicedialog.h"

MODULE=Wx PACKAGE=Wx::SingleChoiceDialog

wxSingleChoiceDialog*
wxSingleChoiceDialog::new( parent, message, caption, chs, dt = &PL_sv_undef, style = wxCHOICEDLG_STYLE, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString caption
    SV* chs
    SV* dt
    long style
    wxPoint pos
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
wxSingleChoiceDialog::GetSelection()

SV*
wxSingleChoiceDialog::GetSelectionClientData()
  PREINIT:
    char* t;
  CODE:
    t = THIS->GetSelectionClientData();
    RETVAL = &PL_sv_undef;
    if( t )
    {
        RETVAL = (SV*)t;
    }
    SvREFCNT_inc( RETVAL );
  OUTPUT:
    RETVAL

wxString
wxSingleChoiceDialog::GetStringSelection()

void
wxSingleChoiceDialog::SetSelection( selection )
    int selection

MODULE=Wx PACKAGE=Wx PREFIX=wx

#
# Function interface
#

wxString
wxGetSingleChoice( message, caption, chs, parent = 0, x = -1, y = -1, centre = true, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    wxWindow* parent
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
wxGetSingleChoiceIndex( message, caption, chs, parent = 0, x = -1, y = -1, centre = true, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    wxWindow* parent
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
wxGetSingleChoiceData( message, caption, chs, dt, parent = 0, x = -1, y = -1, centre = true, width = wxCHOICE_WIDTH, height = wxCHOICE_HEIGHT )
    wxString message
    wxString caption
    SV* chs
    SV* dt
    wxWindow* parent
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
    SvREFCNT_inc( RETVAL );
    delete[] choices;
    delete[] data;
  OUTPUT:
    RETVAL
