#############################################################################
## Name:        Icon.xs
## Purpose:     XS for Wx::Icon
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

MODULE=Wx PACKAGE=Wx::Icon

#FIXME// unimplemented
# some constructors
# operator == !=

#if ( !defined( __WXMSW__ ) && !defined( __WXGTK__ ) ) || defined( __WXPERL_FORCE__ )

Wx_Icon*
newEmpty( width, height, depth = -1 )
    int width
    int height
    int depth
  CODE:
    RETVAL = new wxIcon( width, height, depth );
  OUTPUT:
    RETVAL

#endif

Wx_Icon*
newFile( name, type, desW = -1, desH = -1 )
    wxString name
    long type
    int desW
    int desH
  CODE:
    RETVAL = new wxIcon( name, type, desW, desH );
  OUTPUT:
    RETVAL

void
Wx_Icon::DESTROY()

bool
Wx_Icon::LoadFile( name, type )
    wxString name
    long type
  CODE:
    RETVAL = THIS->LoadFile( name, type );

bool
Wx_Icon::Ok()

#if defined( __WXMSW__ ) || defined( __WXPERL_FORCE__ )

int
Wx_Icon::GetDepth()

int
Wx_Icon::GetHeight()

int
Wx_Icon::GetWidth()

void
Wx_Icon::SetDepth( depth )
    int depth

void
Wx_Icon::SetHeight( height )
    int height

void
Wx_Icon::SetWidth( width )
    int width

#endif
