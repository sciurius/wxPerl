#############################################################################
## Name:        SingleChoiceDialog.xs
## Purpose:     XS for Wx::SingleChoiceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

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
    n = _av_2_stringarray( chs, &choices );
    if( !SvOK( dt ) )
    {
      RETVAL = new wxSingleChoiceDialog( parent, message, caption, n,
            choices, 0, style, pos );
    }
    else
    {
      n2 = _av_2_svarray( dt, &data );
      if( n != n2 )
      {
        delete[] choices;
        delete[] data;
        choices = 0; data = 0; n = 0;
        croak( "supplied arrays of different size" );
      }
      RETVAL = new wxSingleChoiceDialog( parent, message, caption, n,
            choices, (char**)data, style, pos );
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
    RETVAL = t ? (SV*)t : &PL_sv_undef;
  OUTPUT:
    RETVAL

wxString
Wx_SingleChoiceDialog::GetStringSelection()

void
Wx_SingleChoiceDialog::SetSelection( selection )
    int selection

