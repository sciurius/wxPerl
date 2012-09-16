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
%typemap{const wxDataViewListStore *}{simple};

#include "cpp/array_helpers.h"

/**
    @class wxDataViewListCtrl

    This class is a wxDataViewCtrl which internally uses a wxDataViewListStore
    and forwards most of its API to that class.

    The purpose of this class is to offer a simple way to display and
    edit a small table of data without having to write your own wxDataViewModel.

    @code
       wxDataViewListCtrl *listctrl = new wxDataViewListCtrl( parent, wxID_ANY );

       listctrl->AppendToggleColumn( "Toggle" );
       listctrl->AppendTextColumn( "Text" );

       wxVector<wxVariant> data;
       data.push_back( wxVariant(true) );
       data.push_back( wxVariant("row 1") );
       listctrl->AppendItem( data );

       data.clear();
       data.push_back( wxVariant(false) );
       data.push_back( wxVariant("row 3") );
       listctrl->AppendItem( data );
    @endcode

    @beginStyleTable
    See wxDataViewCtrl for the list of supported styles.
    @endStyleTable

    @beginEventEmissionTable
    See wxDataViewCtrl for the list of events emitted by this class.
    @endEventTable

    @library{wxadv}
    @category{ctrl,dvc}
*/
%name{Wx::DataViewListCtrl} class wxDataViewListCtrl: public %name{Wx::DataViewCtrl} wxDataViewCtrl
{
public:
    /**
        Default ctor.
    */
    wxDataViewListCtrl();

    /**
        Constructor. Calls Create().
    */
    wxDataViewListCtrl( wxWindow *parent, wxWindowID id,
           const wxPoint& pos = wxDefaultPosition,
           const wxSize& size = wxDefaultSize, long style = wxDV_ROW_LINES,
           const wxValidator& validator = wxDefaultValidatorPtr );

    /**
        Destructor. Deletes the image list if any.
    */
    // wxPerl change: no need for destructor
    // ~wxDataViewListCtrl();

    /**
        Creates the control and a wxDataViewListStore as its internal model.
    */
    bool Create( wxWindow *parent, wxWindowID id,
           const wxPoint& pos = wxDefaultPosition,
           const wxSize& size = wxDefaultSize, long style = wxDV_ROW_LINES,
           const wxValidator& validator = wxDefaultValidatorPtr );

    //@{
    /**
        Returns the store.
    */
    wxDataViewListStore *GetStore();
    //const wxDataViewListStore *GetStore() const;
    //@}

    /**
        @name Column management functions
    */
    //@{

    /**
        Appends a column to the control and additionally appends a
        column to the store with the type string.
    */
    virtual void AppendColumn( wxDataViewColumn *column );

    /**
        Appends a column to the control and additionally appends a
        column to the list store with the type @a varianttype.
    */
    void AppendColumn( wxDataViewColumn *column, const wxString &varianttype );

    /**
        Appends a text column to the control and the store.

        See wxDataViewColumn::wxDataViewColumn for more info about
        the parameters.
    */
    wxDataViewColumn *AppendTextColumn( const wxString &label,
          wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
          int width = -1, wxAlignment align = wxALIGN_LEFT,
          int flags = wxDATAVIEW_COL_RESIZABLE );

    /**
        Appends a toggle column to the control and the store.

        See wxDataViewColumn::wxDataViewColumn for more info about
        the parameters.
    */
    wxDataViewColumn *AppendToggleColumn( const wxString &label,
          wxDataViewCellMode mode = wxDATAVIEW_CELL_ACTIVATABLE,
          int width = -1, wxAlignment align = wxALIGN_LEFT,
          int flags = wxDATAVIEW_COL_RESIZABLE );

    /**
        Appends a progress column to the control and the store.

        See wxDataViewColumn::wxDataViewColumn for more info about
        the parameters.
    */
    wxDataViewColumn *AppendProgressColumn( const wxString &label,
          wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
          int width = -1, wxAlignment align = wxALIGN_LEFT,
          int flags = wxDATAVIEW_COL_RESIZABLE );

    /**
        Appends an icon-and-text column to the control and the store.

        See wxDataViewColumn::wxDataViewColumn for more info about
        the parameters.
    */
    wxDataViewColumn *AppendIconTextColumn( const wxString &label,
          wxDataViewCellMode mode = wxDATAVIEW_CELL_INERT,
          int width = -1, wxAlignment align = wxALIGN_LEFT,
          int flags = wxDATAVIEW_COL_RESIZABLE );

    /**
        Inserts a column to the control and additionally inserts a
        column to the store with the type string.
    */
    virtual void InsertColumn( unsigned int pos, wxDataViewColumn *column );

    /**
        Inserts a column to the control and additionally inserts a
        column to the list store with the type @a varianttype.
    */
    void InsertColumn( unsigned int pos, wxDataViewColumn *column,
                       const wxString &varianttype );

    /**
        Prepends a column to the control and additionally prepends a
        column to the store with the type string.
    */
    virtual void PrependColumn( wxDataViewColumn *column );

    /**
        Prepends a column to the control and additionally prepends a
        column to the list store with the type @a varianttype.
    */
    void PrependColumn( wxDataViewColumn *column, const wxString &varianttype );

    //@}


    /**
        @name Item management functions
    */
    //@{

#if WXPERL_W_VERSION_GE( 2, 9, 4 )
    
    /**
        Appends an item (=row) to the control and store.
    */
    void AppendItem( const wxVector<wxVariant> &values, Wx_UserDataO *data = NULL )
       %code{% THIS->AppendItem( values, wxPtrToUInt( data ) ); %};

    /**
        Prepends an item (=row) to the control and store.
    */
    void PrependItem( const wxVector<wxVariant> &values, Wx_UserDataO *data = NULL )
       %code{% THIS->AppendItem( values, wxPtrToUInt( data ) ); %};

    /**
        Inserts an item (=row) to the control and store.
    */
    void InsertItem( unsigned int row, const wxVector<wxVariant> &values, Wx_UserDataO *data = NULL )
       %code{% THIS->AppendItem( values, wxPtrToUInt( data ) ); %};

#else

    /**
        Appends an item (=row) to the control and store.
    */
    void AppendItem( const wxVector<wxVariant> &values, wxClientData *data = NULL );

    /**
        Prepends an item (=row) to the control and store.
    */
    void PrependItem( const wxVector<wxVariant> &values, wxClientData *data = NULL );

    /**
        Inserts an item (=row) to the control and store.
    */
    void InsertItem( unsigned int row, const wxVector<wxVariant> &values, wxClientData *data = NULL );

#endif

    /**
        Delete the row at position @a row.
    */
    void DeleteItem( unsigned row );

    /**
        Delete all items (= all rows).
    */
    void DeleteAllItems();

    /**
         Sets the value in the store and update the control.
    */
    void SetValue( const wxVariant &value, unsigned int row, unsigned int col );

    /**
         Returns the value from the store.
    */
    void GetValue( wxVariant &value, unsigned int row, unsigned int col );

    /**
         Sets the value in the store and update the control.

         This method assumes that the a string is stored in respective
         column.
    */
    void SetTextValue( const wxString &value, unsigned int row, unsigned int col );

    /**
         Returns the value from the store.

         This method assumes that the a string is stored in respective
         column.
    */
    wxString GetTextValue( unsigned int row, unsigned int col ) const;

    /**
         Sets the value in the store and update the control.

         This method assumes that the a boolean value is stored in
         respective column.
    */
    void SetToggleValue( bool value, unsigned int row, unsigned int col );

    /**
         Returns the value from the store.

         This method assumes that the a boolean value is stored in
         respective column.
    */
    bool GetToggleValue( unsigned int row, unsigned int col ) const;

    //@}
};
