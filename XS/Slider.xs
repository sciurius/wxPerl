#############################################################################
## Name:        Notebook.xs
## Purpose:     XS for Wx::Slider
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Slider

Wx_Slider*
Wx_Slider::new( parent, id, value, minValue, maxValue, pos = wxDefaultPosition, size = wxDefaultSize, style = wxSL_HORIZONTAL, validator = (wxValidator*)&wxDefaultValidator, name = wxSliderNameStr )
    Wx_Window* parent
    wxWindowID id
    int value
    int minValue
    int maxValue
    Wx_Point pos
    Wx_Size size
    long style
    Wx_Validator* validator
    wxString name
  CODE:
    RETVAL = new _wxSlider( CLASS, parent, id, value, minValue, maxValue,
        pos, size, style, *validator, name );
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Slider::ClearSel()

void
Wx_Slider::ClearTicks()

#endif

int
Wx_Slider::GetLineSize()

int
Wx_Slider::GetMax()

int
Wx_Slider::GetMin()

int
Wx_Slider::GetPageSize()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_Slider::GetSelEnd()

int
Wx_Slider::GetSelStart()

int
Wx_Slider::GetThumbLength()

int
Wx_Slider::GetTickFreq()

#endif

int
Wx_Slider::GetValue()

void
Wx_Slider::SetRange( minValue, maxValue )
    int minValue
    int maxValue

void
Wx_Slider::SetTickFreq( n, pos )
    int n
    int pos

void
Wx_Slider::SetLineSize( lineSize )
    int lineSize

void
Wx_Slider::SetPageSize( pageSize )
    int pageSize

#if 0

void
Wx_Slider::StartSelection( startPos, endPos )
    int startPos
    int endPos

#endif

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
Wx_Slider::SetThumbLength( len )
    int len

#endif

#if 0

void
Wx_Slider::SetThick( pos )
    int pos

#endif

void
Wx_Slider::SetValue( value )
    int value
