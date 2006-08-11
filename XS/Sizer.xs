#############################################################################
## Name:        XS/Sizer.xs
## Purpose:     XS for Wx::Sizer and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: Sizer.xs,v 1.48 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2000-2003, 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%{
#include <wx/sizer.h>
#include <wx/statbox.h>
#include "cpp/sizer.h"
%}

%module{Wx};

%typemap{wxFlexSizerGrowMode}{simple};
%typemap{wxSizerItem*}{simple};
%typemap{Wx_UserDataO*}{simple};
%typemap{wxStdDialogButtonSizer*}{simple};
%typemap{wxButton*}{simple};

%name{Wx::Sizer} class wxSizer
{
#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    %name{AddWindow} wxSizerItem* Add( wxWindow* window, int option = 0,
                                       int flag = 0, int border = 0,
                                       Wx_UserDataO* data = NULL );
    %name{AddSizer} wxSizerItem* Add( wxSizer* sizer, int option = 0,
                                      int flag = 0, int border = 0,
                                      Wx_UserDataO* data = NULL );
    %name{AddSpace} wxSizerItem* Add( int width, int height, int option = 0,
                                      int flag = 0, int border = 0,
                                      Wx_UserDataO* data = NULL );

    %name{PrependWindow} wxSizerItem* Prepend( wxWindow* window,
                                               int option = 0, int flag = 0,
                                               int border = 0,
                                               Wx_UserDataO* data = NULL );
    %name{PrependSizer} wxSizerItem* Prepend( wxSizer* sizer, int option = 0,
                                              int flag = 0, int border = 0,
                                              Wx_UserDataO* data = NULL );
    %name{PrependSpace} wxSizerItem* Prepend( int width, int height,
                                              int option = 0,
                                              int flag = 0, int border = 0,
                                              Wx_UserDataO* data = NULL );

    %name{InsertWindow} wxSizerItem* Insert( int pos, wxWindow* window,
                                             int option = 0, int flag = 0,
                                             int border = 0,
                                             Wx_UserDataO* data = NULL );
    %name{InsertSizer} wxSizerItem* Insert( int pos, wxSizer* sizer,
                                            int option = 0,
                                            int flag = 0, int border = 0,
                                            Wx_UserDataO* data = NULL );
    %name{InsertSpace} wxSizerItem* Insert( int pos, int width, int height,
                                            int option = 0,
                                            int flag = 0, int border = 0,
                                            Wx_UserDataO* data = NULL );
#else
    %name{AddWindow} void Add( wxWindow* window, int option = 0,
                               int flag = 0, int border = 0,
                               Wx_UserDataO* data = NULL );
    %name{AddSizer} void Add( wxSizer* sizer, int option = 0,
                              int flag = 0, int border = 0,
                              Wx_UserDataO* data = NULL );
    %name{AddSpace} void Add( int width, int height, int option = 0,
                              int flag = 0, int border = 0,
                              Wx_UserDataO* data = NULL );

    %name{PrependWindow} void Prepend( wxWindow* window,
                                       int option = 0, int flag = 0,
                                       int border = 0,
                                       Wx_UserDataO* data = NULL );
    %name{PrependSizer} void Prepend( wxSizer* sizer, int option = 0,
                                      int flag = 0, int border = 0,
                                      Wx_UserDataO* data = NULL );
    %name{PrependSpace} void Prepend( int width, int height,
                                      int option = 0,
                                      int flag = 0, int border = 0,
                                      Wx_UserDataO* data = NULL );

    %name{InsertWindow} void Insert( int pos, wxWindow* window,
                                     int option = 0, int flag = 0,
                                     int border = 0,
                                     Wx_UserDataO* data = NULL );
    %name{InsertSizer} void Insert( int pos, wxSizer* sizer,
                                    int option = 0,
                                    int flag = 0, int border = 0,
                                    Wx_UserDataO* data = NULL );
    %name{InsertSpace} void Insert( int pos, int width, int height,
                                    int option = 0,
                                    int flag = 0, int border = 0,
                                    Wx_UserDataO* data = NULL );
#endif
#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    %name{GetItemWindow} wxSizerItem* GetItem( wxWindow* window,
                                               bool recursive = false );
    %name{GetItemSizer} wxSizerItem* GetItem( wxSizer* sizer,
                                              bool recursive = false );
    %name{GetItemNth} wxSizerItem* GetItem( size_t index );
#endif
    void RecalcSizes();
    void Clear( bool deleteWindows = true );
    void DeleteWindows();
    wxSize CalcMin();
    wxSize Fit( wxWindow* window );
    void FitInside( wxWindow* window );
    wxSize GetSize();
    wxPoint GetPosition();
    wxSize GetMinSize();
    void Layout();

#if !WXPERL_W_VERSION_GE( 2, 7, 0 ) || WXWIN_COMPATIBILITY_2_6
    %name{RemoveWindow} bool Remove( wxWindow* window );
#endif
    %name{RemoveSizer} bool Remove( wxSizer* window );
    %name{RemoveNth} bool Remove( int nth );

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    %name{DetachWindow} bool Detach( wxWindow* window );
    %name{DetachSizer} bool Detach( wxSizer* window );
    %name{DetachNth} bool Detach( int nth );
#endif

    void SetDimension( int x, int y, int width, int height );

    %name{SetItemMinSizeWindow}
    void SetItemMinSize( wxWindow* window, int width, int height );
    %name{SetItemMinSizeSizer}
    void SetItemMinSize( wxSizer* window, int width, int height );
    %name{SetItemMinSizeNth}
    void SetItemMinSize( int pos, int width, int height );

    %name{SetMinSizeSize} void SetMinSize( wxSize size );
    %name{SetMinSizeXY} void SetMinSize( int x, int y );

    void SetSizeHints( wxWindow* window );

    void SetVirtualSizeHints( wxWindow* window );

#if WXPERL_W_VERSION_GE( 2, 6, 2 )
    %name{ShowWindow} bool Show( wxWindow* window, bool show = true, bool recursive = false );
    %name{ShowSizer} bool Show( wxSizer* sizer, bool show = true, bool recursive = false );
    %name{ShowIndex} bool Show( size_t index, bool show = true );
#else
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    %name{ShowWindow} bool Show( wxWindow* window, bool show = true );
    %name{ShowSizer} bool Show( wxSizer* sizer, bool show = true );
    %name{ShowIndex} bool Show( size_t index, bool show = true );
#else
    %name{ShowWindow} void Show( wxWindow* window, bool show = true );
    %name{ShowSizer} void Show( wxSizer* sizer, bool show = true );
#endif
#endif

#if WXPERL_W_VERSION_GE( 2, 5, 4 )
    wxSizerItem* AddSpacer( int size );
    wxSizerItem* AddStretchSpacer( int prop = 1 );

    wxSizerItem* InsertSpacer( size_t index, int size );
    wxSizerItem* InsertStretchSpacer( size_t index, int prop = 1 );

    wxSizerItem* PrependSpacer( int size );
    wxSizerItem* PrependStretchSpacer( int prop = 1 );
#else // for xsubpp
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    void AddSpacer( int size );
    void AddStretchSpacer( int prop = 1 );

    void InsertSpacer( size_t index, int size );
    void InsertStretchSpacer( size_t index, int prop = 1 );

    void PrependSpacer( int size );
    void PrependStretchSpacer( int prop = 1 );
#endif
#endif
};

%name{Wx::FlexGridSizer} class wxFlexGridSizer
{
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    void AddGrowableCol( size_t index, int proportion = 0 );
    void AddGrowableRow( size_t index, int proportion = 0 );

    void SetFlexibleDirection( int direction );
    int GetFlexibleDirection();

    void SetNonFlexibleGrowMode(wxFlexSizerGrowMode mode);
    wxFlexSizerGrowMode GetNonFlexibleGrowMode();
#else
    void AddGrowableCol( size_t index );
    void AddGrowableRow( size_t index );
#endif
};

%name{Wx::SizerItem} class wxSizerItem
{
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    %name{GetOption} int GetProportion();
    %name{SetOption} void SetProportion( int option );
    int GetProportion();
    void SetProportion( int proportion );
#else
    %name{GetProportion} int GetOption();
    %name{SetProportion} void SetOption( int proportion );
    int GetOption();
    void SetOption( int option );
#endif
#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    %name{SetMinSizeWH} void SetMinSize( int x, int y );
    %name{SetMinSizeSize} void SetMinSize( wxSize size );
#endif
};

#if WXPERL_W_VERSION_GE( 2, 6, 1 )

%name{Wx::StdDialogButtonSizer} class wxStdDialogButtonSizer
{
    wxStdDialogButtonSizer();

    void AddButton( wxButton* button );

    void SetAffirmativeButton( wxButton* button );
    void SetNegativeButton( wxButton* button );
    void SetCancelButton( wxButton* button );

    void Realize();

    wxButton *GetAffirmativeButton() const;
    wxButton *GetApplyButton() const;
    wxButton *GetNegativeButton() const;
    wxButton *GetCancelButton() const;
    wxButton *GetHelpButton() const;
};

#endif

%{
MODULE=Wx PACKAGE=Wx::Sizer

void
wxSizer::Show( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_b, ShowWindow, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wszr_b, ShowSizer, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_b, ShowIndex, 1 )
    END_OVERLOAD( Wx::Sizer::Show )

void
wxSizer::Destroy()
  CODE:
    delete THIS;

void
wxSizer::Add( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_n_n_n_s, AddWindow, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wszr_n_n_n_s, AddSizer, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_n_s, AddSpace, 2 )
    END_OVERLOAD( Wx::Sizer::Add )

void
wxSizer::GetChildren()
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    wxSizerItemList::compatibility_iterator node;
    const wxSizerItemList& list
#else
    wxList::compatibility_iterator node;
    const wxList& list
#endif
        = THIS->GetChildren();
    
    EXTEND( SP, (IV) list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );

void
wxSizer::Insert( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wwin_n_n_n_s, InsertWindow, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wszr_n_n_n_s, InsertSizer, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_n_n_s, InsertSpace, 3 )
    END_OVERLOAD( "Wx::Sizer::Insert" )

void
wxSizer::Prepend( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_n_n_n_s, PrependWindow, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wszr_n_n_n_s, PrependSizer, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_n_s, PrependSpace, 2 )
    END_OVERLOAD( "Wx::Sizer::Prepend" )

void
wxSizer::Remove( ... )
  PPCODE:
    BEGIN_OVERLOAD()
#if !WXPERL_W_VERSION_GE( 2, 7, 0 )|| WXWIN_COMPATIBILITY_2_6
        MATCH_REDISP( wxPliOvl_wwin, RemoveWindow )
#endif
        MATCH_REDISP( wxPliOvl_wszr, RemoveSizer )
        MATCH_REDISP( wxPliOvl_n, RemoveNth )
    END_OVERLOAD( Wx::Sizer::Remove )

void
wxSizer::Detach( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin, DetachWindow )
        MATCH_REDISP( wxPliOvl_wszr, DetachSizer )
        MATCH_REDISP( wxPliOvl_n, DetachNth )
    END_OVERLOAD( Wx::Sizer::Detach )

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

void
wxSizer::GetItem( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_s, GetItemWindow )
        MATCH_REDISP( wxPliOvl_wszr_s, GetItemSizer )
        MATCH_REDISP( wxPliOvl_n, GetItemNth )
    END_OVERLOAD( Wx::Sizer::GetItem )

#endif

void
wxSizer::SetItemMinSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_n_n, SetItemMinSizeWindow )
        MATCH_REDISP( wxPliOvl_wszr_n_n, SetItemMinSizeSizer )
        MATCH_REDISP( wxPliOvl_n_n_n, SetItemMinSizeNth )
    END_OVERLOAD( Wx::Sizer::SetItemMinSize )

void
wxSizer::SetMinSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, SetMinSizeXY )
        MATCH_REDISP( wxPliOvl_wsiz, SetMinSizeSize )
    END_OVERLOAD( Wx::Sizer::SetMinSize )

MODULE=Wx PACKAGE=Wx::BoxSizer

wxBoxSizer*
wxBoxSizer::new( orientation )
    int orientation

int
wxBoxSizer::GetOrientation()

MODULE=Wx PACKAGE=Wx::StaticBoxSizer

wxStaticBoxSizer*
wxStaticBoxSizer::new( box, orient )
    wxStaticBox* box
    int orient

wxStaticBox*
wxStaticBoxSizer::GetStaticBox()

MODULE=Wx PACKAGE=Wx::NotebookSizer

#include <wx/notebook.h>

wxNotebookSizer*
wxNotebookSizer::new( notebook )
    wxNotebook* notebook

wxNotebook*
wxNotebookSizer::GetNotebook()

MODULE=Wx PACKAGE=Wx::GridSizer

wxGridSizer*
wxGridSizer::new( rows, cols, vgap = 0, hgap = 0 )
    int rows
    int cols
    int vgap
    int hgap

int
wxGridSizer::GetCols()

int
wxGridSizer::GetHGap()

int
wxGridSizer::GetRows()

int
wxGridSizer::GetVGap()

void
wxGridSizer::SetCols( cols )
    int cols

void
wxGridSizer::SetHGap( gap )
    int gap

void
wxGridSizer::SetRows( rows )
    int rows

void
wxGridSizer::SetVGap( gap )
   int gap

MODULE=Wx PACKAGE=Wx::FlexGridSizer

wxFlexGridSizer*
wxFlexGridSizer::new( rows, cols, vgap = 0, hgap = 0 )
    int rows
    int cols
    int vgap
    int hgap

void
wxFlexGridSizer::RemoveGrowableCol( index )
    size_t index

void
wxFlexGridSizer::RemoveGrowableRow( index )
    int index

MODULE=Wx PACKAGE=Wx::SizerItem

wxSize*
wxSizerItem::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

wxSize*
wxSizerItem::CalcMin()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
wxSizerItem::SetDimension( pos, size )
    wxPoint pos
    wxSize size

wxSize*
wxSizerItem::GetMinSize()
  CODE:
    RETVAL = new wxSize( THIS->GetMinSize() );
  OUTPUT:
    RETVAL

void
wxSizerItem::SetRatio( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT( wxPliOvl_n, SetRatioFloat, 1 )
        MATCH_REDISP_COUNT( wxPliOvl_n_n, SetRatioWH, 2 )
        MATCH_REDISP_COUNT( wxPliOvl_wsiz, SetRatioSize, 1 )
    END_OVERLOAD( Wx::SizerItem::SetRatio )

void
wxSizerItem::SetRatioWH( width, height )
    int width
    int height
  CODE:
    THIS->SetRatio( width, height );

void
wxSizerItem::SetRatioSize( size )
    wxSize size
  CODE:
    THIS->SetRatio( size );

void
wxSizerItem::SetRatioFloat( ratio )
    float ratio
  CODE:
    THIS->SetRatio( ratio );

float
wxSizerItem::GetRatio()

bool
wxSizerItem::IsWindow()

bool
wxSizerItem::IsShown()

bool
wxSizerItem::IsSizer()

bool
wxSizerItem::IsSpacer()

void
wxSizerItem::SetInitSize( x, y )
    int x
    int y

void
wxSizerItem::SetFlag( flag )
    int flag

void
wxSizerItem::SetBorder( border )
    int border

wxWindow*
wxSizerItem::GetWindow()

void
wxSizerItem::SetWindow( window )
    wxWindow* window

wxSizer*
wxSizerItem::GetSizer()

void
wxSizerItem::SetSizer( sizer )
    wxSizer* sizer

int
wxSizerItem::GetFlag()

int
wxSizerItem::GetBorder()

wxPoint*
wxSizerItem::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

Wx_UserDataO*
wxSizerItem::GetUserData()
  CODE:
    RETVAL = (Wx_UserDataO*) THIS->GetUserData();
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 6, 3 )

void
wxSizerItem::SetUserData( data )
    Wx_UserDataO* data

#endif

void
wxSizerItem::SetMinSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT( wxPliOvl_n_n, SetMinSizeWH, 2 )
        MATCH_REDISP_COUNT( wxPliOvl_wsiz, SetMinSizeSize, 1 )
    END_OVERLOAD( Wx::SizerItem::SetMinSize )


MODULE=Wx PACKAGE=Wx::PlSizer

wxPlSizer*
wxPlSizer::new()
  CODE:
    RETVAL = new wxPlSizer( CLASS );
  OUTPUT:
    RETVAL

%}
