/////////////////////////////////////////////////////////////////////////////
// Name:        ribbonbuttonbar.h
// Purpose:     wxPliRibbonButtonBar implementation
// Author:      Mark Dootson
// SVN ID:      $Id:  $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////
//
// wxRibbonButtonBar only implements SetClientData and
// not SetClientObject. This means we cannot implement standard wxPerl
// handling where wxPerl->SetClientData == wxWidgets->SetClientObject.
// wxWidgets->SetClientData does not delete wxObjects on destruction.
// This is fairly useless for wxPerl so we implement the offending
// class here and delete the client data in object destruction
//
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_RIBBONBUTTONBAR_PLI_H_
#define _WXPERL_RIBBONBUTTONBAR_PLI_H_

class wxPliRibbonButtonBar:public wxRibbonButtonBar
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPliRibbonButtonBar );
    WXPLI_DECLARE_SELFREF();
public:
    wxPliRibbonButtonBar( const char* package )
        : wxRibbonButtonBar(), m_callback( "Wx::RibbonButtonBar" )
        {
            m_callback.SetSelf( wxPli_make_object( this, package ), true );
        }
    
    wxPliRibbonButtonBar( const char* package, wxWindow* parent,
                  wxWindowID id = wxID_ANY,
                  const wxPoint& pos = wxDefaultPosition,
                  const wxSize& size = wxDefaultSize,
                  long style = 0)
        : wxRibbonButtonBar( parent, id, pos, size, style ),
          m_callback( "Wx::RibbonButtonBar" )
        {
            m_callback.SetSelf( wxPli_make_object( this, package ), true );
        }

    virtual ~wxPliRibbonButtonBar() {
        size_t count = m_buttons.GetCount();
        size_t i;
        for(i = 0; i < count; ++i)
        {
            wxRibbonButtonBarButtonBase* button = m_buttons.Item(i);
            if( button->client_data )
                delete button->client_data;
        }
    }
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS(wxPliRibbonButtonBar, wxRibbonButtonBar )

#endif
