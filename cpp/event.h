/////////////////////////////////////////////////////////////////////////////
// Name:        event.h
// Purpose:     C++ helpers for user-defined events
// Author:      Mattia Barbon
// Modified by:
// Created:     30/ 3/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
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
#if WXPERL_W_VERSION_GE( 2, 3, 0 )
        : wxEvent( id, eventType ),
#else
        : wxEvent( id ),
#endif
          m_callback( "Wx::PlEvent" )
    {
#if !WXPERL_W_VERSION_GE( 2, 3, 0 )
        m_eventType = eventType;
#endif
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    virtual wxEvent* Clone() const;
};

wxEvent* wxPlEvent::Clone() const
{
    wxPlEvent* self = (wxPlEvent*)this;

    if( wxPliVirtualCallback_FindCallback( &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &self->m_callback, G_SCALAR );
        wxPlEvent* clone =
            (wxPlEvent*)wxPli_sv_2_object( ret, "Wx::PlEvent" );
        SvREFCNT_dec( ret );
        
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
    wxPlCommandEvent* self = (wxPlCommandEvent*)this;

    if( wxPliVirtualCallback_FindCallback( &self->m_callback, "Clone" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback
            ( &self->m_callback, G_SCALAR );
        wxPlCommandEvent* clone =
            (wxPlCommandEvent*)wxPli_sv_2_object( ret, "Wx::PlCommandEvent" );
        SvREFCNT_dec( ret );
        
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
#if WXPERL_W_VERSION_GE( 2, 3, 0 )
        : wxEvent( id, eventType ),
#else
        : wxEvent( id ),
#endif
          m_data( data )
    {
#if !WXPERL_W_VERSION_GE( 2, 3, 0 )
        m_eventType = eventType;
#endif
        SvREFCNT_inc( m_data );
    }

    wxPlThreadEvent( const wxPlThreadEvent& e )
        : wxEvent( e ),
          m_data( e.GetData() )
        { SvREFCNT_inc( m_data ); }

    ~wxPlThreadEvent() { SvREFCNT_dec( m_data ); }

    void SetData( SV* data )
    {
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
wxPliClassInfo wxPlThreadEvent::sm_classwxPlThreadEvent(
    (wxChar*)wxT( "wxPlPlThreadEvent"), (wxChar*)wxT("wxEvent"),
    (wxChar*)NULL, (int)sizeof(wxPlThreadEvent),
    (wxPliGetCallbackObjectFn) wxPliGetSelfForwxPlThreadEvent );

// local variables: //
// mode: c++ //
// end: //
