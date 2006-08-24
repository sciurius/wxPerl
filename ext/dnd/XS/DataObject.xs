#############################################################################
## Name:        ext/dnd/XS/DataObject.xs
## Purpose:     XS for Wx::*DataObject and Wx::DataFormat
## Author:      Mattia Barbon
## Modified by:
## Created:     12/08/2001
## RCS-ID:      $Id: DataObject.xs,v 1.23 2006/08/24 19:46:04 mbarbon Exp $
## Copyright:   (c) 2001-2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/dataobj.h>
#include "cpp/dataobject.h"

MODULE=Wx PACKAGE=Wx::DataFormat

#ifdef __WXGTK20__

wxDataFormat*
newNative( dummy, format = wxDF_INVALID )
    SV* dummy
    wxDataFormatId format
  CODE:
    RETVAL = new wxDataFormat( format );
  OUTPUT: RETVAL

#else

wxDataFormat*
newNative( dummy, format = wxDF_INVALID )
    SV* dummy
    NativeFormat format
  CODE:
    RETVAL = new wxDataFormat( format );
  OUTPUT: RETVAL

#endif

wxDataFormat*
newUser( dummy, id )
    SV* dummy
    wxChar* id
  CODE:
    RETVAL = new wxDataFormat( id );
  OUTPUT: RETVAL

static void
wxDataFormat::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

## // thread OK
void
wxDataFormat::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::DataFormat", THIS, ST(0) );
    delete THIS;

wxString
wxDataFormat::GetId()

void
wxDataFormat::SetId( id )
    wxString id

#if defined( __WXMSW__ )

NativeFormat
wxDataFormat::GetType()

void
wxDataFormat::SetType( type )
    NativeFormat type

#else

wxDataFormatId
wxDataFormat::GetType()

#if 0

void
wxDataFormat::SetType( type )
    wxDataFormatId type

#endif

#endif

MODULE=Wx PACKAGE=Wx::DataObject

static void
wxDataObject::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );

# // thread OK
void
DESTROY( THIS )
    wxDataObject* THIS
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ), THIS, ST(0) );
    if( THIS && wxPli_object_is_deleteable( aTHX_ ST(0) ) )
    {
        delete THIS;
    }

void
wxDataObject::Destroy()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ ST(0) ), THIS, ST(0) );
    delete THIS;

void
wxDataObject::GetAllFormats( dir = wxDataObjectBase::Get )
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
wxDataObject::GetDataHere( format, buf )
    wxDataFormat* format
    SV* buf
  CODE:
    size_t size = THIS->GetDataSize( *format );
    void* buffer = SvGROW( buf, size + 1 );

    SvCUR_set( buf, size );
    RETVAL = THIS->GetDataHere( *format, buffer );
  OUTPUT: RETVAL

size_t
wxDataObject::GetDataSize( format )
    wxDataFormat* format
  CODE:
    RETVAL = THIS->GetDataSize( *format );
  OUTPUT: RETVAL

size_t
wxDataObject::GetFormatCount( dir = wxDataObjectBase::Get )
    Direction dir

wxDataFormat*
wxDataObject::GetPreferredFormat( dir = wxDataObjectBase::Get )
    Direction dir
  CODE:
    RETVAL = new wxDataFormat( THIS->GetPreferredFormat( dir ) );
  OUTPUT: RETVAL

bool
wxDataObject::IsSupported( format, dir = wxDataObjectBase::Get )
    wxDataFormat* format
    Direction dir
  CODE:
    RETVAL = THIS->IsSupported( *format, dir );
  OUTPUT: RETVAL

bool
wxDataObject::SetData( format, buf )
    wxDataFormat* format
    SV* buf
  PREINIT:
    char* data;
    STRLEN len;
  CODE:
    data = SvPV( buf, len );
    RETVAL = THIS->SetData( *format, len, data );
  OUTPUT: RETVAL

MODULE=Wx PACKAGE=Wx::DataObjectSimple

wxDataObjectSimple*
wxDataObjectSimple::new( format = (wxDataFormat*)&wxFormatInvalid )
    wxDataFormat* format
  CODE:
    RETVAL = new wxDataObjectSimple( *format );
  OUTPUT: RETVAL

wxDataFormat*
wxDataObjectSimple::GetFormat()
  CODE:
    RETVAL = new wxDataFormat( THIS->GetFormat() );
  OUTPUT: RETVAL

void
wxDataObjectSimple::SetFormat( format )
    wxDataFormat* format
  CODE:
    THIS->SetFormat( *format );

MODULE=Wx PACKAGE=Wx::PlDataObjectSimple

SV*
wxPlDataObjectSimple::new( format = (wxDataFormat*)&wxFormatInvalid )
    wxDataFormat* format
  CODE:
    wxPlDataObjectSimple* THIS = new wxPlDataObjectSimple( CLASS, *format );
    RETVAL = newRV( SvRV( THIS->m_callback.GetSelf() ) );
    wxPli_thread_sv_register( aTHX_ "Wx::PlDataObjectSimple", THIS, RETVAL );
  OUTPUT: RETVAL

## // thread OK
void
wxPlDataObjectSimple::DESTROY()
  CODE:
    wxPli_thread_sv_unregister( aTHX_ "Wx::PlDataObjectSimple", THIS, ST(0) );
    if( THIS && wxPli_object_is_deleteable( aTHX_ ST(0) ) )
    {
        SV* self = THIS->m_callback.GetSelf();
        SvROK_off( self );
        SvRV( self ) = NULL;
        delete THIS;
    }

MODULE=Wx PACKAGE=Wx::DataObjectComposite

wxDataObjectComposite*
wxDataObjectComposite::new()

void
wxDataObjectComposite::Add( dataObject, preferred = false )
    wxDataObjectSimple* dataObject
    bool preferred
  CODE:
    // at this point the data object is owned!
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->Add( dataObject, preferred );

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

wxDataFormat*
wxDataObjectComposite::GetReceivedFormat()
  CODE:
    RETVAL = new wxDataFormat( THIS->GetReceivedFormat() );
  OUTPUT: RETVAL

#endif

MODULE=Wx PACKAGE=Wx::TextDataObject

wxTextDataObject*
wxTextDataObject::new( text = wxEmptyString )
    wxString text

size_t
wxTextDataObject::GetTextLength()

wxString
wxTextDataObject::GetText()

void
wxTextDataObject::SetText( text )
    wxString text

MODULE=Wx PACKAGE=Wx::BitmapDataObject

#if WXPERL_W_VERSION_GE( 2, 5, 1 ) || !defined(__WXMOTIF__)

wxBitmapDataObject*
wxBitmapDataObject::new( bitmap = (wxBitmap*)&wxNullBitmap )
    wxBitmap* bitmap
  CODE:
    RETVAL = new wxBitmapDataObject( *bitmap );
  OUTPUT: RETVAL

wxBitmap*
wxBitmapDataObject::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT: RETVAL

void
wxBitmapDataObject::SetBitmap( bitmap )
    wxBitmap* bitmap
  CODE:
    THIS->SetBitmap( *bitmap );

#endif

MODULE=Wx PACKAGE=Wx::FileDataObject

#if !defined(__WXMOTIF__)

wxFileDataObject*
wxFileDataObject::new()

void
wxFileDataObject::AddFile( file )
    wxString file

void
wxFileDataObject::GetFilenames()
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

wxURLDataObject*
wxURLDataObject::new()

wxString
wxURLDataObject::GetURL()

void
wxURLDataObject::SetURL( url )
    wxString url

#endif