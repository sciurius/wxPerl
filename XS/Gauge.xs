#############################################################################
## Name:        Gauge.xs
## Purpose:     XS for Wx::Gauge
## Author:      Mattia Barbon
## Modified by:
## Created:      8/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Gauge

Wx_Gauge*
Wx_Gauge::new( parent, id, range, pos = wxDefaultPosition, size = wxDefaultSize, style = wxGA_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxGaugeNameStr )
    Wx_Window* parent
    wxWindowID id
    int range
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new _wxGauge( CLASS, parent, id, range, pos, size,
        style, *validator, name );
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_Gauge::GetBezelFace()

#endif

int
Wx_Gauge::GetRange()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_Gauge::GetShadowWidth()

#endif

int
Wx_Gauge::GetValue()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Gauge::SetBezelFace( width )
    int width

#endif

void
Wx_Gauge::SetRange( range )
    int range

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Gauge::SetShadowWidth( width )
    int width

#endif

void
Wx_Gauge::SetValue( pos )
    int pos
