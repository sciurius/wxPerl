/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/event.h
// Purpose:     C++ helpers for user-defined events
// Author:      Mattia Barbon
// Modified by:
// Created:     30/03/2002
// RCS-ID:      $Id: event.h,v 1.10 2006/11/04 22:53:26 mbarbon Exp $
// Copyright:   (c) 2002-2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/event.h>

#include "cpp/v_cback.h"

class wxPlEvent:public wxEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlEvent );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlEvent( const char* package, int id, wxEventType eventType )
        : wxEvent( id, eventType ),
          m_callback( "Wx::PlEvent" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    virtual wxEvent* Clone() const;
};

wxEvent* wxPlEvent::Clone() const
{
    dTHX;
    wxPlEvent* self = (wxPlEvent*)this;

    if( wxPliVirtualCallback_FindCallback( aTHX_ &self->m_callback, "Clone" ) )
    {
        wxAutoSV ret( aTHX_ wxPliVirtualCallback_CallCallback
            ( aTHX_ &self->m_callback, G_SCALAR, NULL ) );
        wxPlEvent* clone =
            (wxPlEvent*)wxPli_sv_2_object( aTHX_ ret, "Wx::PlEvent" );
        
        return clone;
    }

    return 0;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlEvent, wxEvent );

class wxPlCommandEvent:public wxCommandEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlCommandEvent );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlCommandEvent( const char* package, int id, wxEventType eventType )
        : wxCommandEvent( id, eventType ),
          m_callback( "Wx::PlCommandEvent" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    virtual wxEvent* Clone() const;
};

wxEvent* wxPlCommandEvent::Clone() const
{
    dTHX;
    wxPlCommandEvent* self = (wxPlCommandEvent*)this;

    if( wxPliVirtualCallback_FindCallback( aTHX_ &self->m_callback, "Clone" ) )
    {
        wxAutoSV ret( aTHX_ wxPliVirtualCallback_CallCallback
            ( aTHX_ &self->m_callback, G_SCALAR, NULL ) );
        wxPlCommandEvent* clone = (wxPlCommandEvent*)
            wxPli_sv_2_object( aTHX_ ret, "Wx::PlCommandEvent" );
        
        return clone;
    }

    return 0;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlCommandEvent, wxCommandEvent );

class wxPlThreadEvent:public wxEvent
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlThreadEvent );
public:
    wxPlThreadEvent() : m_data( 0 ) {}
    wxPlThreadEvent( const char* package, int id, wxEventType eventType,
                     SV* data )
        : wxEvent( id, eventType ),
          m_data( data )
    {
        dTHX;
        SvREFCNT_inc( m_data );
    }

    wxPlThreadEvent( const wxPlThreadEvent& e )
        : wxEvent( e ),
          m_data( e.GetData() )
        { dTHX; SvREFCNT_inc( m_data ); }

    ~wxPlThreadEvent() { dTHX; SvREFCNT_dec( m_data ); }

    void SetData( SV* data )
    {
        dTHX;
        SvREFCNT_dec( m_data );
        m_data = data;
        SvREFCNT_inc( m_data );
    }

    SV* GetData() const { return m_data; }

    virtual wxEvent* Clone() const;
private:
    SV* m_data;
};

wxEvent* wxPlThreadEvent::Clone() const
{
    return new wxPlThreadEvent( *this );
}

wxPliSelfRef* wxPliGetSelfForwxPlThreadEvent( wxObject* object ) { return 0; }
// XXX HACK!
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
wxPliClassInfo wxPlThreadEvent::ms_classInfo(
    (wxChar*)wxT( "wxPlPlThreadEvent"), &wxEvent::ms_classInfo,
    NULL, (int)sizeof(wxPlThreadEvent),
    (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPlThreadEvent );
#else
wxPliClassInfo wxPlThreadEvent::sm_classwxPlThreadEvent(
    (wxChar*)wxT( "wxPlPlThreadEvent"), (wxChar*)wxT("wxEvent"),
    (wxChar*)NULL, (int)sizeof(wxPlThreadEvent),
    (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPlThreadEvent );
#endif

// local variables: //
// mode: c++ //
// end: //
