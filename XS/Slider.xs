#############################################################################
## Name:        XS/Slider.xs
## Purpose:     XS for Wx::Slider
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/slider.h>

MODULE=Wx PACKAGE=Wx::Slider

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::Slider::new" )

wxSlider*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxSlider();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

wxSlider*
newFull( CLASS, parent, id, value, minValue, maxValue, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSL_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxSliderNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    int value
    int minValue
    int maxValue
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  CODE:
    RETVAL = new wxSlider( parent, id, value, minValue, maxValue,
        pos, size, style, *validator, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

bool
wxSlider::Create( parent, id, value, minValue, maxValue, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSL_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxSliderNameStr )
    wxWindow* parent
    wxWindowID id
    int value
    int minValue
    int maxValue
    wxPoint pos
    wxSize size
    long style
    wxValidator* validator
    wxString name
  C_ARGS: parent, id, value, minValue, maxValue, pos, size, style, *validator, name

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxSlider::ClearSel()

void
wxSlider::ClearTicks()

#endif

int
wxSlider::GetLineSize()

int
wxSlider::GetMax()

int
wxSlider::GetMin()

int
wxSlider::GetPageSize()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
wxSlider::GetSelEnd()

int
wxSlider::GetSelStart()

int
wxSlider::GetThumbLength()

int
wxSlider::GetTickFreq()

#endif

int
wxSlider::GetValue()

void
wxSlider::SetRange( minValue, maxValue )
    int minValue
    int maxValue

void
wxSlider::SetTickFreq( n, pos )
    int n
    int pos

void
wxSlider::SetLineSize( lineSize )
    int lineSize

void
wxSlider::SetPageSize( pageSize )
    int pageSize

#if defined( __WXPERL_FORCE__ )

void
wxSlider::StartSelection( startPos, endPos )
    int startPos
    int endPos

#endif

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxSlider::SetThumbLength( len )
    int len

#endif

void
wxSlider::SetValue( value )
    int value
