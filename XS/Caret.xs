#############################################################################
## Name:        Caret.xs
## Purpose:     XS for Wx::Caret
## Author:      Mattia Barbon
## Modified by:
## Created:     29/12/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Caret

Wx_Caret*
newSize( window, size )
    Wx_Window* window
    Wx_Size size
  CODE:
    RETVAL = new wxCaret( window, size );
  OUTPUT:
    RETVAL

Wx_Caret*
newWH( window, width, height )
    Wx_Window* window
    int width
    int height
  CODE:
    RETVAL = new wxCaret( window, width, height );
  OUTPUT:
    RETVAL

void
Wx_Caret::Destroy()
  CODE:
    delete THIS;

int
GetBlinkTime()
  CODE:
    RETVAL = wxCaret::GetBlinkTime();
  OUTPUT:
    RETVAL

void
Wx_Caret::GetSizeWH()
  PREINIT:
    int w;
    int h;
  PPCODE:
    THIS->GetPosition( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

Wx_Size*
Wx_Caret::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
Wx_Caret::GetPositionXY()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetPosition( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

Wx_Point*
Wx_Caret::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

Wx_Window*
Wx_Caret::GetWindow()

void
Wx_Caret::Hide()

bool
Wx_Caret::IsOk()

bool
Wx_Caret::IsVisible()

void
Wx_Caret::MovePoint( point )
    Wx_Point point
  CODE:
    THIS->Move( point );

void
Wx_Caret::MoveXY( x, y )
    int x
    int y
  CODE:
    THIS->Move( x, y );

void
SetBlinkTime( milliseconds )
    int milliseconds
  CODE:
    wxCaret::SetBlinkTime( milliseconds );

void
Wx_Caret::SetSizeSize( size )
    Wx_Size size
  CODE:
    THIS->SetSize( size );

void
Wx_Caret::SetSizeWH( w, h )
    int w
    int h
  CODE:
    THIS->SetSize( w, h );

void
Wx_Caret::Show( show = TRUE )
    bool show