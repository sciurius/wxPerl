%module{Wx};

/////////////////////////////////////////////////////////////////////////////
// Name:        dataview.h
// Purpose:     interface of wxDataView* classes
// Author:      wxWidgets team
// RCS-ID:      $Id$
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

%loadplugin{build::Wx::XSP::Virtual};

#include <wx/dataview.h>

/**
    @class wxDataViewVirtualListModel

    wxDataViewVirtualListModel is a specialized data model which lets you address
    an item by its position (row) rather than its wxDataViewItem and as such offers
    the exact same interface as wxDataViewIndexListModel.
    The important difference is that under platforms other than OS X, using this
    model will result in a truly virtual control able to handle millions of items
    as the control doesn't store any item (a feature not supported by the
    Carbon API under OS X).

    @see wxDataViewIndexListModel for the API.

    @library{wxadv}
    @category{dvc}
*/
%name{Wx::DataViewVirtualListModel} class wxDataViewVirtualListModel : public %name{Wx::DataViewModel} wxDataViewModel
{
public:
    /**
        Constructor.
    */
    wxDataViewVirtualListModel(unsigned int initial_size = 0);

    /**
        Returns the number of virtual items (i.e. rows) in the list.
    */
    unsigned int GetCount() const;

    // pure virtual methods from base class
    virtual unsigned int GetColumnCount() const %Virtual{pure};
    virtual wxString GetColumnType(unsigned int column) const %Virtual{pure};
    virtual void GetValueByRow(wxVariant& value, unsigned int row, unsigned int col) const %Virtual{pure};
    virtual bool SetValueByRow(const wxVariant& value, unsigned int row, unsigned int col) %Virtual{pure};
};
