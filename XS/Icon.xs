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

#ifdef __WXMSW__

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
