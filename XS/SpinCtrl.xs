#############################################################################
## Name:        XS/SpinCtrl.xs
## Purpose:     XS for Wx::SpinCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: SpinCtrl.xs,v 1.7 2003/05/31 15:36:56 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::SpinCtrl

wxSpinCtrl*
wxSpinCtrl::new( parent, id, value = wxEmptyString, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSP_ARROW_KEYS, min = 0, max = 100, initial = 0, name = wxT("spinCtrl") )
    wxWindow* parent
    wxWindowID id
    wxString value
    wxPoint pos
    wxSize size
    long style
    int min
    int max
    int initial
    wxString name
  CODE:
    RETVAL = new wxSpinCtrl( parent, id, value, pos, size,
        style, min, max, initial, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

int
wxSpinCtrl::GetMin()

int
wxSpinCtrl::GetMax()

int
wxSpinCtrl::GetValue()

void
wxSpinCtrl::SetRange( min, max )
    int min
    int max

void
wxSpinCtrl::SetValue( text )
    wxString text

#if !defined(__WXGTK__)

void
wxSpinCtrl::SetSelection( from, to )
    long from
    long to

#endif
