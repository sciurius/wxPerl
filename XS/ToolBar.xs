#############################################################################
## Name:        XS/ToolBar.xs
## Purpose:     XS for Wx::ToolBar
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: ToolBar.xs,v 1.18 2003/08/22 22:21:57 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/toolbar.h>
#if 0
#include <wx/tbarsmpl.h>
#endif

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

wxItemKind
Wx_ToolBarToolBase::GetKind()

bool
Wx_ToolBarToolBase::IsEnabled()

bool
Wx_ToolBarToolBase::IsToggled()

bool
Wx_ToolBarToolBase::CanBeToggled()

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

Wx_Bitmap*
Wx_ToolBarToolBase::GetBitmap1()
  CODE:
    RETVAL = new wxBitmap( THIS->GetNormalBitmap() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_ToolBarToolBase::GetBitmap2()
  CODE:
    RETVAL = new wxBitmap( THIS->GetDisabledBitmap() );
  OUTPUT:
    RETVAL

Wx_Bitmap*
Wx_ToolBarToolBase::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

wxString
Wx_ToolBarToolBase::GetLabel()

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

void
Wx_ToolBarToolBase::SetBitmap1( bmp )
    Wx_Bitmap* bmp
  CODE:
    THIS->SetNormalBitmap( *bmp );

void
Wx_ToolBarToolBase::SetBitmap2( bmp )
    Wx_Bitmap* bmp
  CODE:
    THIS->SetDisabledBitmap( *bmp );

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

void
Wx_ToolBarBase::AddTool( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wbmp_wbmp_b_s_s_s,
                                      AddToolLong, 3 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_wbmp_s_s, AddToolShort, 2 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_s_wbmp_wbmp_n_s_s_s,
                                      AddToolNewLong, 3 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_s_wbmp_s_n,
                                      AddToolNewShort, 3 )
    END_OVERLOAD( Wx::ToolBarBase::AddTool )

wxToolBarToolBase*
wxToolBarBase::AddToolShort( toolId, bitmap1, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    int toolId
    wxBitmap* bitmap1
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->AddTool( toolId, *bitmap1, shortHelp, longHelp );
  OUTPUT:
    RETVAL

wxToolBarToolBase*
wxToolBarBase::AddToolLong( toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = FALSE, clientData = 0, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    int toolId
    wxBitmap* bitmap1
    wxBitmap* bitmap2
    bool isToggle
    wxPliUserDataO* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->AddTool( toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( clientData )
      RETVAL->SetClientData( clientData );
  OUTPUT:
    RETVAL

wxToolBarToolBase*
wxToolBarBase::AddToolNewLong( toolId, label, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, kind = wxITEM_NORMAL, shortHelp = wxEmptyString, longHelp = wxEmptyString, clientData = 0 )
    int toolId
    wxString label
    wxBitmap* bitmap1
    wxBitmap* bitmap2
    wxItemKind kind
    wxString shortHelp
    wxString longHelp
    wxPliUserDataO* clientData
  CODE:
    RETVAL = THIS->AddTool( toolId, label, *bitmap1, *bitmap2, kind,
                            shortHelp, longHelp );
    if( clientData )
        RETVAL->SetClientData( clientData );
  OUTPUT: RETVAL

wxToolBarToolBase*
wxToolBarBase::AddToolNewShort( toolId, label, bitmap, shortHelp = wxEmptyString, kind = wxITEM_NORMAL )
    int toolId
    wxString label
    wxBitmap* bitmap
    wxString shortHelp
    wxItemKind kind
  CODE:
    RETVAL = THIS->AddTool( toolId, label, *bitmap, shortHelp, kind );
  OUTPUT: RETVAL

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
Wx_ToolBarBase::SetMargins( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, SetMarginsXY )
        MATCH_REDISP( wxPliOvl_wsiz, SetMarginsSize )
    END_OVERLOAD( Wx::ToolBarBase::SetMargins )

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

void
new( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_VOIDM_REDISP( newDefault )
        MATCH_ANY_REDISP( newFull )
    END_OVERLOAD( "Wx::ToolBar::new" )

wxToolBar*
newDefault( CLASS )
    PlClassName CLASS
  CODE:
    RETVAL = new wxToolBar();
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

Wx_ToolBar*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
    PlClassName CLASS
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

bool
wxToolBar::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

MODULE=Wx PACKAGE=Wx::ToolBarSimple

## deprecated: and who uses it, anyway?
#if 0 && wxUSE_TOOLBAR_SIMPLE

wxToolBar*
wxToolBarSimple::new( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
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

bool
wxToolBarSimple::Create( parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name

#endif