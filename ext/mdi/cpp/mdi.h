/////////////////////////////////////////////////////////////////////////////
// Name:        mdi.h
// Purpose:     c++ wrapper for wxMDI*
// Author:      Mattia Barbon
// Modified by:
// Created:      6/ 9/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_MDI_H
#define _WXPERL_MDI_H

#include <wx/mdi.h>
#include "cpp/v_cback.h"

class wxPliMDIParentFrame:public wxMDIParentFrame
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliMDIParentFrame );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR( wxPliMDIParentFrame, "Wx::MDIParentFrame", TRUE );
    
    // void GetClientSize( int* width, int* height ) const;
    // wxWindow* GetToolBar() const;
    // wxMDIClientWindow* OnCreateClient();
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliMDIParentFrame, wxMDIParentFrame );

# if 0

void GetClientSize( int* width, int* height ) const
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "GetClientSize" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR );
        wxSize* val = (wxSize*)wxPli_sv_2_object( ret, "Wx::Size" );
        *width = val->x;
        *height = val->y;
        SvREFCNT_dec( ret );
    } else
        return wxMDIParentFrame::GetClientSize( width, height );
}

#endif

#if 0

wxWindow* GetToolBar() const
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "GetToolBar" ) ) 
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR );
        wxWindow* retval =
            (wxToolBar*)wxPli_sv_2_object( ret, "Wx::Window" );
        SvREFCNT_dec( ret );

        return retval;
    } else
        return wxMDIParentFrame::GetToolBar();
}

#endif

// wxMDIClientWindow isn't (yet) implemented
#if 0

wxMDIClientWindow* OnCreateClient()
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OnCreateClient" ) ) 
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR );
        wxToolBar* retval =
            (wxToolBar*)wxPli_sv_2_object( ret, "Wx::MDIClientWindow" );
        SvREFCNT_dec( ret );

        return retval;
    } else
        return wxMDIParentFrame::GetToolBar();
}

#endif

WXPLI_DECLARE_CLASS_7( MDIChildFrame, TRUE,
                       wxMDIParentFrame*, wxWindowID, const wxString&,
                       const wxPoint&, const wxSize&, long,
                       const wxString& );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliMDIChildFrame, wxMDIChildFrame );

#endif
    // _WXPERL_MDI_H

// Local variables: //
// mode: c++ //
// End: //

