#############################################################################
## Name:        Sizer.xs
## Purpose:     XS for Wx::Sizer and derived classes
## Author:      Mattia Barbon
## Modified by:
## Created:     31/10/2000
## RCS-ID:      $Id: Sizer.xs,v 1.16 2003/05/11 20:04:49 mbarbon Exp $
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
    %name{ShowWindow} void Show( wxWindow* window, bool show = TRUE );
    %name{ShowSizer} void Show( wxSizer* sizer, bool show = TRUE );
};

%name{Wx::FlexGridSizer} class wxFlexGridSizer
{
#if WXPERL_W_VERSION_GE( 2, 5, 0 )
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
Wx_Sizer::Destroy()
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
Wx_Sizer::AddWindow( window, option = 0, flag = 0, border = 0, data = 0 )
    Wx_Window* window
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Add( window, option, flag, border, data );

void
Wx_Sizer::AddSizer( sizer, option = 0, flag = 0, border = 0, data = 0 )
    Wx_Sizer* sizer
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Add( sizer, option, flag, border, data );

void
Wx_Sizer::AddSpace( width, height, option = 0, flag = 0, border = 0, data = 0 )
    int width
    int height
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Add( width, height, option, flag, border, data );

void
Wx_Sizer::Clear( deleteWindows = TRUE )
    bool deleteWindows

void
Wx_Sizer::DeleteWindows()

Wx_Size*
Wx_Sizer::CalcMin()
  CODE:
    RETVAL = new wxSize( THIS->CalcMin() );
  OUTPUT:
    RETVAL

void
Wx_Sizer::Fit( window )
    Wx_Window* window

void
Wx_Sizer::FitInside( window )
    Wx_Window* window

void
Wx_Sizer::GetChildren()
  PPCODE:
    const wxList& list = THIS->GetChildren();
    wxNode* node;
    
    EXTEND( SP, (IV) list.GetCount() );

    for( node = list.GetFirst(); node; node = node->GetNext() )
      PUSHs( wxPli_object_2_sv( aTHX_ sv_newmortal(), node->GetData() ) );

Wx_Size*
Wx_Sizer::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

Wx_Point*
Wx_Sizer::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_Sizer::GetMinSize()
  CODE:
    RETVAL = new wxSize( THIS->GetMinSize() );
  OUTPUT:
    RETVAL

void
Wx_Sizer::InsertWindow( pos, window, option = 0, flag = 0, border = 0, data = 0 )
    int pos
    Wx_Window* window
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Insert( pos, window, option, flag, border, data );

void
Wx_Sizer::InsertSizer( pos, sizer, option = 0, flag = 0, border = 0, data = 0 )
    int pos
    Wx_Sizer* sizer
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Insert( pos, sizer, option, flag, border, data );

void
Wx_Sizer::InsertSpace( pos, width, height, option = 0, flag = 0, border = 0, data = 0 )
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
Wx_Sizer::Layout()

void
Wx_Sizer::PrependWindow( window, option = 0, flag = 0, border = 0, data = 0 )
    Wx_Window* window
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Prepend( window, option, flag, border, data );

void
Wx_Sizer::PrependSizer( sizer, option = 0, flag = 0, border = 0, data = 0 )
    Wx_Sizer* sizer
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Prepend( sizer, option, flag, border, data );

void
Wx_Sizer::PrependSpace( width, height, option = 0, flag = 0, border = 0, data = 0 )
    int width
    int height
    int option
    int flag
    int border
    Wx_UserDataO* data
  CODE:
    THIS->Prepend( width, height, option, flag, border, data );

void
Wx_Sizer::RecalcSizes()

bool
Wx_Sizer::RemoveWindow( window )
    Wx_Window* window
  CODE:
    RETVAL = THIS->Remove( window );
  OUTPUT:
    RETVAL

bool
Wx_Sizer::RemoveSizer( sizer )
    Wx_Sizer* sizer
  CODE:
    RETVAL = THIS->Remove( sizer );
  OUTPUT:
    RETVAL

bool
Wx_Sizer::RemoveNth( nth )
    int nth
  CODE:
    RETVAL = THIS->Remove( nth );
  OUTPUT:
    RETVAL

void
Wx_Sizer::SetDimension( x, y, width, height )
    int x
    int y
    int width
    int height

void
Wx_Sizer::SetItemMinSizeWindow( window, width, height )
    Wx_Window* window
    int width
    int height
  CODE:
    THIS->SetItemMinSize( window, width, height );

void
Wx_Sizer::SetItemMinSizeSizer( sizer, width, height )
    Wx_Sizer* sizer
    int width
    int height
  CODE:
    THIS->SetItemMinSize( sizer, width, height );

void
Wx_Sizer::SetItemMinSizeNth( pos, width, height )
    int pos
    int width
    int height
  CODE:
    THIS->SetItemMinSize( pos, width, height );

void
Wx_Sizer::SetMinSizeSize( size )
    Wx_Size size
  CODE:
    THIS->SetMinSize( size );

void
Wx_Sizer::SetMinSizeXY( x, y )
    int x
    int y
  CODE:
    THIS->SetMinSize( x, y );

void
Wx_Sizer::SetSizeHints( window )
    Wx_Window* window

void
Wx_Sizer::SetVirtualSizeHints( window )
    Wx_Window* window

MODULE=Wx PACKAGE=Wx::BoxSizer

Wx_BoxSizer*
Wx_BoxSizer::new( orientation )
    int orientation

int
Wx_BoxSizer::GetOrientation()

MODULE=Wx PACKAGE=Wx::StaticBoxSizer

Wx_StaticBoxSizer*
Wx_StaticBoxSizer::new( box, orient )
    Wx_StaticBox* box
    int orient

Wx_StaticBox*
Wx_StaticBoxSizer::GetStaticBox()

MODULE=Wx PACKAGE=Wx::NotebookSizer

Wx_NotebookSizer*
Wx_NotebookSizer::new( notebook )
    Wx_Notebook* notebook

Wx_Notebook*
Wx_NotebookSizer::GetNotebook()

MODULE=Wx PACKAGE=Wx::GridSizer

Wx_GridSizer*
Wx_GridSizer::new( rows, cols, vgap = 0, hgap = 0 )
    int rows
    int cols
    int vgap
    int hgap

int
Wx_GridSizer::GetCols()

int
Wx_GridSizer::GetHGap()

int
Wx_GridSizer::GetRows()

int
Wx_GridSizer::GetVGap()

void
Wx_GridSizer::SetCols( cols )
    int cols

void
Wx_GridSizer::SetHGap( gap )
    int gap

void
Wx_GridSizer::SetRows( rows )
    int rows

void
Wx_GridSizer::SetVGap( gap )
   int gap

MODULE=Wx PACKAGE=Wx::FlexGridSizer

Wx_FlexGridSizer*
Wx_FlexGridSizer::new( rows, cols, vgap = 0, hgap = 0 )
    int rows
    int cols
    int vgap
    int hgap

void
Wx_FlexGridSizer::RemoveGrowableCol( index )
    size_t index

void
Wx_FlexGridSizer::RemoveGrowableRow( index )
    int index

MODULE=Wx PACKAGE=Wx::SizerItem

Wx_Size*
Wx_SizerItem::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_SizerItem::CalcMin()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

void
Wx_SizerItem::SetDimension( pos, size )
    Wx_Point pos
    Wx_Size size

Wx_Size*
Wx_SizerItem::GetMinSize()
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
Wx_SizerItem::SetRatioWH( width, height )
    int width
    int height
  CODE:
    THIS->SetRatio( width, height );

void
Wx_SizerItem::SetRatioSize( size )
    Wx_Size size
  CODE:
    THIS->SetRatio( size );

void
Wx_SizerItem::SetRatioFloat( ratio )
    float ratio
  CODE:
    THIS->SetRatio( ratio );

float
Wx_SizerItem::GetRatio()

bool
Wx_SizerItem::IsWindow()

bool
Wx_SizerItem::IsSizer()

bool
Wx_SizerItem::IsSpacer()

void
Wx_SizerItem::SetInitSize( x, y )
    int x
    int y

void
Wx_SizerItem::SetOption( option )
    int option

void
Wx_SizerItem::SetFlag( flag )
    int flag

void
Wx_SizerItem::SetBorder( border )
    int border

Wx_Window*
Wx_SizerItem::GetWindow()

void
Wx_SizerItem::SetWindow( window )
    Wx_Window* window

Wx_Sizer*
Wx_SizerItem::GetSizer()

void
Wx_SizerItem::SetSizer( sizer )
    Wx_Sizer* sizer

int
Wx_SizerItem::GetOption()

int
Wx_SizerItem::GetFlag()

int
Wx_SizerItem::GetBorder()

Wx_Point*
Wx_SizerItem::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

Wx_UserDataO*
Wx_SizerItem::GetUserData()
  CODE:
    RETVAL = (Wx_UserDataO*) THIS->GetUserData();
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::PlSizer

Wx_PlSizer*
Wx_PlSizer::new()
  CODE:
    RETVAL = new wxPlSizer( CLASS );
  OUTPUT:
    RETVAL

%}
