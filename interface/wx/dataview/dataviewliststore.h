%module{Wx};

/////////////////////////////////////////////////////////////////////////////
// Name:        dataview.h
// Purpose:     interface of wxDataView* classes
// Author:      wxWidgets team
// RCS-ID:      $Id: dataview.h 62943 2009-12-19 11:59:55Z VZ $
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

#include <wx/dataview.h>

%loadplugin{build::Wx::XSP::Overload};

%typemap{const wxVector<wxVariant>&}{parsed}{%wxVectorVariant%};
%typemap{wxClientData*}{parsed}{%wxPliUserDataCD*%};

/**
    @class wxDataViewListStore

    wxDataViewListStore is a specialised wxDataViewModel for storing
    a simple table of data. Since it derives from wxDataViewIndexListModel
    its data is be accessed by row (i.e. by index) instead of only
    by wxDataViewItem.

    This class actually stores the values (therefore its name)
    and implements all virtual methods from the base classes so it can be
    used directly without having to derive any class from it, but it is
    mostly used from within wxDataViewListCtrl.

    @library{wxadv}
    @category{dvc}
*/

%name{Wx::DataViewListStore} class wxDataViewListStore: public %name{Wx::DataViewIndexListModel} wxDataViewIndexListModel
{
public:
    /**
        Constructor
    */
    wxDataViewListStore();

    /**
        Destructor
    */
    // wxPerl change: no need for destructor
    // ~wxDataViewListStore();

    /**
        Prepends a data column.

        @a variantype indicates the type of values store in the column.

        This does not automatically fill in any (default) values in
        rows which exist in the store already.
    */
    void PrependColumn( const wxString &varianttype );

    /**
        Inserts a data column before @a pos.

        @a variantype indicates the type of values store in the column.

        This does not automatically fill in any (default) values in
        rows which exist in the store already.
    */
    void InsertColumn( unsigned int pos, const wxString &varianttype );

    /**
        Appends a data column.

        @a variantype indicates the type of values store in the column.

        This does not automatically fill in any (default) values in
        rows which exist in the store already.
    */
    void AppendColumn( const wxString &varianttype );

#if WXPERL_W_VERSION_GE( 2, 9, 4 )

    
    void AppendItem( const wxVector<wxVariant> &values, Wx_UserDataO *data = NULL )
       %code{% THIS->AppendItem( values, wxPtrToUInt( data ) ); %};

    void PrependItem( const wxVector<wxVariant> &values, Wx_UserDataO *data = NULL )
       %code{% THIS->AppendItem( values, wxPtrToUInt( data ) ); %};

    void InsertItem(  unsigned int row, const wxVector<wxVariant> &values, Wx_UserDataO *data = NULL )
       %code{% THIS->AppendItem( values, wxPtrToUInt( data ) ); %};

#else
    
    /**
        Appends an item (=row) and fills it with @a values.

        The values must match the values specifies in the column
        in number and type. No (default) values are filled in
        automatically.
    */
    void AppendItem( const wxVector<wxVariant> &values, wxClientData *data = NULL );

    /**
        Prepends an item (=row) and fills it with @a values.

        The values must match the values specifies in the column
        in number and type. No (default) values are filled in
        automatically.
    */
    void PrependItem( const wxVector<wxVariant> &values, wxClientData *data = NULL );

    /**
        Inserts an item (=row) and fills it with @a values.

        The values must match the values specifies in the column
        in number and type. No (default) values are filled in
        automatically.
    */
    void InsertItem(  unsigned int row, const wxVector<wxVariant> &values, wxClientData *data = NULL );

#endif    

    /**
        Delete the item (=row) at position @a pos.
    */
    void DeleteItem( unsigned pos );

    /**
        Delete all item (=all rows) in the store.
    */
    void DeleteAllItems();

    /**
        Overriden from wxDataViewModel
    */
    virtual unsigned int GetColumnCount() const;

    /**
        Overriden from wxDataViewModel
    */
    virtual wxString GetColumnType( unsigned int col ) const;

    /**
        Overriden from wxDataViewIndexListModel
    */
    virtual void GetValueByRow( wxVariant &value,
                           unsigned int row, unsigned int col ) const;

    /**
        Overriden from wxDataViewIndexListModel
    */
    virtual bool SetValueByRow( const wxVariant &value,
                           unsigned int row, unsigned int col );
};
