#############################################################################
## Name:        DataObject.xs
## Purpose:     XS for Wx::*DataObject and Wx::DataFormat
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 8/2001
## RCS-ID:      
## Copyright:   (c) 2001-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dataobj.h>
#include "cpp/dataobject.h"

MODULE=Wx PACKAGE=Wx::DataFormat

Wx_DataFormat*
Wx_DataFormat::newNative( format = wxDF_INVALID )
    NativeFormat format
  CODE:
    THIS = 0; // fool SGI CC warnings
    RETVAL = new wxDataFormat( format );
  OUTPUT:
    RETVAL

Wx_DataFormat*
Wx_DataFormat::newUser( id )
    wxChar* id
  CODE:
    THIS = 0; // fool SGI CC warnings
    RETVAL = new wxDataFormat( id );
  OUTPUT:
    RETVAL

## XXX threads
void
Wx_DataFormat::DESTROY()

wxString
Wx_DataFormat::GetId()

void
Wx_DataFormat::SetId( id )
    wxString id

#if defined( __WXMSW__ )

NativeFormat
Wx_DataFormat::GetType()

void
Wx_DataFormat::SetType( type )
    NativeFormat type

#else

wxDataFormatId
Wx_DataFormat::GetType()

void
Wx_DataFormat::SetType( type )
    wxDataFormatId type

#endif

MODULE=Wx PACKAGE=Wx::DataObject

## XXX threads
void
DESTROY( THIS )
    Wx_DataObject* THIS
  CODE:
    if( wxPli_object_is_deleteable( aTHX_ ST(0) ) )
        delete THIS;

void
Wx_DataObject::Destroy()
  CODE:
    delete THIS;

void
Wx_DataObject::GetAllFormats( dir = wxDataObjectBase::Get )
    Direction dir
  PPCODE:
    size_t formats = THIS->GetFormatCount( dir );
    size_t i, wanted = formats;
    wxDataFormat* formats_d = new wxDataFormat[ formats ];

    THIS->GetAllFormats( formats_d, dir );
    if( GIMME_V == G_SCALAR )
        wanted = 1;
    EXTEND( SP, (IV)wanted );
    for( i = 0; i < wanted; ++i )
    {
        PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                new wxDataFormat( formats_d[i] ), "Wx::DataFormat" ) );
    }
    delete [] formats_d;

bool
Wx_DataObject::GetDataHere( format, buf )
    Wx_DataFormat* format
    SV* buf
  CODE:
    size_t size = THIS->GetDataSize( *format );
    void* buffer = SvGROW( buf, size + 1 );

    SvCUR_set( buf, size );
    RETVAL = THIS->GetDataHere( *format, buffer );
  OUTPUT:
    RETVAL

size_t
Wx_DataObject::GetDataSize( format )
    Wx_DataFormat* format
  CODE:
    RETVAL = THIS->GetDataSize( *format );
  OUTPUT:
    RETVAL

size_t
Wx_DataObject::GetFormatCount( dir = wxDataObjectBase::Get )
    Direction dir

Wx_DataFormat*
Wx_DataObject::GetPreferredFormat( dir = wxDataObjectBase::Get )
    Direction dir
  CODE:
    RETVAL = new wxDataFormat( THIS->GetPreferredFormat( dir ) );
  OUTPUT:
    RETVAL

bool
Wx_DataObject::IsSupported( format, dir = wxDataObjectBase::Get )
    Wx_DataFormat* format
    Direction dir
  CODE:
    RETVAL = THIS->IsSupported( *format, dir );
  OUTPUT:
    RETVAL

bool
Wx_DataObject::SetData( format, buf )
    Wx_DataFormat* format
    SV* buf
  PREINIT:
    char* data;
    STRLEN len;
  CODE:
    data = SvPV( buf, len );
    RETVAL = THIS->SetData( *format, len, data );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::DataObjectSimple

Wx_DataObjectSimple*
Wx_DataObjectSimple::new( format = (wxDataFormat*)&wxFormatInvalid )
    Wx_DataFormat* format
  CODE:
    RETVAL = new wxDataObjectSimple( *format );
  OUTPUT:
    RETVAL

Wx_DataFormat*
Wx_DataObjectSimple::GetFormat()
  CODE:
    RETVAL = new wxDataFormat( THIS->GetFormat() );
  OUTPUT:
    RETVAL

void
Wx_DataObjectSimple::SetFormat( format )
    Wx_DataFormat* format
  CODE:
    THIS->SetFormat( *format );

MODULE=Wx PACKAGE=Wx::PlDataObjectSimple

SV*
Wx_PlDataObjectSimple::new( format = (wxDataFormat*)&wxFormatInvalid )
    Wx_DataFormat* format
  CODE:
    wxPlDataObjectSimple* THIS = new wxPlDataObjectSimple( CLASS, *format );
    RETVAL = THIS->m_callback.GetSelf();
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::DataObjectComposite

Wx_DataObjectComposite*
Wx_DataObjectComposite::new()

void
Wx_DataObjectComposite::Add( dataObject, preferred = FALSE )
    Wx_DataObjectSimple* dataObject
    bool preferred
  CODE:
    // at this point the data object is owned!
    wxPli_object_set_deleteable( aTHX_ ST(1), FALSE );
    THIS->Add( dataObject, preferred );

MODULE=Wx PACKAGE=Wx::TextDataObject

Wx_TextDataObject*
Wx_TextDataObject::new( text = wxEmptyString )
    wxString text

size_t
Wx_TextDataObject::GetTextLength()

wxString
Wx_TextDataObject::GetText()

void
Wx_TextDataObject::SetText( text )
    wxString text

MODULE=Wx PACKAGE=Wx::BitmapDataObject

Wx_BitmapDataObject*
Wx_BitmapDataObject::new( bitmap = (wxBitmap*)&wxNullBitmap )
    Wx_Bitmap* bitmap
  CODE:
    RETVAL = new wxBitmapDataObject( *bitmap );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_BitmapDataObject::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

void
Wx_BitmapDataObject::SetBitmap( bitmap )
    Wx_Bitmap* bitmap
  CODE:
    THIS->SetBitmap( *bitmap );

MODULE=Wx PACKAGE=Wx::FileDataObject

Wx_FileDataObject*
Wx_FileDataObject::new()

void
Wx_FileDataObject::AddFile( file )
    wxString file

void
Wx_FileDataObject::GetFilenames()
  PREINIT:
    int i, max;
  PPCODE:
    const wxArrayString& filenames = THIS->GetFilenames();
    max = filenames.GetCount();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i ) {
#if wxUSE_UNICODE
      SV* tmp = sv_2mortal( newSVpv( filenames[i].mb_str(wxConvUTF8), 0 ) );
      SvUTF8_on( tmp );
      PUSHs( tmp );
#else
      PUSHs( sv_2mortal( newSVpv( CHAR_P filenames[i].c_str(), 0 ) ) );
#endif
    }

MODULE=Wx PACKAGE=Wx::URLDataObject

#if WXPERL_W_VERSION_GE( 2, 3, 2 )

Wx_URLDataObject*
Wx_URLDataObject::new()

wxString
Wx_URLDataObject::GetURL()

void
Wx_URLDataObject::SetURL( url )
    wxString url

#endif
