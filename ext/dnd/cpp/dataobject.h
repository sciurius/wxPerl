/////////////////////////////////////////////////////////////////////////////
// Name:        dataobject.h
// Purpose:     c++ wrapper for wxPl*DataObject and wxPlDataObjectSimple
// Author:      Mattia Barbon
// Modified by:
// Created:     13/ 8/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/dataobj.h>
#include "cpp/v_cback.h"

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
    DEC_V_CBACK_SIZET__VOID__CONST( GetDataSize );
    DEC_V_CBACK_BOOL__VOIDP__CONST( GetDataHere );
    DEC_V_CBACK_BOOL__SIZET_CVOIDP( SetData );
};

DEF_V_CBACK_SIZET__VOID__CONST( wxPlDataObjectSimple, wxDataObjectSimple, GetDataSize );
DEF_V_CBACK_BOOL__VOIDP__CONST( wxPlDataObjectSimple, wxDataObjectSimple, GetDataHere );
DEF_V_CBACK_BOOL__SIZET_CVOIDP( wxPlDataObjectSimple, wxDataObjectSimple, SetData );

// Local variables: //
// mode: c++ //
// End: //
