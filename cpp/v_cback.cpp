/////////////////////////////////////////////////////////////////////////////
// Name:        v_cback.cpp
// Purpose:     implementation for v_cback.h
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

bool wxPliVirtualCallback::FindCallback( pTHX_ const char* name ) const
{
    // it would be better to declare m_method & m_stash 'mutable'
    // but of course some C++ compiler don't support it...
    SV** pm_method = (SV**)&m_method;
    HV** pm_stash  = (HV**)&m_stash;

    HV* pkg = 0;

    *pm_method = 0;

    pkg = SvSTASH( SvRV( m_self ) );

    void* p_method = 0;

    if( pkg ) 
    {
        GV* gv = gv_fetchmethod( pkg, CHAR_P name );
        if( gv && isGV( gv ) )
            // mortal, since CallCallback is called before we return to perl
            *pm_method = sv_2mortal( newRV_inc( (SV*) ( p_method = GvCV( gv ) ) ) );
    }

    if( !m_method )
        return false;

    if( !m_stash )
        *pm_stash = gv_stashpv( CHAR_P m_package, FALSE );
  
    if( !m_stash )
        return true;

    void* p_pmethod = 0;

    GV* gv = gv_fetchmethod( m_stash, CHAR_P name );
    if( gv && isGV( gv ) )
        p_pmethod = GvCV( gv );
  
    return p_method != p_pmethod;
}

SV* wxPliVirtualCallback::CallCallback( pTHX_ I32 flags, const char* argtypes,
                                        va_list& arglist ) const
{
    if( !m_method )
        return 0;
  
    dSP;

    ENTER;
    SAVETMPS;

    PUSHMARK( SP );
    XPUSHs( m_self );
    wxPli_push_args( aTHX_ &SP, argtypes, arglist );
    PUTBACK;

    call_sv( m_method, flags );

    SV* retval;

    if( ( flags & G_DISCARD ) == 0 ) {
        SPAGAIN;

        retval = POPs;
        SvREFCNT_inc( retval );

        PUTBACK;
    } else
        retval = 0;

    FREETMPS;
    LEAVE;

    return retval;
}

bool wxPliVirtualCallback_FindCallback( pTHX_ const wxPliVirtualCallback* cb,
                                        const char* name )
{
    return cb->FindCallback( aTHX_ name );
}

SV* wxPliVirtualCallback_CallCallback( pTHX_ const wxPliVirtualCallback* cb,
                                       I32 flags,
                                       const char* argtypes, ... )
{
    va_list arglist;
    va_start( arglist, argtypes );

    return cb->CallCallback( aTHX_ flags, argtypes, arglist );
    
    va_end( arglist );
}

// Local variables: //
// mode: c++ //
// End: //
