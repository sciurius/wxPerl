#############################################################################
## Name:        XS/ToolBar.xs
## Purpose:     XS for Wx::ToolBar
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: ToolBar.xs,v 1.23 2005/05/03 20:42:42 mbarbon Exp $
## Copyright:   (c) 2000-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

#include <wx/toolbar.h>
#if 0
#include <wx/tbarsmpl.h>
#endif

MODULE=Wx PACKAGE=Wx::ToolBarToolBase

void
wxToolBarToolBase::Destroy()
  CODE:
    delete THIS;

int
wxToolBarToolBase::GetId()

wxControl*
wxToolBarToolBase::GetControl()

wxToolBarBase*
wxToolBarToolBase::GetToolBar()

bool
wxToolBarToolBase::IsButton()

bool
wxToolBarToolBase::IsControl()

bool
wxToolBarToolBase::IsSeparator()

int
wxToolBarToolBase::GetStyle()

wxItemKind
wxToolBarToolBase::GetKind()

bool
wxToolBarToolBase::IsEnabled()

bool
wxToolBarToolBase::IsToggled()

bool
wxToolBarToolBase::CanBeToggled()

wxBitmap*
wxToolBarToolBase::GetNormalBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetNormalBitmap() );
  OUTPUT:
    RETVAL

wxBitmap*
wxToolBarToolBase::GetDisabledBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetDisabledBitmap() );
  OUTPUT:
    RETVAL

wxBitmap*
wxToolBarToolBase::GetBitmap1()
  CODE:
    RETVAL = new wxBitmap( THIS->GetNormalBitmap() );
  OUTPUT:
    RETVAL

wxBitmap*
wxToolBarToolBase::GetBitmap2()
  CODE:
    RETVAL = new wxBitmap( THIS->GetDisabledBitmap() );
  OUTPUT:
    RETVAL

wxBitmap*
wxToolBarToolBase::GetBitmap()
  CODE:
    RETVAL = new wxBitmap( THIS->GetBitmap() );
  OUTPUT:
    RETVAL

wxString
wxToolBarToolBase::GetLabel()

wxString
wxToolBarToolBase::GetShortHelp()

wxString
wxToolBarToolBase::GetLongHelp()

Wx_UserDataO*
wxToolBarToolBase::GetClientData()
  CODE:
    RETVAL = (Wx_UserDataO*) THIS->GetClientData();
  OUTPUT:
    RETVAL

bool
wxToolBarToolBase::Enable( enable )
    bool enable

bool
wxToolBarToolBase::Toggle( enable )
    bool enable

bool
wxToolBarToolBase::SetToggle( toggle )
    bool toggle

bool
wxToolBarToolBase::SetShortHelp( help )
    wxString help

bool
wxToolBarToolBase::SetLongHelp( help )
    wxString help

void
wxToolBarToolBase::SetNormalBitmap( bmp )
    wxBitmap* bmp
  CODE:
    THIS->SetNormalBitmap( *bmp );

void
wxToolBarToolBase::SetDisabledBitmap( bmp )
    wxBitmap* bmp
  CODE:
    THIS->SetDisabledBitmap( *bmp );

void
wxToolBarToolBase::SetLabel( label )
    wxString label

void
wxToolBarToolBase::SetBitmap1( bmp )
    wxBitmap* bmp
  CODE:
    THIS->SetNormalBitmap( *bmp );

void
wxToolBarToolBase::SetBitmap2( bmp )
    wxBitmap* bmp
  CODE:
    THIS->SetDisabledBitmap( *bmp );

void
wxToolBarToolBase::SetClientData( data = 0 )
    Wx_UserDataO* data

MODULE=Wx PACKAGE=Wx::ToolBarBase

void
wxToolBarBase::Destroy()
  CODE:
    delete THIS;

bool
wxToolBarBase::AddControl( control )
    wxControl* control

void
wxToolBar::AddSeparator()

void
wxToolBarBase::AddTool( ... )
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
wxToolBarBase::AddToolLong( toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = false, clientData = 0, shortHelp = wxEmptyString, longHelp = wxEmptyString )
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
wxToolBarBase::DeleteTool( toolId )
    int toolId

bool
wxToolBarBase::DeleteToolByPos( pos )
    size_t pos

void
wxToolBarBase::EnableTool( toolId, enable )
    int toolId
    bool enable

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxToolBarToolBase*
wxToolBarBase::FindById( toolid )
    int toolid

#endif

wxToolBarToolBase*
wxToolBarBase::FindToolForPosition( x, y )
    int x
    int y

wxSize*
wxToolBarBase::GetMargins()
  CODE:
    RETVAL = new wxSize( THIS->GetMargins() );
  OUTPUT:
    RETVAL

int
wxToolBarBase::GetMaxRows()

int
wxToolBarBase::GetMaxCols()

wxSize*
wxToolBarBase::GetToolSize()
  CODE:
    RETVAL = new wxSize( THIS->GetToolSize() );
  OUTPUT:
    RETVAL

wxSize*
wxToolBarBase::GetToolBitmapSize()
  CODE:
    RETVAL = new wxSize( THIS->GetToolBitmapSize() );
  OUTPUT:
    RETVAL

Wx_UserDataO*
wxToolBar::GetToolClientData( toolId )
    int toolId
  CODE:
    RETVAL = (Wx_UserDataO*) THIS->GetToolClientData( toolId );
  OUTPUT:
    RETVAL

bool
wxToolBarBase::GetToolEnabled( toolId )
    int toolId

wxString
wxToolBarBase::GetToolLongHelp( toolId )
    int toolId

int
wxToolBarBase::GetToolPacking()

int
wxToolBarBase::GetToolSeparation()

wxString
wxToolBarBase::GetToolShortHelp( toolId )
   int toolId

bool
wxToolBarBase::GetToolState( toolId )
    int toolId

wxToolBarToolBase*
wxToolBarBase::InsertControl( pos, control )
   size_t pos
   wxControl* control

wxToolBarToolBase*
wxToolBarBase::InsertSeparator( pos )
    size_t pos

void
wxToolBarBase::InsertTool( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_wbmp_wbmp_b_s_s_s,
                                      InsertToolLong, 3 )
        MATCH_REDISP_COUNT_ALLOWMORE( wxPliOvl_n_n_s_wbmp_wbmp_b_s_s_s,
                                      InsertToolNewLong, 4 )
    END_OVERLOAD( Wx::ToolBarBase::InsertTool )

wxToolBarToolBase*
wxToolBarBase::InsertToolLong( pos, toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = false, clientData = 0, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    size_t pos
    int toolId
    wxBitmap* bitmap1
    wxBitmap* bitmap2
    bool isToggle
    Wx_UserDataO* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->InsertTool( pos, toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( clientData )
        THIS->SetClientData( clientData );
  OUTPUT: RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

wxToolBarToolBase*
wxToolBarBase::InsertToolNewLong( pos, toolId, label, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = false, clientData = 0, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    size_t pos
    int toolId
    wxString label
    wxBitmap* bitmap1
    wxBitmap* bitmap2
    bool isToggle
    Wx_UserDataO* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->InsertTool( pos, toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( clientData )
        THIS->SetClientData( clientData );
  OUTPUT: RETVAL

#endif

bool
wxToolBarBase::Realize()

wxToolBarToolBase*
wxToolBarBase::RemoveTool( id )
    int id

void
wxToolBarBase::SetMarginsSize( size )
    wxSize size
  CODE:
    THIS->SetMargins( size );

void
wxToolBarBase::SetMarginsXY( x, y )
    int x
    int y
  CODE:
    THIS->SetMargins( x, y );

void
wxToolBarBase::SetMargins( ... )
  PPCODE:
    BEGIN_OVERLOAD()
        MATCH_REDISP( wxPliOvl_n_n, SetMarginsXY )
        MATCH_REDISP( wxPliOvl_wsiz, SetMarginsSize )
    END_OVERLOAD( Wx::ToolBarBase::SetMargins )

void
wxToolBarBase::SetMaxRowsCols( mRows, mCols )
    int mRows
    int mCols

void
wxToolBarBase::SetRows( nRows )
    int nRows

void
wxToolBarBase::SetToolBitmapSize( size )
    wxSize size

void
wxToolBarBase::SetToolClientData( id, data )
    int id
    Wx_UserDataO* data
  CODE:
    delete THIS->GetToolClientData( id );

    THIS->SetToolClientData( id, data );

void
wxToolBarBase::SetToolLongHelp( toolId, helpString )
    int toolId
    wxString helpString

void
wxToolBarBase::SetToolPacking( packing )
    int packing

void
wxToolBarBase::SetToolShortHelp( toolId, helpString )
    int toolId
    wxString helpString

void
wxToolBarBase::SetToolSeparation( separation )
    int separation

void
wxToolBarBase::ToggleTool( toolId, toggle )
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

wxToolBar*
newFull( CLASS, parent, id, pos = wxDefaultPosition, size = wxDefaultSize, style = wxTB_HORIZONTAL | wxNO_BORDER, name = wxPanelNameStr )
    PlClassName CLASS
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
    long style
    wxString name
  CODE:
    RETVAL = new wxToolBar( parent, id, pos, size, style, name );
    wxPli_create_evthandler( aTHX_ RETVAL, CLASS );
  OUTPUT: RETVAL

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
    wxWindow* parent
    wxWindowID id
    wxPoint pos
    wxSize size
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