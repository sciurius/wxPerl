/////////////////////////////////////////////////////////////////////////////
// Name:        e_cback.cpp
// Purpose:     implementation for e_cback.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

inline wxPliEventCallback::wxPliEventCallback( SV* method, SV* self ) 
{
    m_method = method;
    SvREFCNT_inc( m_method );
    m_self = self;
    SvREFCNT_inc( m_self );
}

wxPliEventCallback::~wxPliEventCallback() 
{
    SvREFCNT_dec( m_method );
    SvREFCNT_dec( m_self );
}

void wxPliEventCallback::Handler( wxEvent& event ) 
{
    wxPliEventCallback* This = (wxPliEventCallback*) event.m_callbackUserData;
    //  wxEvtHandler* That = (wxEvtHandler*)this;

    dSP;

    ENTER;
    SAVETMPS;
  
    wxString cName = event.GetClassInfo()->GetClassName();
    SV* e = sv_newmortal();

    sv_setref_pv( e, CHAR_P wxPli_cpp_class_2_perl( cName.c_str() ), &event );

    PUSHMARK( SP );
    XPUSHs( This->m_self );
    XPUSHs( e );
    PUTBACK;

    call_sv( This->m_method, G_DISCARD );
    //wxTrap();
    sv_setiv( SvRV( e ), 0 );

    FREETMPS;
    LEAVE;
}

// Local variables: //
// mode: c++ //
// End: //
