#############################################################################
## Name:        Clipboard.xs
## Purpose:     XS for Wx::Clipboard
## Author:      Mattia Barbon
## Modified by:
## Created:     13/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/clipbrd.h>

MODULE=Wx PACKAGE=Wx::Clipboard

bool
Wx_Clipboard::AddData( data )
    Wx_DataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), FALSE );
    RETVAL = THIS->AddData( data );
  OUTPUT:
    RETVAL

void
Wx_Clipboard::Clear()

void
Wx_Clipboard::Close()

bool
Wx_Clipboard::Flush()

bool
Wx_Clipboard::GetData( data )
    Wx_DataObject* data
  CODE:
    RETVAL = THIS->GetData( *data );
  OUTPUT:
    RETVAL

bool
Wx_Clipboard::IsOpened()

bool
Wx_Clipboard::IsSupported( format )
    Wx_DataFormat* format
  CODE:
    RETVAL = THIS->IsSupported( *format );
  OUTPUT:
    RETVAL

bool
Wx_Clipboard::Open()

bool
Wx_Clipboard::SetData( data )
    Wx_DataObject* data
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), FALSE );
    RETVAL = THIS->SetData( data );
  OUTPUT:
    RETVAL

void
Wx_Clipboard::UsePrimarySelection( primary = TRUE )
    bool primary
