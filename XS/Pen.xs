#############################################################################
## Name:        XS/Pen.xs
## Purpose:     XS for Wx::Pen
## Author:      Mattia Barbon
## Modified by:
## Created:     21/11/2000
## RCS-ID:      $Id$
## Copyright:   (c) 2000-2003, 2004, 2006-2008 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/colour.h>
#include <wx/pen.h>

MODULE=Wx PACKAGE=Wx::Pen

void
wxPen::new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wcol_n_n, newColour )
        MATCH_REDISP( wxPliOvl_wbmp_n, newBitmap )
        MATCH_REDISP( wxPliOvl_s_n_n, newString )
    END_OVERLOAD( Wx::Pen::new )

wxPen*
newColour( CLASS, colour, width, style )
    SV* CLASS
    wxColour* colour
    int width
    int style
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxPen( *colour, width, style );
#else
    RETVAL = new wxPen( *colour, width, (wxPenStyle)style );
#endif
  OUTPUT:
    RETVAL

wxPen*
newString( CLASS, name, width, style )
    SV* CLASS
    wxString name
    int width
    int style
  CODE:
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
    RETVAL = new wxPen( name, width, style );
#else
    RETVAL = new wxPen( name, width, (wxPenStyle)style );
#endif
  OUTPUT:
    RETVAL

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxPen*
newBitmap( CLASS, stipple, width )
    SV* CLASS
    wxBitmap* stipple
    int width
  CODE:
    RETVAL = new wxPen( *stipple, width );
  OUTPUT: RETVAL

#endif

static void
wxPen::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxPen::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::Pen", THIS, ST(0) );
    delete THIS;

wxPenCap
wxPen::GetCap()

wxColour*
wxPen::GetColour()
  CODE:
    RETVAL = new wxColour( THIS->GetColour() );
  OUTPUT:
    RETVAL

void
wxPen::GetDashes()
  PREINIT:
    int i, n;
    wxDash* array;
  PPCODE:
    n = THIS->GetDashes( &array );
    EXTEND( SP, n );
    for( i = 0; i < n; ++i )
    {
      PUSHs( sv_2mortal( newSViv( array[i] ) ) );
    }

wxPenJoin
wxPen::GetJoin()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

wxBitmap*
wxPen::GetStipple()
  CODE:
    RETVAL = new wxBitmap( *THIS->GetStipple() );
  OUTPUT:
    RETVAL

#endif

wxPenStyle
wxPen::GetStyle()

int
wxPen::GetWidth()

bool
wxPen::Ok()

#if WXPERL_W_VERSION_GE( 2, 8, 0 )

bool
wxPen::IsOk()

#endif

void
wxPen::SetCap( capStyle )
    wxPenCap capStyle

void
wxPen::SetColour( ... )
  PPCODE:
     BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wcol, SetColourColour )
        MATCH_REDISP( wxPliOvl_n_n_n, SetColourRGB )
        MATCH_REDISP( wxPliOvl_s, SetColourName )
    END_OVERLOAD( Wx::Pen::SetColour )

void
wxPen::SetColourColour( colour )
    wxColour* colour
  CODE:
    THIS->SetColour( *colour );

void
wxPen::SetColourName( name )
    wxString name
  CODE:
    THIS->SetColour( name );

void
wxPen::SetColourRGB( r, g, b )
    int r
    int g
    int b
  CODE:
    THIS->SetColour( r, g, b );

void
wxPen::SetDashes( ds )
    SV* ds
  PREINIT:
    int n = 0;
    wxDash* dashes = 0;
    wxDash* olddashes;
  CODE:
    THIS->GetDashes( &olddashes );
    if( SvOK( ds ) )
    {
      AV* av;
      SV* t;
      int i;

      if( !SvROK( ds ) || 
          ( SvTYPE( (SV*) ( av = (AV*) SvRV( ds ) ) ) != SVt_PVAV ) )
      {
          croak( "the value is not an array reference" );
          XSRETURN_UNDEF;
      }
    
      n = av_len( av ) + 1;
      dashes = new wxDash[ n ];

      for( i = 0; i < n; ++i )
      {
        t = *av_fetch( av, i, 0 );
        dashes[i] = SvIV( t );
      }
    }
    THIS->SetDashes( n, dashes );
    delete[] olddashes;

void
wxPen::SetJoin( join_style )
    wxPenJoin join_style

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

void
wxPen::SetStipple( stipple )
    wxBitmap* stipple
  CODE:
    THIS->SetStipple( *stipple );

#endif

void
wxPen::SetStyle( style )
    wxPenStyle style

void
wxPen::SetWidth( width )
    int width
