/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/e_cback.cpp
// Purpose:     implementation for e_cback.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: e_cback.cpp,v 1.15 2006/08/11 19:38:44 mbarbon Exp $
// Copyright:   (c) 2000-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

wxPliEventCallback::wxPliEventCallback( SV* method, SV* self ) 
{
    dTHX;
    m_method = method;
    SvREFCNT_inc( m_method );
    m_self = self;
    SvREFCNT_inc( m_self );
}

wxPliEventCallback::~wxPliEventCallback() 
{
    dTHX;
    SvREFCNT_dec( m_method );
    SvREFCNT_dec( m_self );
}

class wxPliGuard {
public:
    wxPliGuard()
    {
        m_sv = NULL;
    }

    ~wxPliGuard()
    {
        if( m_sv )
        {
            dTHX;

            wxPli_thread_sv_unregister( aTHX_ wxPli_get_class( aTHX_ m_sv ),
                                        (void*)SvIV( m_sv ), m_sv );
            sv_setiv( m_sv, 0 );
        }
    }

    void SetSV( SV* sv ) { m_sv = sv; }
private:
    SV* m_sv;
};

void wxPliEventCallback::Handler( wxEvent& event ) 
{
    wxPliEventCallback* This = (wxPliEventCallback*) event.m_callbackUserData;

    dTHX;
    dSP;

    ENTER;
    SAVETMPS;

    {
    // similar to wxPli_object_2_sv
    wxPliGuard guard;
    SV* e = 0;
    SV* rv = 0;
    wxClassInfo *ci = event.GetClassInfo();
    const wxChar* classname = ci->GetClassName();

#if wxUSE_UNICODE
    if( wcsncmp( classname, wxT("wxPl"), 4 ) == 0 ) 
#else
    if( strnEQ( classname, "wxPl", 4 ) ) 
#endif
    {
        wxPliClassInfo* cci = (wxPliClassInfo*)ci;
        wxPliSelfRef* sr = cci->m_func( &event );

        if( sr )
            e = sr->m_self;
    }

    if( !e )
    {
        char buffer[WXPL_BUF_SIZE];
        const char* CLASS = wxPli_cpp_class_2_perl( classname, buffer );

        e = sv_newmortal();
        sv_setref_pv( e, CHAR_P CLASS, &event );
        rv = SvRV( e );
        // corner case: prevent destruction if referrer is
        // destroyed
        SvREFCNT_inc( rv );
        sv_2mortal( rv );
        guard.SetSV( rv );
        wxPli_thread_sv_register( aTHX_ CLASS, &event, e );
    }

    PUSHMARK( SP );
    XPUSHs( This->m_self );
    XPUSHs( e );
    PUTBACK;

    call_sv( This->m_method, G_DISCARD|G_EVAL );
    }

    SPAGAIN;

    if( SvTRUE( ERRSV ) )
    {
        croak( Nullch );
    }

    PUTBACK;
    FREETMPS;
    LEAVE;
}

// Local variables: //
// mode: c++ //
// End: //
