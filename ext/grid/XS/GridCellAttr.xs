#############################################################################
## Name:        GridCellAttr.xs
## Purpose:     XS for Wx::GridCellAttr
## Author:      Mattia Barbon
## Modified by:
## Created:      5/12/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::GridCellAttr

Wx_GridCellAttr*
Wx_GridCellAttr::new()

void
Wx_GridCellAttr::DESTROY()
  CODE:
    THIS->DecRef();

void
Wx_GridCellAttr::IncRef()

void
Wx_GridCellAttr::DecRef()

void
Wx_GridCellAttr::SetTextColour( colour )
    Wx_Colour colour

void
Wx_GridCellAttr::SetBackgroundColour( colour )
    Wx_Colour colour

void
Wx_GridCellAttr::SetFont( font )
    Wx_Font* font
  CODE:
    THIS->SetFont( *font );

void
Wx_GridCellAttr::SetAlignment( hAlign, vAlign )
    int hAlign
    int vAlign

void
Wx_GridCellAttr::SetReadOnly( isReadOnly = TRUE )
    bool isReadOnly

bool
Wx_GridCellAttr::HasTextColour()

bool
Wx_GridCellAttr::HasBackgroundColour()

bool
Wx_GridCellAttr::HasFont()

bool
Wx_GridCellAttr::HasAlignment()

bool
Wx_GridCellAttr::HasRenderer()

bool
Wx_GridCellAttr::HasEditor()

Wx_Colour*
Wx_GridCellAttr::GetTextColour()
  CODE:
    RETVAL = new wxColour( THIS->GetTextColour() );
  OUTPUT:
    RETVAL

Wx_Colour*
Wx_GridCellAttr::GetBackgroundColour()
  CODE:
    RETVAL = new wxColour( THIS->GetBackgroundColour() );
  OUTPUT:
    RETVAL

Wx_Font*
Wx_GridCellAttr::GetFont()
  CODE:
    RETVAL = new wxFont( THIS->GetFont() );
  OUTPUT:
    RETVAL

void
Wx_GridCellAttr::GetAlignment()
  PREINIT:
    int x, y;
  PPCODE:
    THIS->GetAlignment( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

bool
Wx_GridCellAttr::IsReadOnly()

void
Wx_GridCellAttr::SetDefAttr( defAttr )
    Wx_GridCellAttr* defAttr
