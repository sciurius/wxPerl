/////////////////////////////////////////////////////////////////////////////
// Name:        droptarget.h
// Purpose:     c++ wrapper for wxPli*DropTarget
// Author:      Mattia Barbon
// Modified by:
// Created:     16/ 8/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/dnd.h>
#include "cpp/v_cback.h"

class wxPliDropTarget:public wxDropTarget
{
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliDropTarget( const char* package, wxDataObject* data = 0 )
        :wxDropTarget( data ),
         m_callback( "Wx::DropTarget" )
    {
        // this is necessary because the SV returned to
        // the perl program _is not_ this one!
        // so _this_ SV must not delete the object,
        // this is responsibility of the program's one!
        SV* sv = wxPli_non_object_2_sv( sv_newmortal(), this, package );
        wxPli_object_set_deleteable( sv, FALSE );
        m_callback.SetSelf( sv );
    }

    DEC_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( OnData );
    DEC_V_CBACK_BOOL__WXCOORD_WXCOORD( OnDrop );
    DEC_V_CBACK_VOID__VOID( OnLeave );
    DEC_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( OnEnter );
    DEC_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( OnDragOver );
};

DEF_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT_pure( wxPliDropTarget, wxDropTarget, OnData );
DEF_V_CBACK_BOOL__WXCOORD_WXCOORD( wxPliDropTarget, wxDropTarget, OnDrop );
DEF_V_CBACK_VOID__VOID( wxPliDropTarget, wxDropTarget, OnLeave );
DEF_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( wxPliDropTarget, wxDropTarget, OnEnter );
DEF_V_CBACK_WXDRAGRESULT__WXCOORD_WXCOORD_WXDRAGRESULT( wxPliDropTarget, wxDropTarget, OnDragOver );

class wxPliTextDropTarget:public wxTextDropTarget
{
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliTextDropTarget( const char* package )
        :wxTextDropTarget(),
         m_callback( "Wx::TextDropTarget" )
    {
        SV* sv = wxPli_non_object_2_sv( sv_newmortal(), this, package );
        wxPli_object_set_deleteable( sv, FALSE );
        m_callback.SetSelf( sv );
    }

    DEC_V_CBACK_BOOL__WXCOORD_WXCOORD_WXSTRING( OnDropText );
};

DEF_V_CBACK_BOOL__WXCOORD_WXCOORD_WXSTRING_pure( wxPliTextDropTarget, wxTextDropTarget, OnDropText );

class wxPliFileDropTarget:public wxFileDropTarget
{
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliFileDropTarget( const char* package )
        :wxFileDropTarget(),
         m_callback( "Wx::FileDropTarget" )
    {
        SV* sv = wxPli_non_object_2_sv( sv_newmortal(), this, package );
        wxPli_object_set_deleteable( sv, FALSE );
        m_callback.SetSelf( sv );
    }

    DEC_V_CBACK_BOOL__WXCOORD_WXCOORD_WXARRAYSTRING( OnDropFiles );
};

DEF_V_CBACK_BOOL__WXCOORD_WXCOORD_WXARRAYSTRING_pure( wxPliFileDropTarget, wxFileDropTarget, OnDropFiles );

// Local variables: //
// mode: c++ //
// End: //

