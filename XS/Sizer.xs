#############################################################################
## Name:        XS/Sizer.xs
## Purpose:     XS for Wx::Sizer and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: Sizer.xs,v 1.27 2004/08/04 20:13:55 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

%{
#include <wx/sizer.h>
#include <wx/statbox.h>
#include <wx/notebook.h>
#include "cpp/sizer.h"
%}

%module{Wx};

%typemap{wxFlexSizerGrowMode}{simple};

%name{Wx::Sizer} class wxSizer
{
    %name{ShowWindow} void Show( wxWindow* window, bool show = true );
    %name{ShowSizer} void Show( wxSizer* sizer, bool show = true );
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
};

%{
MODULE=Wx PACKAGE=Wx::Sizer

void
wxSizer::Show( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_b, ShowWindow, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wszr_b, ShowSizer, 1 )
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
wxSizer::AddWindow( window, option = 0, flag = 0, border = 0, data = 0 )
    wxWindow* window
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Add( window, option, flag, border, data );

void
wxSizer::AddSizer( sizer, option = 0, flag = 0, border = 0, data = 0 )
    wxSizer* sizer
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Add( sizer, option, flag, border, data );

void
wxSizer::AddSpace( width, height, option = 0, flag = 0, border = 0, data = 0 )
    int width
    int height
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Add( width, height, option, flag, border, data );

void
wxSizer::Clear( deleteWindows = true )
    bool deleteWindows

void
wxSizer::DeleteWindows()

wxSize*
wxSizer::CalcMin()
  CODE:
    RETVAL = new wxSize( THIS->CalcMin() );
  OUTPUT:
    RETVAL

void
wxSizer::Fit( window )
    wxWindow* window

void
wxSizer::FitInside( window )
    wxWindow* window

void
wxSizer::GetChildren()
  PPCODE:
#if WXPERL_W_VERSION_GE( 2, 5, 1 )
    wxSizerItemList::Node* node;
    const wxSizerItemList& list
#else
    wxList::Node* node;
    const wxList& list
#endif
        = THIS->GetChildren();
    
    EXTEND( SP, (IV) list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );

wxSize*
wxSizer::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

wxPoint*
wxSizer::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

wxSize*
wxSizer::GetMinSize()
  CODE:
    RETVAL = new wxSize( THIS->GetMinSize() );
  OUTPUT:
    RETVAL

void
wxSizer::Insert( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wwin_n_n_n_s, InsertWindow, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wszr_n_n_n_s, InsertSizer, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_n_n_s, InsertSpace, 3 )
    END_OVERLOAD( "Wx::Sizer::Insert" )

void
wxSizer::InsertWindow( pos, window, option = 0, flag = 0, border = 0, data = 0 )
    int pos
    wxWindow* window
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Insert( pos, window, option, flag, border, data );

void
wxSizer::InsertSizer( pos, sizer, option = 0, flag = 0, border = 0, data = 0 )
    int pos
    wxSizer* sizer
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Insert( pos, sizer, option, flag, border, data );

void
wxSizer::InsertSpace( pos, width, height, option = 0, flag = 0, border = 0, data = 0 )
    int pos
    int width
    int height
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Insert( pos, width, height, option, flag, border, data );

void
wxSizer::Layout()

void
wxSizer::Prepend( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wwin_n_n_n_s, PrependWindow, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_wszr_n_n_n_s, PrependSizer, 1 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_n_n_n_s, PrependSpace, 2 )
    END_OVERLOAD( "Wx::Sizer::Prepend" )

void
wxSizer::PrependWindow( window, option = 0, flag = 0, border = 0, data = 0 )
    wxWindow* window
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Prepend( window, option, flag, border, data );

void
wxSizer::PrependSizer( sizer, option = 0, flag = 0, border = 0, data = 0 )
    wxSizer* sizer
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Prepend( sizer, option, flag, border, data );

void
wxSizer::PrependSpace( width, height, option = 0, flag = 0, border = 0, data = 0 )
    int width
    int height
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Prepend( width, height, option, flag, border, data );

void
wxSizer::RecalcSizes()

void
wxSizer::Remove( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin, RemoveWindow )
        MATCH_REDISP( wxPliOvl_wszr, RemoveSizer )
        MATCH_REDISP( wxPliOvl_n, RemoveNth )
    END_OVERLOAD( Wx::Sizer::Remove )

bool
wxSizer::RemoveWindow( window )
    wxWindow* window
  CODE:
    RETVAL = THIS->Remove( window );
  OUTPUT:
    RETVAL

bool
wxSizer::RemoveSizer( sizer )
    wxSizer* sizer
  CODE:
    RETVAL = THIS->Remove( sizer );
  OUTPUT:
    RETVAL

bool
wxSizer::RemoveNth( nth )
    int nth
  CODE:
    RETVAL = THIS->Remove( nth );
  OUTPUT:
    RETVAL

void
wxSizer::SetDimension( x, y, width, height )
    int x
    int y
    int width
    int height

void
wxSizer::SetItemMinSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_wwin_n_n, SetItemMinSizeWindow )
        MATCH_REDISP( wxPliOvl_wszr_n_n, SetItemMinSizeSizer )
        MATCH_REDISP( wxPliOvl_n_n_n, SetItemMinSizeNth )
    END_OVERLOAD( Wx::Sizer::SetItemMinSize )

void
wxSizer::SetItemMinSizeWindow( window, width, height )
    wxWindow* window
    int width
    int height
  CODE:
    THIS->SetItemMinSize( window, width, height );

void
wxSizer::SetItemMinSizeSizer( sizer, width, height )
    wxSizer* sizer
    int width
    int height
  CODE:
    THIS->SetItemMinSize( sizer, width, height );

void
wxSizer::SetItemMinSizeNth( pos, width, height )
    int pos
    int width
    int height
  CODE:
    THIS->SetItemMinSize( pos, width, height );

void
wxSizer::SetMinSize( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, SetMinSizeXY )
        MATCH_REDISP( wxPliOvl_wsiz, SetMinSizeSize )
    END_OVERLOAD( Wx::Sizer::SetMinSize )

void
wxSizer::SetMinSizeSize( size )
    wxSize size
  CODE:
    THIS->SetMinSize( size );

void
wxSizer::SetMinSizeXY( x, y )
    int x
    int y
  CODE:
    THIS->SetMinSize( x, y );

void
wxSizer::SetSizeHints( window )
    wxWindow* window

void
wxSizer::SetVirtualSizeHints( window )
    wxWindow* window

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

MODULE=Wx PACKAGE=Wx::PlSizer

wxPlSizer*
wxPlSizer::new()
  CODE:
    RETVAL = new wxPlSizer( CLASS );
  OUTPUT:
    RETVAL

%}
