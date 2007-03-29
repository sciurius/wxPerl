#############################################################################
## Name:        XS/Caret.xs
## Purpose:     XS for Wx::Caret
## Author:      Mattia Barbon
## Modified by:
## Created:     29/12/2000
## RCS-ID:      $Id: Caret.xs,v 1.8 2007/03/29 19:53:57 mbarbon Exp $
## Copyright:   (c) 2000-2002, 2004, 2007 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/caret.h>

MODULE=Wx PACKAGE=Wx::Caret

void
wxCaret::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_n_n, newWH )
        MATCH_REDISP( wxPliOvl_wwin_wsiz, newSize )
        MATCH_VOIDM_REDISP( newDefault )
    END_OVERLOAD( Wx::Caret::new )

wxCaret*
newDefault( CLASS, window, width, height )
    SV* CLASS
  CODE:
    RETVAL = new wxCaret();
  OUTPUT: RETVAL

wxCaret*
newSize( CLASS, window, size )
    SV* CLASS
    wxWindow* window
    wxSize size
  CODE:
    RETVAL = new wxCaret( window, size );
  OUTPUT: RETVAL

wxCaret*
newWH( CLASS, window, width, height )
    SV* CLASS
    wxWindow* window
    int width
    int height
  CODE:
    RETVAL = new wxCaret( window, width, height );
  OUTPUT: RETVAL

void
wxCaret::Create( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_n_n, CreateWH )
        MATCH_REDISP( wxPliOvl_wwin_wsiz, CreateSize )
    END_OVERLOAD( Wx::Caret::Create )

bool
wxCaret::CreateSize( window, size )
    wxWindow* window
    wxSize size
  CODE:
    RETVAL = THIS->Create( window, size );
  OUTPUT: RETVAL

bool
wxCaret::CreateWH( window, width, height )
    wxWindow* window
    int width
    int height
  CODE:
    RETVAL = THIS->Create( window, width, height );
  OUTPUT: RETVAL

void
wxCaret::Destroy()
  CODE:
    delete THIS;

int
GetBlinkTime()
  CODE:
    RETVAL = wxCaret::GetBlinkTime();
  OUTPUT:
    RETVAL

void
wxCaret::GetSizeWH()
  PREINIT:
    int w;
    int h;
  PPCODE:
    THIS->GetPosition( &w, &h );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( w ) ) );
    PUSHs( sv_2mortal( newSViv( h ) ) );

wxSize*
wxCaret::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
wxCaret::GetPositionXY()
  PREINIT:
    int x;
    int y;
  PPCODE:
    THIS->GetPosition( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxPoint*
wxCaret::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

wxWindow*
wxCaret::GetWindow()

void
wxCaret::Hide()

bool
wxCaret::IsOk()

bool
wxCaret::IsVisible()

void
wxCaret::Move( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wpoi, MovePoint )
        MATCH_REDISP( wxPliOvl_n_n, MoveXY )
    END_OVERLOAD( Wx::Caret::Move )

void
wxCaret::MovePoint( point )
    wxPoint point
  CODE:
    THIS->Move( point );

void
wxCaret::MoveXY( x, y )
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
wxCaret::SetSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
      MATCH_REDISP( wxPliOvl_wsiz, SetSizeSize )
      MATCH_REDISP( wxPliOvl_n_n, SetSizeWH )
    END_OVERLOAD( Wx::Caret::SetSize )

void
wxCaret::SetSizeSize( size )
    wxSize size
  CODE:
    THIS->SetSize( size );

void
wxCaret::SetSizeWH( w, h )
    int w
    int h
  CODE:
    THIS->SetSize( w, h );

void
wxCaret::Show( show = true )
    bool show
