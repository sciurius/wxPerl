#############################################################################
## Name:        StyledTextCtrl.xs
## Purpose:     XS for Wx::StyledTextCtrl
## Author:      Mattia Barbon
## Modified by:
## Created:     23/ 5/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::StyledTextCtrl

#include "wx/stc/stc.h"

Wx_StyledTextCtrl*
Wx_StyledTextCtrl::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = 0, name = wxSTCNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name

void
Wx_StyledTextCtrl::AddText( text )
    wxString text

void
Wx_StyledTextCtrl::SetLexer( lexer )
    int lexer

int
Wx_StyledTextCtrl::GetLexer()

void
Wx_StyledTextCtrl::StyleSetSpec( style, spec )
    int style
    wxString spec

