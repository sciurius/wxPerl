/////////////////////////////////////////////////////////////////////////////
// Name:        ribbongalleryitem.h
// Purpose:     wxRibbonGalleryItem declaration
// Author:      Mark Dootson
// SVN ID:      $Id:  $
// Copyright:   (c) 2012 Mattia barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////
///
// declaration for this class is in src/ribbon/gallery.cpp which we
// cannot include so we need it here
//
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_RIBBON_GALLERY_ITEM_DECL_H_
#define _WXPERL_RIBBON_GALLERY_ITEM_DECL_H_

class wxRibbonGalleryItem
{
public:
    wxRibbonGalleryItem()
    {
        m_id = 0;
        m_is_visible = false;
    }

    void SetId(int id) {m_id = id;}
    void SetBitmap(const wxBitmap& bitmap) {m_bitmap = bitmap;}
    const wxBitmap& GetBitmap() const {return m_bitmap;}
    void SetIsVisible(bool visible) {m_is_visible = visible;}
    void SetPosition(int x, int y, const wxSize& size)
    {
        m_position = wxRect(wxPoint(x, y), size);
    }
    bool IsVisible() const {return m_is_visible;}
    const wxRect& GetPosition() const {return m_position;}

    void SetClientObject(wxClientData *data) {m_client_data.SetClientObject(data);}
    wxClientData *GetClientObject() const {return m_client_data.GetClientObject();}
    void SetClientData(void *data) {m_client_data.SetClientData(data);}
    void *GetClientData() const {return m_client_data.GetClientData();}

protected:
    wxBitmap m_bitmap;
    wxClientDataContainer m_client_data;
    wxRect m_position;
    int m_id;
    bool m_is_visible;
};

#endif


