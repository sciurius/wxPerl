/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/sizer.h
// Purpose:     c++ wrapper for wxSizers
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: sizer.h,v 1.16 2006/09/07 20:45:27 mbarbon Exp $
// Copyright:   (c) 2000-2006 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#if !WXPERL_W_VERSION_GE( 2, 5, 1 ) || !WXWIN_COMPATIBILITY_2_4
#if !WXPERL_W_VERSION_GE( 2, 5, 4 )
#define wxBookCtrlBase wxBookCtrl
#endif
#include "cpp/wxsizer.h"
#endif

class wxPlSizer:public wxSizer
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlSizer );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlSizer( const char* package );

    DEC_V_CBACK_VOID__VOID( RecalcSizes );
    virtual wxSize CalcMin();
};

inline wxPlSizer::wxPlSizer( const char* package )
    :m_callback( "Wx::PlSizer" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), true );
}

DEF_V_CBACK_VOID__VOID_pure( wxPlSizer, wxSizer, RecalcSizes )

wxSize wxPlSizer::CalcMin()
{
    static wxSize ret( 0, 0 );
    dTHX;

    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "CalcMin" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                                     G_SCALAR, NULL );
        wxSize* val = (wxSize*)wxPli_sv_2_object( aTHX_ ret, "Wx::Size" );
        SvREFCNT_dec( ret );
        return *val;
    }

    return ret;
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlSizer, wxSizer );

// Local variables: //
// mode: c++ //
// End: //
