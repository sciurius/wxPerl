#############################################################################
## Name:        XS/GraphicsObject.xs
## Purpose:     XS for Wx::GraphicsObject
## Author:      Mattia Barbon
## Modified by:
## Created:     30/09/2007
## RCS-ID:      $Id$
## Copyright:   (c) 2007 Klaas Hartmann
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#if wxUSE_GRAPHICS_CONTEXT

#include <wx/graphics.h>

MODULE=Wx PACKAGE=Wx::GraphicsObject

static void
wxGraphicsObject::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxGraphicsObject::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ),
                                THIS, ST(0) );
    delete THIS;

wxGraphicsRenderer*
wxGraphicsObject::GetRenderer()

bool
wxGraphicsObject::IsNull()

MODULE=Wx PACKAGE=Wx::GraphicsBrush

MODULE=Wx PACKAGE=Wx::GraphicsPen

MODULE=Wx PACKAGE=Wx::GraphicsFont

#endif
