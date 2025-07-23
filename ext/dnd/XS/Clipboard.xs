#############################################################################
## Name:        ext/dnd/XS/Clipboard.xs
## Purpose:     XS for Wx::Clipboard
## Author:      Mattia Barbon
## Modified by:
## Created:     13/08/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2002, 2004, 2006-2007 Mattia Barbon
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
    SvREFCNT_inc( SvRV( ST(1) ) ); // at this point the scalar must not go away
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
    SvREFCNT_inc( SvRV( ST(1) ) ); // at this point the scalar must not go away
    RETVAL = THIS->SetData( data );
  OUTPUT:
    RETVAL

void
wxClipboard::UsePrimarySelection( primary = true )
    bool primary

bool
wxClipboard::IsUsingPrimarySelection()
