/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/wxsizer.h
// Purpose:     provide wxBookCtrlSizer andwxNotebookSizer class
// Author:      Robert Roebling and Robin Dunn
// Modified by: Ron Lee, Vadim Zeitlin (wxSizerFlags)
// Created:
// RCS-ID:      $Id: wxsizer.h,v 1.2 2005/07/11 22:23:13 mbarbon Exp $
// Copyright:   (c) Robin Dunn, Robert Roebling
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

// extracted from sizer.h/sizer.cpp from wxWidgets 2.6.1

// NB: wxBookCtrlSizer and wxNotebookSizer are deprecated, they
//     don't do anything. wxBookCtrlBase::DoGetBestSize does the job now.

// ----------------------------------------------------------------------------
// wxBookCtrlSizer
// ----------------------------------------------------------------------------

#if wxUSE_BOOKCTRL

// this sizer works with wxNotebook/wxListbook/... and sizes the control to
// fit its pages
class wxBookCtrlBase;

class wxBookCtrlSizer : public wxSizer
{
public:
    wxBookCtrlSizer(wxBookCtrlBase *bookctrl);

    wxBookCtrlBase *GetControl() const { return m_bookctrl; }

    virtual void RecalcSizes();
    virtual wxSize CalcMin();

protected:

    wxBookCtrlBase *m_bookctrl;

private:
    DECLARE_CLASS(wxBookCtrlSizer)
    DECLARE_NO_COPY_CLASS(wxBookCtrlSizer)
};


#if wxUSE_NOTEBOOK

// before wxBookCtrlBase we only had wxNotebookSizer, keep it for backwards
// compatibility
class wxNotebook;

class wxNotebookSizer : public wxBookCtrlSizer
{
public:
    wxNotebookSizer(wxNotebook *nb);

    wxNotebook *GetNotebook() const { return (wxNotebook *)m_bookctrl; }

private:
    DECLARE_CLASS(wxNotebookSizer)
    DECLARE_NO_COPY_CLASS(wxNotebookSizer)
};

#endif // wxUSE_NOTEBOOK

#endif // wxUSE_BOOKCTRL

#if wxUSE_BOOKCTRL
IMPLEMENT_CLASS(wxBookCtrlSizer, wxSizer)
#if wxUSE_NOTEBOOK
IMPLEMENT_CLASS(wxNotebookSizer, wxBookCtrlSizer)
#endif // wxUSE_NOTEBOOK
#endif // wxUSE_BOOKCTRL

#if wxUSE_BOOKCTRL

wxBookCtrlSizer::wxBookCtrlSizer(wxBookCtrlBase *bookctrl)
               : m_bookctrl(bookctrl)
{
    wxASSERT_MSG( bookctrl, wxT("wxBookCtrlSizer needs a control") );
}

void wxBookCtrlSizer::RecalcSizes()
{
    m_bookctrl->SetSize( m_position.x, m_position.y, m_size.x, m_size.y );
}

wxSize wxBookCtrlSizer::CalcMin()
{
    wxSize sizeBorder = m_bookctrl->CalcSizeFromPage(wxSize(0,0));

    sizeBorder.x += 5;
    sizeBorder.y += 5;

    if ( m_bookctrl->GetPageCount() == 0 )
    {
        return wxSize(sizeBorder.x + 10, sizeBorder.y + 10);
    }

    int maxX = 0;
    int maxY = 0;

    wxWindowList::compatibility_iterator
        node = m_bookctrl->GetChildren().GetFirst();
    while (node)
    {
        wxWindow *item = node->GetData();
        wxSizer *itemsizer = item->GetSizer();

        if (itemsizer)
        {
            wxSize subsize( itemsizer->CalcMin() );

            if (subsize.x > maxX)
                maxX = subsize.x;
            if (subsize.y > maxY)
                maxY = subsize.y;
        }

        node = node->GetNext();
    }

    return wxSize( maxX, maxY ) + sizeBorder;
}

#if wxUSE_NOTEBOOK

wxNotebookSizer::wxNotebookSizer(wxNotebook *nb)
    : wxBookCtrlSizer(nb)
{
    wxASSERT_MSG( nb, wxT("wxNotebookSizer needs a control") );
}

#endif // wxUSE_NOTEBOOOK
#endif // wxUSE_BOOKCTRL
