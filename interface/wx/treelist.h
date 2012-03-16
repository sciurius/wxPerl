%module{Wx};
///////////////////////////////////////////////////////////////////////////////
// Name:        interface/wx/treelist.h
// Purpose:     wxTreeListCtrl class documentation
// Author:      Vadim Zeitlin
// Created:     2011-08-17
// SVN-ID:      $Id$
// Copyright:   (c) 2011 Vadim Zeitlin <vadim@wxwidgets.org>
// Licence:     wxWindows licence
///////////////////////////////////////////////////////////////////////////////

#if WXPERL_W_VERSION_GE( 2, 9, 3 )

#include <wx/treelist.h>

%typemap{wxTreeListItem}{reference};
%typemap{wxTreeListCtrl*}{simple};
%typemap{wxCheckBoxState}{simple};
%typemap{wxAlignment}{simple};
%typemap{wxClientData*}{parsed}{%wxPliUserDataCD*%};

%loadplugin{build::Wx::XSP::Overload};
%loadplugin{build::Wx::XSP::Virtual};
%loadplugin{build::Wx::XSP::Enum};
%loadplugin{build::Wx::XSP::Event};


%VirtualTypeMap{
    %Name{%wxTreeListCtrl*%};
    %ConvertReturn{%(wxTreeListCtrl*)wxPli_sv_2_object( aTHX_ ret, "Wx::TreeListCtrl" )%};
    %TypeChar{%O%};
    %Arguments{%%s%};
};

%VirtualTypeMap{
    %Name{%wxTreeListItem%};
    %ConvertReturn{%*(wxTreeListItem*)wxPli_sv_2_object( aTHX_ ret, "Wx::TreeListItem" )%};
    %TypeChar{%o%};
    %Arguments{%&%s, "Wx::TreeListItem"%};
};


%name{Wx::TreeListItem} class wxTreeListItem
{
public:

%{
static void
wxTreeListItem::CLONE()
  CODE:
    wxPli_thread_sv_clone( aTHX_ CLASS, (wxPliCloneSV)wxPli_detach_object );
%}

    /* wxTreeListItem(); no constructor = no objects are deleteable */
    
    ~wxTreeListItem()
        %code%{  wxPli_thread_sv_unregister( aTHX_ "Wx::TreeListItem", THIS, ST(0) ); %};

    bool IsOk() const;
};

%name{Wx::TreeListItemComparator} class wxTreeListItemComparator
{

public:
  
    wxTreeListItemComparator();
    
    virtual int Compare(wxTreeListCtrl* treelist, unsigned column, wxTreeListItem first, wxTreeListItem second) = 0 %Virtual{pure};

};

enum
{
    wxTL_SINGLE         = 0x0000,       // This is the default anyhow.
    wxTL_MULTIPLE       = 0x0001,       // Allow multiple selection.
    wxTL_CHECKBOX       = 0x0002,       // Show checkboxes in the first column.
    wxTL_3STATE         = 0x0004,       // Allow 3rd state in checkboxes.
    wxTL_USER_3STATE    = 0x0008,       // Allow user to set 3rd state.

    wxTL_STYLE_MASK     = 0x000F,
    wxTL_DEFAULT_STYLE  = wxTL_SINGLE
};

%Event{%EVT_TREELIST_SELECTION_CHANGED(id, func)%}
      {wxEVT_COMMAND_TREELIST_SELECTION_CHANGED};
%Event{%EVT_TREELIST_ITEM_EXPANDING(id, func)%}
      {wxEVT_COMMAND_TREELIST_ITEM_EXPANDING};
%Event{%EVT_TREELIST_ITEM_EXPANDED(id, func)%}
      {wxEVT_COMMAND_TREELIST_ITEM_EXPANDED};
%Event{%EVT_TREELIST_ITEM_CHECKED(id, func)%}
      {wxEVT_COMMAND_TREELIST_ITEM_CHECKED};
%Event{%EVT_TREELIST_ITEM_ACTIVATED(id, func)%}
      {wxEVT_COMMAND_TREELIST_ITEM_ACTIVATED};
%Event{%EVT_TREELIST_ITEM_CONTEXT_MENU(id, func)%}
      {wxEVT_COMMAND_TREELIST_ITEM_CONTEXT_MENU};
%Event{%EVT_TREELIST_COLUMN_SORTED(id, func)%}
      {wxEVT_COMMAND_TREELIST_COLUMN_SORTED};

%name{Wx::TreeListCtrl} class wxTreeListCtrl : public %name{Wx::Window} wxWindow
{
public:
    
    %name{newDefault} wxTreeListCtrl() %Overload
        %postcall{% wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    %name{newFull} wxTreeListCtrl(wxWindow* parent,
                   wxWindowID id,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = wxTL_DEFAULT_STYLE,
                   const wxString& name = wxTreeListCtrlNameStr) %Overload
        %postcall{% wxPli_create_evthandler( aTHX_ RETVAL, CLASS ); %};

    bool Create(wxWindow* parent,
                wxWindowID id,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = wxTL_DEFAULT_STYLE,
                const wxString& name = wxTreeListCtrlNameStr);

%{

void
wxTreeListCtrl::AssignImageList( imagelist )
    wxImageList* imagelist
  CODE:
    wxPli_object_set_deleteable( aTHX_ ST(1), false );
    THIS->AssignImageList( imagelist );

    
wxImageList*
wxTreeListCtrl::GetImageList()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

%}

    void SetImageList(wxImageList* imageList);

    int AppendColumn(const wxString& title,
                     int width = wxCOL_WIDTH_AUTOSIZE,
                     wxAlignment align = wxALIGN_LEFT,
                     int flags = wxCOL_RESIZABLE);

    unsigned GetColumnCount() const;

    bool DeleteColumn(unsigned col);

    void ClearColumns();

    void SetColumnWidth(unsigned col, int width);

    int GetColumnWidth(unsigned col) const;

    int WidthFor(const wxString& text) const;

    wxTreeListItem AppendItem(wxTreeListItem parent,
                              const wxString& text,
                              int imageClosed = -1,
                              int imageOpened = -1,
                              wxPliUserDataCD *data = NULL);

    wxTreeListItem InsertItem(wxTreeListItem parent,
                              wxTreeListItem previous,
                              const wxString& text,
                              int imageClosed = -1,
                              int imageOpened = -1,
                              wxPliUserDataCD *data = NULL);

    wxTreeListItem PrependItem(wxTreeListItem parent,
                               const wxString& text,
                               int imageClosed = -1,
                               int imageOpened = -1,
                               wxPliUserDataCD *data = NULL);

    void DeleteItem(wxTreeListItem item);

    void DeleteAllItems();

    wxTreeListItem GetRootItem() const;

    wxTreeListItem GetItemParent(wxTreeListItem item) const;

    wxTreeListItem GetFirstChild(wxTreeListItem item) const;

    wxTreeListItem GetNextSibling(wxTreeListItem item) const;

    wxTreeListItem GetFirstItem() const;

    wxTreeListItem GetNextItem(wxTreeListItem item) const;

    const wxString& GetItemText(wxTreeListItem item, unsigned col = 0) const;

    void SetItemText(wxTreeListItem item, unsigned col, const wxString& text);

    void SetItemText(wxTreeListItem item, const wxString& text);

    void SetItemImage(wxTreeListItem item, int closed, int opened = -1);
 
    wxPliUserDataCD *GetItemData( wxTreeListItem item ) const
      %code{% RETVAL = (wxPliUserDataCD*) THIS->GetItemData( *item ); %};   

    void SetItemData(wxTreeListItem item, wxPliUserDataCD *data);

    void Expand(wxTreeListItem item);

    void Collapse(wxTreeListItem item);

    bool IsExpanded(wxTreeListItem item) const;

    wxTreeListItem GetSelection() const;

%{

void
wxTreeListCtrl::GetSelections()
  PREINIT:
    wxTreeListItems selections;
  PPCODE:
    size_t num = THIS->GetSelections( selections );
    EXTEND( SP, (IV)num );
    for( size_t i = 0; i < num; ++i )
    {
        PUSHs( wxPli_non_object_2_sv( aTHX_ sv_newmortal(),
                                      new wxTreeListItem( selections[i] ),
                                      "Wx::TreeListItem" ) );
    }    
%}

    void Select(wxTreeListItem item);
    
    void Unselect(wxTreeListItem item);

    bool IsSelected(wxTreeListItem item) const;

    void SelectAll();

    void UnselectAll();

    void CheckItem(wxTreeListItem item, wxCheckBoxState state = wxCHK_CHECKED);

    void CheckItemRecursively(wxTreeListItem item,
                              wxCheckBoxState state = wxCHK_CHECKED);

    void UncheckItem(wxTreeListItem item);

    void UpdateItemParentStateRecursively(wxTreeListItem item);

    wxCheckBoxState GetCheckedState(wxTreeListItem item) const;

    bool AreAllChildrenInState(wxTreeListItem item,
                               wxCheckBoxState state) const;

    void SetSortColumn(unsigned col, bool ascendingOrder = true);
    
%{
void
wxTreeListCtrl::GetSortColumn()
  PREINIT:
    unsigned col;
    bool ascendingOrder;
    bool issorted;
  PPCODE:
    issorted = THIS->GetSortColumn( &col, &ascendingOrder );
    EXTEND( SP, 2 );
    if( issorted )
    {
        PUSHs( sv_2mortal( newSVuv( col ) ) );
        PUSHs( sv_2mortal( newSViv( ascendingOrder ) ) );
    }
    else {
        PUSHs( sv_newmortal() );
        PUSHs( sv_newmortal() );
    }

%}

    void SetItemComparator(wxTreeListItemComparator* comparator);

    wxWindow* GetView() const;

};

%name{Wx::TreeListEvent} class wxTreeListEvent : public %name{Wx::NotifyEvent} wxNotifyEvent
{
public:
   
    wxTreeListItem GetItem() const;

    wxCheckBoxState GetOldCheckedState() const;

    unsigned GetColumn() const;
};

#endif
