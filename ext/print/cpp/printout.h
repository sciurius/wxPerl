/////////////////////////////////////////////////////////////////////////////
// Name:        ext/print/cpp/printout.h
// Purpose:     c++ wrapper for wxPrintout
// Author:      Mattia Barbon
// Modified by:
// Created:     02/06/2001
// RCS-ID:      $Id: printout.h,v 1.9 2004/12/21 21:12:56 mbarbon Exp $
// Copyright:   (c) 2001-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/v_cback.h"

class wxPlPrintout:public wxPrintout
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlPrintout );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlPrintout( const char* package, const wxString& title );

    void GetPageInfo( int* minPage, int* maxPage, int* pageFrom, int* pageTo );

    DEC_V_CBACK_BOOL__INT( HasPage );
    DEC_V_CBACK_BOOL__INT_INT( OnBeginDocument );
    DEC_V_CBACK_VOID__VOID( OnEndDocument );
    DEC_V_CBACK_VOID__VOID( OnBeginPrinting );
    DEC_V_CBACK_VOID__VOID( OnEndPrinting );
    DEC_V_CBACK_VOID__VOID( OnPreparePrinting );
    DEC_V_CBACK_BOOL__INT( OnPrintPage );
};

inline wxPlPrintout::wxPlPrintout( const char* package, const wxString& title )
    :wxPrintout( title ),
     m_callback( "Wx::PlPrintout" )
{
    m_callback.SetSelf( wxPli_make_object( this, package ), true );
}

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlPrintout, wxPrintout );

DEF_V_CBACK_BOOL__INT( wxPlPrintout, wxPrintout, HasPage );
DEF_V_CBACK_BOOL__INT_INT( wxPlPrintout, wxPrintout, OnBeginDocument );
DEF_V_CBACK_VOID__VOID( wxPlPrintout, wxPrintout, OnEndDocument );
DEF_V_CBACK_VOID__VOID( wxPlPrintout, wxPrintout, OnBeginPrinting );
DEF_V_CBACK_VOID__VOID( wxPlPrintout, wxPrintout, OnEndPrinting );
DEF_V_CBACK_VOID__VOID( wxPlPrintout, wxPrintout, OnPreparePrinting );
DEF_V_CBACK_BOOL__INT_pure( wxPlPrintout, wxPrintout, OnPrintPage );

void wxPlPrintout::GetPageInfo( int* minPage, int* maxPage,
                                int* pageFrom, int* pageTo )
{
    dTHX;
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "GetPageInfo" ) )
    {
        dSP;

        ENTER;
        SAVETMPS;

        PUSHMARK( SP );
        XPUSHs( m_callback.GetSelf() );
        PUTBACK;

        SV* method = sv_2mortal( newRV_inc( (SV*) m_callback.GetMethod() ) );
        int items = call_sv( method, G_ARRAY );

        if( items != 4 )
        {
            croak( "wxPlPrintout::GetPageInfo, expected 4 values, got %i",
                   items );
        }

        SPAGAIN;
        SV* tmp;
        // pop in reverse order...
        tmp = POPs; *pageTo = SvIV( tmp );
        tmp = POPs; *pageFrom = SvIV( tmp );
        tmp = POPs; *maxPage = SvIV( tmp );
        tmp = POPs; *minPage = SvIV( tmp );
        PUTBACK;

        FREETMPS;
        LEAVE;
    } else
        wxPrintout::GetPageInfo( minPage, maxPage, pageFrom, pageTo );
}
