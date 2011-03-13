%module{Wx};

/////////////////////////////////////////////////////////////////////////////
// Name:        grid.h
// Purpose:     interface of wxGrid and related classes
// Author:      wxWidgets team
// RCS-ID:      $Id: grid.h 66496 2010-12-31 13:12:56Z VZ $
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

%loadplugin{build::Wx::XSP::Virtual};

#include <wx/grid.h>

%typemap{wxGrid*};
%typemap{wxGridCellAttr*};
%typemap{wxGridCellAttrProvider*};
%typemap{const wxGridCellCoords&}{reference};
%typemap{wxGridCellAttr::wxAttrKind}{simple};

/**
    @class wxGridTableBase

    The almost abstract base class for grid tables.

    A grid table is responsible for storing the grid data and, indirectly, grid
    cell attributes. The data can be stored in the way most convenient for the
    application but has to be provided in string form to wxGrid. It is also
    possible to provide cells values in other formats if appropriate, e.g. as
    numbers.

    This base class is not quite abstract as it implements a trivial strategy
    for storing the attributes by forwarding it to wxGridCellAttrProvider and
    also provides stubs for some other functions. However it does have a number
    of pure virtual methods which must be implemented in the derived classes.

    @see wxGridStringTable

    @library{wxadv}
    @category{grid}
*/
%name{Wx::GridTableBase} class wxGridTableBase : public %name{Wx::Object} wxObject
{
    %NoVirtualBase;
    %VirtualImplementation{
        %Name{wxPlGridTable};
        %Declaration{% WXPLI_DECLARE_DYNAMIC_CLASS( wxPlGridTable ); %};
        %Implementation{% WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlGridTable, wxGridTableBase ); %};
    };

public:
    /**
        Default constructor.
     */
    wxGridTableBase();

    /**
        Destructor frees the attribute provider if it was created.
     */
    %name{Destroy} virtual ~wxGridTableBase();

    /**
        Must be overridden to return the number of rows in the table.

        For backwards compatibility reasons, this method is not const.
        Use GetRowsCount() instead of it in const methods of derived table
        classes.
     */
    virtual int GetNumberRows() = 0 %Virtual{pure};

    /**
        Must be overridden to return the number of columns in the table.

        For backwards compatibility reasons, this method is not const.
        Use GetColsCount() instead of it in const methods of derived table
        classes,
     */
    virtual int GetNumberCols() = 0 %Virtual{pure};

#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    /**
        Return the number of rows in the table.

        This method is not virtual and is only provided as a convenience for
        the derived classes which can't call GetNumberRows() without a
        @c const_cast from their const methods.
     */
    int GetRowsCount() const;

    /**
        Return the number of columns in the table.

        This method is not virtual and is only provided as a convenience for
        the derived classes which can't call GetNumberCols() without a
        @c const_cast from their const methods.
     */
    int GetColsCount() const;

#endif

    /**
        @name Table Cell Accessors
     */
    //@{

    /**
        May be overridden to implement testing for empty cells.

        This method is used by the grid to test if the given cell is not used
        and so whether a neighbouring cell may overflow into it. By default it
        only returns true if the value of the given cell, as returned by
        GetValue(), is empty.
     */
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    virtual bool IsEmptyCell(int row, int col) %Virtual;
#else
    virtual bool IsEmptyCell(int row, int col) = 0 %Virtual{pure};
#endif

    /**
        Same as IsEmptyCell() but taking wxGridCellCoords.

        Notice that this method is not virtual, only IsEmptyCell() should be
        overridden.
     */

#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    bool IsEmpty(const wxGridCellCoords& coords);
#endif

    /**
        Must be overridden to implement accessing the table values as text.
     */
    virtual wxString GetValue(int row, int col) = 0 %Virtual{pure};

    /**
        Must be overridden to implement setting the table values as text.
     */
    virtual void SetValue(int row, int col, const wxString& value) = 0 %Virtual{pure};

    /**
        Returns the type of the value in the given cell.

        By default all cells are strings and this method returns
        @c wxGRID_VALUE_STRING.
     */
    virtual wxString GetTypeName(int row, int col) %Virtual;

    /**
        Returns true if the value of the given cell can be accessed as if it
        were of the specified type.

        By default the cells can only be accessed as strings. Note that a cell
        could be accessible in different ways, e.g. a numeric cell may return
        @true for @c wxGRID_VALUE_NUMBER but also for @c wxGRID_VALUE_STRING
        indicating that the value can be coerced to a string form.
     */
    virtual bool CanGetValueAs(int row, int col, const wxString& typeName) %Virtual;

    /**
        Returns true if the value of the given cell can be set as if it were of
        the specified type.

        @see CanGetValueAs()
     */
    virtual bool CanSetValueAs(int row, int col, const wxString& typeName) %Virtual;

    /**
        Returns the value of the given cell as a long.

        This should only be called if CanGetValueAs() returns @true when called
        with @c wxGRID_VALUE_NUMBER argument. Default implementation always
        return 0.
     */
    virtual long GetValueAsLong(int row, int col) %Virtual;

    /**
        Returns the value of the given cell as a double.

        This should only be called if CanGetValueAs() returns @true when called
        with @c wxGRID_VALUE_FLOAT argument. Default implementation always
        return 0.0.
     */
    virtual double GetValueAsDouble(int row, int col) %Virtual;

    /**
        Returns the value of the given cell as a boolean.

        This should only be called if CanGetValueAs() returns @true when called
        with @c wxGRID_VALUE_BOOL argument. Default implementation always
        return false.
     */
    virtual bool GetValueAsBool(int row, int col) %Virtual;

    /**
        Returns the value of the given cell as a user-defined type.

        This should only be called if CanGetValueAs() returns @true when called
        with @a typeName. Default implementation always return @NULL.
     */
    // virtual void *GetValueAsCustom(int row, int col, const wxString& typeName);

    /**
        Sets the value of the given cell as a long.

        This should only be called if CanSetValueAs() returns @true when called
        with @c wxGRID_VALUE_NUMBER argument. Default implementation doesn't do
        anything.
     */
    virtual void SetValueAsLong(int row, int col, long value) %Virtual;

    /**
        Sets the value of the given cell as a double.

        This should only be called if CanSetValueAs() returns @true when called
        with @c wxGRID_VALUE_FLOAT argument. Default implementation doesn't do
        anything.
     */
    virtual void SetValueAsDouble(int row, int col, double value) %Virtual;

    /**
        Sets the value of the given cell as a boolean.

        This should only be called if CanSetValueAs() returns @true when called
        with @c wxGRID_VALUE_BOOL argument. Default implementation doesn't do
        anything.
     */
    virtual void SetValueAsBool( int row, int col, bool value ) %Virtual;

    /**
        Sets the value of the given cell as a user-defined type.

        This should only be called if CanSetValueAs() returns @true when called
        with @a typeName. Default implementation doesn't do anything.
     */
    // virtual void SetValueAsCustom(int row, int col, const wxString& typeName,
    //                               void *value);

    //@}


    /**
        Called by the grid when the table is associated with it.

        The default implementation stores the pointer and returns it from its
        GetView() and so only makes sense if the table cannot be associated
        with more than one grid at a time.
     */
    virtual void SetView(wxGrid *grid) %Virtual;

    /**
        Returns the last grid passed to SetView().
     */
    virtual wxGrid *GetView() const %Virtual;


    /**
        @name Table Structure Modifiers

        Notice that none of these functions are pure virtual as they don't have
        to be implemented if the table structure is never modified after
        creation, i.e. neither rows nor columns are never added or deleted but
        that you do need to implement them if they are called, i.e. if your
        code either calls them directly or uses the matching wxGrid methods, as
        by default they simply do nothing which is definitely inappropriate.
     */
    //@{

    /**
        Clear the table contents.

        This method is used by wxGrid::ClearGrid().
     */
    virtual void Clear() %Virtual;

    /**
        Insert additional rows into the table.

        @param pos
            The position of the first new row.
        @param numRows
            The number of rows to insert.
     */
    virtual bool InsertRows(size_t pos = 0, size_t numRows = 1) %Virtual;

    /**
        Append additional rows at the end of the table.

        This method is provided in addition to InsertRows() as some data models
        may only support appending rows to them but not inserting them at
        arbitrary locations. In such case you may implement this method only
        and leave InsertRows() unimplemented.

        @param numRows
            The number of rows to add.
     */
    virtual bool AppendRows(size_t numRows = 1) %Virtual;

    /**
        Delete rows from the table.

        @param pos
            The first row to delete.
        @param numRows
            The number of rows to delete.
     */
    virtual bool DeleteRows(size_t pos = 0, size_t numRows = 1) %Virtual;

    /**
        Exactly the same as InsertRows() but for columns.
     */
    virtual bool InsertCols(size_t pos = 0, size_t numCols = 1) %Virtual;

    /**
        Exactly the same as AppendRows() but for columns.
     */
    virtual bool AppendCols(size_t numCols = 1) %Virtual;

    /**
        Exactly the same as DeleteRows() but for columns.
     */
    virtual bool DeleteCols(size_t pos = 0, size_t numCols = 1) %Virtual;

    //@}

    /**
        @name Table Row and Column Labels

        By default the numbers are used for labeling rows and Latin letters for
        labeling columns. If the table has more than 26 columns, the pairs of
        letters are used starting from the 27-th one and so on, i.e. the
        sequence of labels is A, B, ..., Z, AA, AB, ..., AZ, BA, ..., ..., ZZ,
        AAA, ...
     */
    //@{

    /**
        Return the label of the specified row.
     */
    virtual wxString GetRowLabelValue(int row) %Virtual;

    /**
        Return the label of the specified column.
     */
    virtual wxString GetColLabelValue(int col) %Virtual;

    /**
        Set the given label for the specified row.

        The default version does nothing, i.e. the label is not stored. You
        must override this method in your derived class if you wish
        wxGrid::SetRowLabelValue() to work.
     */
    virtual void SetRowLabelValue(int row, const wxString& label) %Virtual;

    /**
        Exactly the same as SetRowLabelValue() but for columns.
     */
    virtual void SetColLabelValue(int col, const wxString& label) %Virtual;

    //@}


    /**
        @name Attributes Management

        By default the attributes management is delegated to
        wxGridCellAttrProvider class. You may override the methods in this
        section to handle the attributes directly if, for example, they can be
        computed from the cell values.
     */
    //@{

    /**
        Associate this attributes provider with the table.

        The table takes ownership of @a attrProvider pointer and will delete it
        when it doesn't need it any more. The pointer can be @NULL, however
        this won't disable attributes management in the table but will just
        result in a default attributes being recreated the next time any of the
        other functions in this section is called. To completely disable the
        attributes support, should this be needed, you need to override
        CanHaveAttributes() to return @false.
     */
    void SetAttrProvider(wxGridCellAttrProvider *attrProvider);

    /**
        Returns the attribute provider currently being used.

        This function may return @NULL if the attribute provider hasn't been
        neither associated with this table by SetAttrProvider() nor created on
        demand by any other methods.
     */
    wxGridCellAttrProvider *GetAttrProvider() const;

    /**
        Return the attribute for the given cell.

        By default this function is simply forwarded to
        wxGridCellAttrProvider::GetAttr() but it may be overridden to handle
        attributes directly in the table.
     */
    virtual wxGridCellAttr *GetAttr(int row, int col,
                                    wxGridCellAttr::wxAttrKind kind) %Virtual;

    /**
        Set attribute of the specified cell.

        By default this function is simply forwarded to
        wxGridCellAttrProvider::SetAttr().

        The table takes ownership of @a attr, i.e. will call DecRef() on it.
     */
    virtual void SetAttr(wxGridCellAttr* attr, int row, int col) %Virtual;

    /**
        Set attribute of the specified row.

        By default this function is simply forwarded to
        wxGridCellAttrProvider::SetRowAttr().

        The table takes ownership of @a attr, i.e. will call DecRef() on it.
     */
    virtual void SetRowAttr(wxGridCellAttr *attr, int row) %Virtual;

    /**
        Set attribute of the specified column.

        By default this function is simply forwarded to
        wxGridCellAttrProvider::SetColAttr().

        The table takes ownership of @a attr, i.e. will call DecRef() on it.
     */
    virtual void SetColAttr(wxGridCellAttr *attr, int col) %Virtual;

    //@}

    /**
        Returns true if this table supports attributes or false otherwise.

        By default, the table automatically creates a wxGridCellAttrProvider
        when this function is called if it had no attribute provider before and
        returns @true.
     */
    virtual bool CanHaveAttributes() %Virtual;
};
