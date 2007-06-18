#############################################################################
## Name:        XS/MultiChoiceDialog.xs
## Purpose:     XS for Wx::MultiChoiceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:     03/02/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/choicdlg.h>

MODULE=Wx PACKAGE=Wx::MultiChoiceDialog

wxMultiChoiceDialog*
wxMultiChoiceDialog::new( parent, message, caption, chs, style = wxCHOICEDLG_STYLE, pos = wxDefaultPosition )
    wxWindow* parent
    wxString message
    wxString caption
    SV* chs
    long style
    wxPoint pos
  PREINIT:
    wxString* choices;
    int n;
  CODE:
    n = wxPli_av_2_stringarray( aTHX_ chs, &choices );
    RETVAL = new wxMultiChoiceDialog( parent, message, caption, n, choices,
        style, pos );
    delete[] choices;
  OUTPUT:
    RETVAL

void
wxMultiChoiceDialog::GetSelections()
  PREINIT:
    wxArrayInt ret;
    int i, max;
  PPCODE:
    ret = THIS->GetSelections();
    max = ret.GetCount();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i )
    {
      PUSHs( sv_2mortal( newSViv( ret[i] ) ) );
    }

void
wxMultiChoiceDialog::SetSelections( ... )
  PREINIT:
    wxArrayInt array;
    int i;
  CODE:
    array.Alloc( items - 1 );
    for( i = 1; i < items; ++i )
    {
      array.Add( SvIV( ST( i ) ) );
    }
    THIS->SetSelections( array );
