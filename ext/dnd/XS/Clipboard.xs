#############################################################################
## Name:        ext/dnd/XS/Clipboard.xs
## Purpose:     XS for Wx::Clipboard
## Author:      Mattia Barbon
## Modified by:
## Created:     13/08/2001
## RCS-ID:      $Id: Clipboard.xs,v 1.7 2004/08/04 20:13:55 mbarbon Exp $
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/clipbrd.h>

MODULE=Wx PACKAGE=Wx::Clipboard

bool
wxClipboard::AddData( data )
    wxDataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    RETVAL = THIS->AddData( data );
  OUTPUT:
    RETVAL

void
wxClipboard::Clear()

void
wxClipboard::Close()

bool
wxClipboard::Flush()

bool
wxClipboard::GetData( data )
    wxDataObject* data
  CODE:
    RETVAL = THIS->GetData( *data );
  OUTPUT:
    RETVAL

bool
wxClipboard::IsOpened()

bool
wxClipboard::IsSupported( format )
    wxDataFormat* format
  CODE:
    RETVAL = THIS->IsSupported( *format );
  OUTPUT:
    RETVAL

bool
wxClipboard::Open()

bool
wxClipboard::SetData( data )
    wxDataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    RETVAL = THIS->SetData( data );
  OUTPUT:
    RETVAL

void
wxClipboard::UsePrimarySelection( primary = true )
    bool primary
