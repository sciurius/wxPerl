#############################################################################
## Name:        MultiChoiceDialog.xs
## Purpose:     XS for Wx::MultiChoiceDialog
## Author:      Mattia Barbon
## Modified by:
## Created:      3/ 2/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::MultiChoiceDialog

#if WXPERL_W_VERSION_GE( 2, 3 )

Wx_MultiChoiceDialog*
Wx_MultiChoiceDialog::new( parent, message, caption, chs, style = wxCHOICEDLG_STYLE, pos = wxDefaultPosition )
    Wx_Window* parent
    wxString message
    wxString caption
    SV* chs
    long style
    Wx_Point pos
  PREINIT:
    wxString* choices;
    int n;
  CODE:
    n = _av_2_stringarray( chs, &choices );
    RETVAL = new wxMultiChoiceDialog( parent, message, caption, n, choices,
        style, pos );
    delete[] choices;
  OUTPUT:
    RETVAL

void
Wx_MultiChoiceDialog::GetSelections()
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
Wx_MultiChoiceDialog::SetSelections( ... )
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

#endif
