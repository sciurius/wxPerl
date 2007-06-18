/////////////////////////////////////////////////////////////////////////////
// Name:        ext/grid/cpp/editor.h
// Purpose:     wxPlGridCellEditor
// Author:      Mattia Barbon
// Modified by:
// Created:     28/05/2003
// RCS-ID:      $Id$
// Copyright:   (c) 2003-2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include "cpp/v_cback.h"
#include <wx/clntdata.h>
#include "cpp/helpers.h"

#define DEC_V_CBACK_VOID__INT_INT_WXGRID_pure( METHOD ) \
  void METHOD( int, int, wxGrid* )

#define DEF_V_CBACK_VOID__INT_INT_WXGRID_pure( CLASS, BASE, METHOD ) \
  void CLASS::METHOD( int param1, int param2, wxGrid* param3 )                \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,                 \
                                           G_SCALAR|G_DISCARD,                \
                                           "iiO", param1, param2, param3 );   \
    }                                                                         \
  }

#define DEC_V_CBACK_BOOL__INT_INT_WXGRID_pure( METHOD ) \
  bool METHOD( int, int, wxGrid* )

#define DEF_V_CBACK_BOOL__INT_INT_WXGRID_pure( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( int param1, int param2, wxGrid* param3 )                \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "iiO", param1, param2,   \
                                                     param3 );                \
        bool bret = SvTRUE( ret );                                            \
        SvREFCNT_dec( ret );                                                  \
        return bret;                                                          \
    }                                                                         \
    return false;                                                             \
  }

#define DEC_V_CBACK_BOOL__WXKEYEVENT( METHOD ) \
  bool METHOD( wxKeyEvent& event )

#define DEF_V_CBACK_BOOL__WXKEYEVENT( CLASS, BASE, METHOD ) \
  bool CLASS::METHOD( wxKeyEvent& param1 )                                    \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* evt = wxPli_object_2_sv( aTHX_ newSViv( 0 ), &param1 );           \
        SV* ret = wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,       \
                                                     G_SCALAR,                \
                                                     "S", evt );              \
        bool val = SvTRUE( ret );                                             \
        sv_setiv( SvRV( evt ), 0 );                                           \
        SvREFCNT_dec( evt );                                                  \
        SvREFCNT_dec( ret );                                                  \
        return val;                                                           \
    } else                                                                    \
        return BASE::METHOD( param1 );                                        \
  }

#define DEC_V_CBACK_VOID__WXKEYEVENT( METHOD ) \
  void METHOD( wxKeyEvent& event )

#define DEF_V_CBACK_VOID__WXKEYEVENT( CLASS, BASE, METHOD ) \
  void CLASS::METHOD( wxKeyEvent& param1 )                                    \
  {                                                                           \
    dTHX;                                                                     \
    if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, #METHOD ) )     \
    {                                                                         \
        SV* evt = wxPli_object_2_sv( aTHX_ newSViv( 0 ), &param1 );           \
        wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,                 \
                                           G_SCALAR|G_DISCARD,                \
                                           "S", evt );                        \
        sv_setiv( SvRV( evt ), 0 );                                           \
        SvREFCNT_dec( evt );                                                  \
    } else                                                                    \
        BASE::METHOD( param1 );                                               \
  }

class wxPlGridCellEditor : public wxGridCellEditor
{
public:
    wxPliVirtualCallback m_callback;
public:
    wxPlGridCellEditor( const char* package )
        : m_callback( "Wx::PlGridCellEditor" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), true );
    }

    void Create( wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler )
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "Create" ) )
        {
            wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                               G_DISCARD|G_SCALAR,
                                               "OiO", parent, id,
                                               evtHandler );
        }
    }

    void SetSize( const wxRect& rect )
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "SetSize" ) )
        {
            wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                               G_DISCARD|G_SCALAR,
                                               "o", new wxRect( rect ),
                                               "Wx::Rect" );
        } else
            wxGridCellEditor::SetSize( rect );
    }

    void Show( bool show, wxGridCellAttr* attr )
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "Show" ) )
        {
            ENTER;
            SAVETMPS;

            SV* attr_sv = wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                                 &attr, "Wx::GridCellAttr" );

            wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                               G_DISCARD|G_SCALAR,
                                               "bs", show, attr_sv );

            wxPli_detach_object( aTHX_ attr_sv );

            FREETMPS;
            LEAVE;
        } else
            wxGridCellEditor::Show( show, attr );
    }

    void PaintBackground( const wxRect& rect, wxGridCellAttr* attr )
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "PaintBackground" ) )
        {
            ENTER;
            SAVETMPS;

            SV* attr_sv = wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                                 &attr, "Wx::GridCellAttr" );

            wxPliVirtualCallback_CallCallback( aTHX_ &m_callback,
                                               G_DISCARD|G_SCALAR,
                                               "os", new wxRect( rect ),
                                               attr_sv );

            wxPli_detach_object( aTHX_ attr_sv );

            FREETMPS;
            LEAVE;
        } else
            wxGridCellEditor::PaintBackground( rect, attr );
    }

    virtual wxGridCellEditor* Clone() const
    {
        dTHX;

        if( wxPliVirtualCallback_FindCallback( aTHX_ &m_callback, "Clone" ) )
        {
            SV* ret = wxPliVirtualCallback_CallCallback
                ( aTHX_ &m_callback, G_SCALAR, NULL );
            wxGridCellEditor* clone =
                (wxGridCellEditor*)wxPli_sv_2_object( aTHX_ ret, "Wx::GridCellEditor" );
            SvREFCNT_dec( ret );
        
            return clone;
        }

        return 0;
    }

    virtual wxString GetValue() const { return wxEmptyString; }

    DEC_V_CBACK_VOID__INT_INT_WXGRID_pure( BeginEdit );
    DEC_V_CBACK_BOOL__INT_INT_WXGRID_pure( EndEdit );
    DEC_V_CBACK_VOID__VOID( Reset );
    DEC_V_CBACK_VOID__VOID( Destroy );
    DEC_V_CBACK_VOID__VOID( StartingClick );
    DEC_V_CBACK_BOOL__WXKEYEVENT( IsAcceptedKey );
    DEC_V_CBACK_VOID__WXKEYEVENT( StartingKey );
    DEC_V_CBACK_VOID__WXKEYEVENT( HandleReturn );
};

DEF_V_CBACK_VOID__INT_INT_WXGRID_pure( wxPlGridCellEditor, wxGridCellEditor, BeginEdit );
DEF_V_CBACK_BOOL__INT_INT_WXGRID_pure( wxPlGridCellEditor, wxGridCellEditor, EndEdit );
DEF_V_CBACK_VOID__VOID_pure( wxPlGridCellEditor, wxGridCellEditor, Reset );
DEF_V_CBACK_VOID__VOID( wxPlGridCellEditor, wxGridCellEditor, Destroy );
DEF_V_CBACK_VOID__VOID( wxPlGridCellEditor, wxGridCellEditor, StartingClick );
DEF_V_CBACK_BOOL__WXKEYEVENT( wxPlGridCellEditor, wxGridCellEditor, IsAcceptedKey );
DEF_V_CBACK_VOID__WXKEYEVENT( wxPlGridCellEditor, wxGridCellEditor, StartingKey );
DEF_V_CBACK_VOID__WXKEYEVENT( wxPlGridCellEditor, wxGridCellEditor, HandleReturn );

