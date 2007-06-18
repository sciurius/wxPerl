/////////////////////////////////////////////////////////////////////////////
// Name:        ext/dnd/cpp/dataobject.h
// Purpose:     c++ wrapper for wxPl*DataObject and wxPlDataObjectSimple
// Author:      Mattia Barbon
// Modified by:
// Created:     13/08/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001-2002, 2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/dataobj.h>
#include "cpp/v_cback.h"

#define DEC_V_CBACK_SIZET__VOID_const( METHOD ) \
  size_t METHOD() const

#define DEC_V_CBACK_BOOL__VOIDP_const( METHOD ) \
  bool METHOD( void* ) const

#define DEC_V_CBACK_BOOL__SIZET_CVOIDP( METHOD ) \
  bool METHOD( size_t, const void* )

class wxPlDataObjectSimple:public wxDataObjectSimple
{
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlDataObjectSimple( const char* package, const wxDataFormat& format )
        :wxDataObjectSimple( format ),
         m_callback( "Wx::PlDataObjectSimple" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ) );
    }
private:
    // SGI CC warns here, but it is harmless
    DEC_V_CBACK_SIZET__VOID_const( GetDataSize );
    DEC_V_CBACK_BOOL__VOIDP_const( GetDataHere );
    DEC_V_CBACK_BOOL__SIZET_CVOIDP( SetData );
};

size_t wxPlDataObjectSimple::GetDataSize() const
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "GetDataSize" ) )
    {
        wxAutoSV ret( aTHX_ wxPliVirtualCallback_CallCallback
                                ( aTHX_ &m_callback, G_SCALAR, NULL ) );
        return SvUV( ret )
// wxGTK bug!
#if WXPERL_W_VERSION_GE( 2, 6, 2 ) && defined(__WXGTK__)
            + 1
#endif
            ;
    } else 
        return wxDataObjectSimple::GetDataSize(); 
}

bool wxPlDataObjectSimple::GetDataHere( void* param1 ) const
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "GetDataHere" ) )
    {
        wxAutoSV ret( aTHX_ wxPliVirtualCallback_CallCallback
                                ( aTHX_ &m_callback, G_SCALAR, NULL ) );
        if( !SvOK( ret ) )
            return false;
        STRLEN len;
        char* val = SvPV( ret, len );
        memcpy( param1, val, len );
        return true;
    } else
        return wxDataObjectSimple::GetDataHere( param1 );
}

bool wxPlDataObjectSimple::SetData( size_t param1, const void* param2 )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "SetData" ) )
    {
        wxAutoSV n( aTHX_ newSVpvn( CHAR_P (const char*)param2, param1 ) );
        wxAutoSV ret( aTHX_ wxPliVirtualCallback_CallCallback
                                ( aTHX_ &m_callback, G_SCALAR, "s", (SV*)n ));
        return SvTRUE( ret );
    } else
        return wxDataObjectSimple::SetData( param1, param2 );
}
