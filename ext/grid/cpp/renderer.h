/////////////////////////////////////////////////////////////////////////////
// Name:        ext/grid/cpp/renderer.h
// Purpose:     wxPlGridCellRenderer
// Author:      Mattia Barbon
// Modified by:
// Created:     28/ 5/2003
// RCS-ID:      $Id: renderer.h,v 1.2 2003/05/29 20:00:05 mbarbon Exp $
// Copyright:   (c) 2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/v_cback.h"

class wxPlGridCellRenderer : public wxGridCellRenderer
{
public:
    wxPliVirtualCallback m_callback;
public:
    wxPlGridCellRenderer( const char* package )
        : m_callback( "Wx::PlGridCellRenderer" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    virtual void Draw( wxGrid& grid,
                       wxGridCellAttr& attr,
                       wxDC& dc,
                       const wxRect& rect,
                       int row, int col,
                       bool isSelected )
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "Draw" ) )
        {
            ENTER;
            SAVETMPS;

            SV* attr_sv = wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                                 &attr, "Wx::GridCellAttr" );
            SV* dc_sv = wxPli_object_2_sv( aTHX_ sv_newmortal(), &dc );
            SV* rect_sv = wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                                 (void*)&rect, "Wx::Rect" );

            wxPliVirtualCallback_CallCallback
                ( aTHX_ &m_callback, G_DISCARD|G_SCALAR, "Osssiib",
                  &grid, attr_sv, dc_sv, rect_sv, row, col, isSelected );

            wxPli_detach_object( aTHX_ attr_sv );
            wxPli_detach_object( aTHX_ dc_sv );
            wxPli_detach_object( aTHX_ rect_sv );

            FREETMPS;
            LEAVE;
        }
    }

    virtual wxSize GetBestSize( wxGrid& grid,
                                wxGridCellAttr& attr,
                                wxDC& dc,
                                int row, int col )
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "GetBestSize" ) )
        {
            ENTER;
            SAVETMPS;

            SV* attr_sv = wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                                 &attr, "Wx::GridCellAttr" );
            SV* dc_sv = wxPli_object_2_sv( aTHX_ sv_newmortal(), &dc );

            SV* ret = wxPliVirtualCallback_CallCallback
                ( aTHX_ &m_callback, G_SCALAR, "OoOii",
                  &grid, &attr, "Wx::GridCellAttr", &dc, row, col );
            wxSize size = *(wxSize*)wxPli_sv_2_object( aTHX_ ret, "Wx::Size" );
            SvREFCNT_dec( ret );

            wxPli_detach_object( aTHX_ attr_sv );
            wxPli_detach_object( aTHX_ dc_sv );

            FREETMPS;
            LEAVE;

            return size;
        }

        return wxDefaultSize;
    }

    virtual wxGridCellRenderer *Clone() const
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "Clone" ) )
        {
            SV* ret = wxPliVirtualCallback_CallCallback
                ( aTHX_ &m_callback, G_SCALAR );
            wxGridCellRenderer* clone =
                (wxGridCellRenderer*)wxPli_sv_2_object( aTHX_ ret, "Wx::GridCellRenderer" );
            SvREFCNT_dec( ret );
        
            return clone;
        }

        return 0;
    }
};

// local variables:
// mode: c++
// end:
