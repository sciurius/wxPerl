#############################################################################
## Name:        Cursor.xs
## Purpose:     XS for Wx::Cursor
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Cursor

#FIXME// unimplemented
# operator == !=

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

Wx_Cursor*
newFile( name, type, hsx = -1, hsy = -1 )
    wxString name
    long type
    int hsx
    int hsy
  CODE:
    RETVAL = new wxCursor( name, type, hsx, hsy );
  OUTPUT:
    RETVAL

#endif

Wx_Cursor*
newId( id )
    wxStockCursor id
  CODE:
    RETVAL = new wxCursor( id );
  OUTPUT:
    RETVAL

void
Wx_Cursor::DESTROY()

bool
Wx_Cursor::Ok()
