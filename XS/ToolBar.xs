#############################################################################
## Name:        ToolBar.xs
## Purpose:     XS for Wx::ToolBar
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/toolbar.h>
#include <wx/tbarsmpl.h>

MODULE=Wx PACKAGE=Wx::ToolBarToolBase

void
Wx_ToolBarToolBase::Destroy()
  CODE:
    delete THIS;

int
Wx_ToolBarToolBase::GetId()

Wx_Control*
Wx_ToolBarToolBase::GetControl()

Wx_ToolBarBase*
Wx_ToolBarToolBase::GetToolBar()

bool
Wx_ToolBarToolBase::IsButton()

bool
Wx_ToolBarToolBase::IsControl()

bool
Wx_ToolBarToolBase::IsSeparator()

int
Wx_ToolBarToolBase::GetStyle()

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

wxItemKind
Wx_ToolBarToolBase::GetKind()

#endif

bool
Wx_ToolBarToolBase::IsEnabled()

bool
Wx_ToolBarToolBase::IsToggled()

bool
Wx_ToolBarToolBase::CanBeToggled()

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

Wx_Bitmap*
Wx_ToolBarToolBase::GetNormalBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetNormalBitmap() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_ToolBarToolBase::GetDisabledBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetDisabledBitmap() );
  OUTPUT:
    RETVAL

#endif

Wx_Bitmap*
Wx_ToolBarToolBase::GetBitmap1()
  CODE:
#if WXPERL_W_VERSION_LE( 2, 3, 2 ) || WXWIN_COMPATIBILITY_2_2
    RETVAL = new wxBitmap( THIS->GetBitmap1() );
#else
    RETVAL = new wxBitmap( THIS->GetNormalBitmap() );
#endif
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_ToolBarToolBase::GetBitmap2()
  CODE:
#if WXPERL_W_VERSION_LE( 2, 3, 2 ) || WXWIN_COMPATIBILITY_2_2
    RETVAL = new wxBitmap( THIS->GetBitmap2() );
#else
    RETVAL = new wxBitmap( THIS->GetDisabledBitmap() );
#endif
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_ToolBarToolBase::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

wxString
Wx_ToolBarToolBase::GetLabel()

#endif

wxString
Wx_ToolBarToolBase::GetShortHelp()

wxString
Wx_ToolBarToolBase::GetLongHelp()

Wx_UserDataO*
Wx_ToolBarToolBase::GetClientData()
  CODE:
    RETVAL = (Wx_UserDataO*) THIS->GetClientData();
  OUTPUT:
    RETVAL

bool
Wx_ToolBarToolBase::Enable( enable )
    bool enable

bool
Wx_ToolBarToolBase::Toggle( enable )
    bool enable

bool
Wx_ToolBarToolBase::SetToggle( toggle )
    bool toggle

bool
Wx_ToolBarToolBase::SetShortHelp( help )
    wxString help

bool
Wx_ToolBarToolBase::SetLongHelp( help )
    wxString help

#if WXPERL_W_VERSION_GE( 2, 3, 3 )

void
Wx_ToolBarToolBase::SetNormalBitmap( bmp )
    Wx_Bitmap* bmp
  CODE:
    THIS->SetNormalBitmap( *bmp );

void
Wx_ToolBarToolBase::SetDisabledBitmap( bmp )
    Wx_Bitmap* bmp
  CODE:
    THIS->SetDisabledBitmap( *bmp );

void
Wx_ToolBarToolBase::SetLabel( label )
    wxString label

#endif

void
Wx_ToolBarToolBase::SetBitmap1( bmp )
    Wx_Bitmap* bmp
  CODE:
#if WXPERL_W_VERSION_LE( 2, 3, 2 ) || WXWIN_COMPATIBILITY_2_2
    THIS->SetBitmap1( *bmp );
#else
    THIS->SetNormalBitmap( *bmp );
#endif

void
Wx_ToolBarToolBase::SetBitmap2( bmp )
    Wx_Bitmap* bmp
  CODE:
#if WXPERL_W_VERSION_LE( 2, 3, 2 ) || WXWIN_COMPATIBILITY_2_2
    THIS->SetBitmap2( *bmp );
#else
    THIS->SetDisabledBitmap( *bmp );
#endif

void
Wx_ToolBarToolBase::SetClientData( data = 0 )
    Wx_UserDataO* data

MODULE=Wx PACKAGE=Wx::ToolBarBase

void
Wx_ToolBarBase::Destroy()
  CODE:
    delete THIS;

bool
Wx_ToolBarBase::AddControl( control )
    Wx_Control* control

void
Wx_ToolBar::AddSeparator()

Wx_ToolBarToolBase*
Wx_ToolBarBase::AddToolShort( toolId, bitmap1, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    int toolId
    Wx_Bitmap* bitmap1
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->AddTool( toolId, *bitmap1, shortHelp, longHelp );
  OUTPUT:
    RETVAL

Wx_ToolBarToolBase*
Wx_ToolBarBase::AddToolLong( toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = FALSE, clientData = 0, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    int toolId
    Wx_Bitmap* bitmap1
    Wx_Bitmap* bitmap2
    bool isToggle
    Wx_UserDataO* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->AddTool( toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( clientData )
      RETVAL->SetClientData( clientData );
  OUTPUT:
    RETVAL

bool
Wx_ToolBarBase::DeleteTool( toolId )
    int toolId

bool
Wx_ToolBarBase::DeleteToolByPos( pos )
    size_t pos

void
Wx_ToolBarBase::EnableTool( toolId, enable )
    int toolId
    bool enable

Wx_ToolBarToolBase*
Wx_ToolBarBase::FindToolForPosition( x, y )
    int x
    int y

Wx_Size*
Wx_ToolBarBase::GetMargins()
  CODE:
    RETVAL = new wxSize( THIS->GetMargins() );
  OUTPUT:
    RETVAL

int
Wx_ToolBarBase::GetMaxRows()

int
Wx_ToolBarBase::GetMaxCols()

Wx_Size*
Wx_ToolBarBase::GetToolSize()
  CODE:
    RETVAL = new wxSize( THIS->GetToolSize() );
  OUTPUT:
    RETVAL

Wx_Size*
Wx_ToolBarBase::GetToolBitmapSize()
  CODE:
    RETVAL = new wxSize( THIS->GetToolBitmapSize() );
  OUTPUT:
    RETVAL

Wx_UserDataO*
Wx_ToolBar::GetToolClientData( toolId )
    int toolId
  CODE:
    RETVAL = (Wx_UserDataO*) THIS->GetToolClientData( toolId );
  OUTPUT:
    RETVAL

bool
Wx_ToolBarBase::GetToolEnabled( toolId )
    int toolId

wxString
Wx_ToolBarBase::GetToolLongHelp( toolId )
    int toolId

int
Wx_ToolBarBase::GetToolPacking()

int
Wx_ToolBarBase::GetToolSeparation()

wxString
Wx_ToolBarBase::GetToolShortHelp( toolId )
   int toolId

bool
Wx_ToolBarBase::GetToolState( toolId )
    int toolId

Wx_ToolBarToolBase*
Wx_ToolBarBase::InsertControl( pos, control )
   size_t pos
   Wx_Control* control

Wx_ToolBarToolBase*
Wx_ToolBarBase::InsertSeparator( pos )
    size_t pos

Wx_ToolBarToolBase*
Wx_ToolBarBase::InsertTool( pos, toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = FALSE, clientData = 0, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    size_t pos
    int toolId
    Wx_Bitmap* bitmap1
    Wx_Bitmap* bitmap2
    bool isToggle
    Wx_UserDataO* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->InsertTool( pos, toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( clientData )
        THIS->SetClientData( clientData );
  OUTPUT:
    RETVAL

bool
Wx_ToolBarBase::Realize()

Wx_ToolBarToolBase*
Wx_ToolBarBase::RemoveTool( id )
    int id

void
Wx_ToolBarBase::SetMarginsSize( size )
    Wx_Size size
  CODE:
    THIS->SetMargins( size );

void
Wx_ToolBarBase::SetMarginsXY( x, y )
    int x
    int y
  CODE:
    THIS->SetMargins( x, y );

void
Wx_ToolBarBase::SetMargins( size )
    Wx_Size size

void
Wx_ToolBarBase::SetMaxRowsCols( mRows, mCols )
    int mRows
    int mCols

void
Wx_ToolBarBase::SetRows( nRows )
    int nRows

void
Wx_ToolBarBase::SetToolBitmapSize( size )
    Wx_Size size

void
Wx_ToolBarBase::SetToolClientData( id, data )
    int id
    Wx_UserDataO* data
  CODE:
    delete THIS->GetToolClientData( id );

    THIS->SetToolClientData( id, data );

void
Wx_ToolBarBase::SetToolLongHelp( toolId, helpString )
    int toolId
    wxString helpString

void
Wx_ToolBarBase::SetToolPacking( packing )
    int packing

void
Wx_ToolBarBase::SetToolShortHelp( toolId, helpString )
    int toolId
    wxString helpString

void
Wx_ToolBarBase::SetToolSeparation( separation )
    int separation

void
Wx_ToolBarBase::ToggleTool( toolId, toggle )
    int toolId
    bool toggle

MODULE=Wx PACKAGE=Wx::ToolBar

Wx_ToolBar*
Wx_ToolBar::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = new wxToolBar( parent, id, pos, size, style, name );
  OUTPUT:
    RETVAL

MODULE=Wx PACKAGE=Wx::ToolBarSimple

#if wxUSE_TOOLBAR_SIMPLE

Wx_ToolBar*
Wx_ToolBarSimple::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
    Wx_Window* parent
    wxWindowID id
    Wx_Point pos
    Wx_Size size
    long style
    wxString name
  CODE:
    RETVAL = (wxToolBar*)new wxToolBarSimple( parent, id, pos, size, style,
        name );
  OUTPUT:
    RETVAL

#endif