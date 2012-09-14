/////////////////////////////////////////////////////////////////////////////
// Name:        ribbontoolbar.h
// Purpose:     wxPliRibbonTooBar implementation
// Author:      Mark Dootson
// SVN ID:      $Id:  $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////
//
// wxRibbonToolBar only implements SetClientData and
// not SetClientObject. This means we cannot implement standard wxPerl
// handling where wxPerl->SetClientData == wxWidgets->SetClientObject.
// wxWidgets->SetClientData does not delete wxObjects on destruction.
// This is fairly useless for wxPerl so we implement the offending
// class here and delete the client data in object destruction
//
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_RIBBONTOOLBAR_PLI_H_
#define _WXPERL_RIBBONTOOLBAR_PLI_H_

class wxPliRibbonToolBar:public wxRibbonToolBar
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliRibbonToolBar );
    WXPLI_DECLARE_SELFREF();
public:
    wxPliRibbonToolBar( const char* package )
        : wxRibbonToolBar(), m_callback( "Wx::RibbonToolBar" )
        {
            m_callback.SetSelf( wxPli_make_object( this, package ), true );
        }
    
    wxPliRibbonToolBar( const char* package, wxWindow* parent,
                  wxWindowID id = wxID_ANY,
                  const wxPoint& pos = wxDefaultPosition,
                  const wxSize& size = wxDefaultSize,
                  long style = 0)
        : wxRibbonToolBar( parent, id, pos, size, style ),
          m_callback( "Wx::RibbonToolBar" )
        {
            m_callback.SetSelf( wxPli_make_object( this, package ), true );
        }

    virtual ~wxPliRibbonToolBar() {
       
        size_t count = m_groups.GetCount();
        size_t i, t;
        for(i = 0; i < count; ++i)
        {
            wxRibbonToolBarToolGroup* group = m_groups.Item(i);
            size_t tool_count = group->tools.GetCount();
            for(t = 0; t < tool_count; ++t)
            {
                wxRibbonToolBarToolBase* tool = group->tools.Item(t);
                if( tool->client_data )
                    delete tool->client_data;
            }
        }
    }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS(wxPliRibbonToolBar, wxRibbonToolBar )

#endif
