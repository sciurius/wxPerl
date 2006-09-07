#############################################################################
## Name:        XS/StatusBar.xs
## Purpose:     XS for Wx::StatusBar
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: StatusBar.xs,v 1.14 2006/09/07 20:33:13 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/statusbr.h>

MODULE=Wx PACKAGE=Wx::StatusBar

wxStatusBar*
wxStatusBar::new( parent, id = wxID_ANY, style = 0, name = wxEmptyString )
    wxWindow* parent
    wxWindowID id
    long style
    wxString name
  CODE:
    RETVAL = new wxStatusBar( parent, id, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT:
    RETVAL

wxRect*
wxStatusBar::GetFieldRect( index )
    int index
  PREINIT:
    wxRect rect;
    bool found;
  CODE:
    found = THIS->GetFieldRect( index, rect );
    if( !found )
        RETVAL = 0;
    else
        RETVAL = new wxRect( rect );
  OUTPUT:
    RETVAL

int
wxStatusBar::GetFieldsCount()

wxString
wxStatusBar::GetStatusText( ir = 0 )
    int ir

void
wxStatusBar::PushStatusText( string, n = 0 )
    wxString string
    int n

void
wxStatusBar::PopStatusText( n = 0 )
    int n

void
wxStatusBar::SetFieldsCount( number = 1 )
    int number

void
wxStatusBar::SetMinHeight( height )
    int height

void
wxStatusBar::SetStatusText( text, i = 0 )
    wxString text
    int i

void
wxStatusBar::SetStatusWidths( ... )
  PREINIT:
    int* widths;
    int i;
  CODE:
    widths = new int[items-1];
    for( i = 1; i < items; ++i )
    {
      widths[i-1] = SvIV( ST(i) );
    }
    THIS->SetStatusWidths( items-1, widths );

    delete[] widths;

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

void
wxStatusBar::SetStatusStyles( ... )
  PREINIT:
    int* styles;
    int i;
  CODE:
    styles = new int[items-1];
    for( i = 1; i < items; ++i )
    {
      styles[i-1] = SvIV( ST(i) );
    }
    THIS->SetStatusStyles( items-1, styles );

    delete[] styles;

#endif
