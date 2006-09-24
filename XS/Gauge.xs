#############################################################################
## Name:        XS/Gauge.xs
## Purpose:     XS for Wx::Gauge
## Author:      Mattia Barbon
## Modified by:
## Created:     08/11/2000
## RCS-ID:      $Id: Gauge.xs,v 1.9 2006/09/24 17:15:58 mbarbon Exp $
## Copyright:   (c) 2000-2001, 2003, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/gauge.h>

MODULE=Wx PACKAGE=Wx::Gauge

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Gauge::new" )

wxGauge*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxGauge();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL


wxGauge*
newFull( CLASS, parent, id, range, pos = wxDefaultPosition, size = wxDefaultSize, style = wxGA_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxGaugeNameStr )
    PlClassName CLASS
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

bool
wxGauge::Create( parent, id, range, pos = wxDefaultPosition, size = wxDefaultSize, style = wxGA_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxGaugeNameStr )
    wxWindow* parent
    wxWindowID id
    int range
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, range, pos, size, style, *validator, name

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

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

bool
wxGauge::IsVertical()

#endif

#if WXPERL_W_VERSION_GE( 2, 7, 1 )

void
wxGauge::Pulse()

#endif
