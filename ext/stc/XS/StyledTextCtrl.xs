#############################################################################
## Name:        StyledTextCtrl.xs
## Purpose:     XS for Wx::StyledTextCtrl
## Author:      Marcus Friedlaender and Mattia Barbon
## Created:     23/ 5/2002
## RCS-ID:
## Copyright:   (c) 2002 Marcus Friedlaender and Mattia Barbon
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

void
Wx_StyledTextCtrl::StyleSetFont( style, font )
    int style
    Wx_Font* font
  CODE:
    THIS->StyleSetFont( style, *font );

void
Wx_StyledTextCtrl::StyleClearAll()

void
Wx_StyledTextCtrl::StyleSetForeground( style, fore )
    int style
    Wx_Colour fore

void
Wx_StyledTextCtrl::StyleSetBold( style, bold )
    int style
    bool bold

void
Wx_StyledTextCtrl::StyleSetItalic( style, italic )
    int style
    bool italic

void
Wx_StyledTextCtrl::StyleSetUnderline( style, underline )
    int style
    bool underline

void
Wx_StyledTextCtrl::InsertText(pos, text)
    int pos
    wxString text

void
Wx_StyledTextCtrl::EmptyUndoBuffer()

void
Wx_StyledTextCtrl::SetKeyWords(keyword_set, keywords)
    int keyword_set
    wxString keywords

void
Wx_StyledTextCtrl::StyleSetSize(style, size_points)
    int style
    int size_points

void
Wx_StyledTextCtrl::StyleSetFaceName(style, font_name)
    int style
    wxString font_name
