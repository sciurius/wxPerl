/////////////////////////////////////////////////////////////////////////////
// Name:        frame.h
// Purpose:     c++ wrapper for wxFrame
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

class _wxFrame:public wxFrame
{
    _DECLARE_DYNAMIC_CLASS(_wxFrame);
    _DECLARE_V_CBACK();
public:
    _wxFrame( const char* package, wxWindow* parent, wxWindowID id, 
              const wxString& title, const wxPoint&, const wxSize&, long, 
              const wxString& );

    virtual wxStatusBar* OnCreateStatusBar( int, long, wxWindowID, const wxString& );
    virtual wxToolBar* OnCreateToolBar( long, wxWindowID, const wxString& );
};

_wxFrame::_wxFrame( const char* package, wxWindow* parent, 
                    wxWindowID id, const wxString& title, const wxPoint& pos, 
                    const wxSize& size, long style, const wxString& name )
    :m_callback( "Wx::Frame" )
{ 
    m_callback.SetSelf( _make_object( this, package ), FALSE );
    Create( parent, id, title, pos, size, style, name );
}

wxStatusBar* _wxFrame::OnCreateStatusBar( int number, long style, wxWindowID id, const wxString& name ) 
{
    if( m_callback.FindCallback( "OnCreateStatusBar" ) ) 
    {
        SV* ret = m_callback.CallCallback( G_SCALAR, "illp", number, style, id, name.c_str() );
        wxStatusBar* retval = (wxStatusBar*)_sv_2_object( ret, "Wx::StatusBar" );
        SvREFCNT_dec( ret );

        return retval;
    } else
        return wxFrame::OnCreateStatusBar( number, style, id, name );
}

wxToolBar* _wxFrame::OnCreateToolBar( long style, wxWindowID id, const wxString& name )
{
    if( m_callback.FindCallback( "OnCreateToolBar" ) ) 
    {
        SV* ret = m_callback.CallCallback( G_SCALAR, "llp", style, id, name.c_str() );
        wxToolBar* retval = (wxToolBar*)_sv_2_object( ret, "Wx::ToolBar" );
        SvREFCNT_dec( ret );

        return retval;
    } else
        return wxFrame::OnCreateToolBar( style, id, name );
}
    
_IMPLEMENT_DYNAMIC_CLASS( _wxFrame, wxFrame );

class _wxMiniFrame:public wxMiniFrame
{
    _DECLARE_DYNAMIC_CLASS(_wxMiniFrame);
    _DECLARE_SELFREF();
public:
    _wxMiniFrame( const char* package, wxWindow* parent, wxWindowID id,
                 const wxString& title, const wxPoint& pos,
                 const wxSize& size, long style, const wxString& name );
};

_wxMiniFrame::_wxMiniFrame( const char* package, wxWindow* parent,
                            wxWindowID id,
                            const wxString& title, const wxPoint& pos,
                            const wxSize& size, long style,
                            const wxString& name )
    :m_callback( "Wx::MiniFrame" )
{
    m_callback.SetSelf( _make_object( this, package ) );
    Create( parent, id, title, pos, size, style, name );
}

_IMPLEMENT_DYNAMIC_CLASS( _wxMiniFrame, wxMiniFrame );

// Local variables: //
// mode: c++ //
// End: //
