#############################################################################
## Name:        XS/Gauge.xs
## Purpose:     XS for Wx::Gauge
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      $Id: Gauge.xs,v 1.5 2003/05/29 20:04:23 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/gauge.h>

MODULE=Wx PACKAGE=Wx::Gauge

wxGauge*
wxGauge::new( parent, id, range, pos = wxDefaultPosition, size = wxDefaultSize, style = wxGA_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxGaugeNameStr )
    wxWindow* parent
    wxWindowID id
    int range
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxGauge( parent, id, range, pos, size,
        style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
wxGauge::GetBezelFace()

#endif

int
wxGauge::GetRange()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
wxGauge::GetShadowWidth()

#endif

int
wxGauge::GetValue()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxGauge::SetBezelFace( width )
    int width

#endif

void
wxGauge::SetRange( range )
    int range

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxGauge::SetShadowWidth( width )
    int width

#endif

void
wxGauge::SetValue( pos )
    int pos
