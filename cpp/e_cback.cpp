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

inline _wxEventCallback::_wxEventCallback( SV* method, SV* self ) 
{
    m_method = method;
    SvREFCNT_inc( m_method );
    m_self = self;
    SvREFCNT_inc( m_self );
}

_wxEventCallback::~_wxEventCallback() 
{
    SvREFCNT_dec( m_method );
    SvREFCNT_dec( m_self );
}

void _wxEventCallback::Handler( wxEvent& event ) 
{
    _wxEventCallback* This = (_wxEventCallback*) event.m_callbackUserData;
    //  wxEvtHandler* That = (wxEvtHandler*)this;

    dSP;

    ENTER;
    SAVETMPS;
  
    wxString cName = event.GetClassInfo()->GetClassName();
    SV* e = sv_newmortal();

    sv_setref_pv( e, CHAR_P _cpp_class_2_perl( cName.c_str() ), &event );

    PUSHMARK( SP );
    XPUSHs( This->m_self );
    XPUSHs( e );
    PUTBACK;

    call_sv( This->m_method, G_DISCARD );

    FREETMPS;
    LEAVE;
}

// Local variables: //
// mode: c++ //
// End: //
