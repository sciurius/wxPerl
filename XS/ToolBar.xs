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

MODULE=Wx PACKAGE=Wx::ToolBarToolBase

void
Wx_ToolBarToolBase::Destroy()
  CODE:
    delete THIS;

MODULE=Wx PACKAGE=Wx::ToolBarBase

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
Wx_ToolBarBase::AddToolLong( toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = FALSE, clientData = &PL_sv_undef, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    int toolId
    Wx_Bitmap* bitmap1
    Wx_Bitmap* bitmap2
    bool isToggle
    SV* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->AddTool( toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( !SvOK( clientData ) )
    {
      SV* newdata = sv_newmortal();
      sv_setsv( newdata, clientData );
      RETVAL->SetClientData( new _wxUserDataO( newdata ) );
    }
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
    float x
    float y

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

void
Wx_ToolBar::GetToolClientData( toolId )
    int toolId
  PREINIT:
    _wxUserDataO* ud;
  PPCODE:
    if( ( ud = (_wxUserDataO*) THIS->GetClientObject() ) )
    {
      SvREFCNT_inc( ud->m_data );
      XPUSHs( ud->m_data );
    }
    else
    {
      XPUSHs( &PL_sv_undef );
    }

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
Wx_ToolBarBase::InsertTool( pos, toolId, bitmap1, bitmap2 = (wxBitmap*)&wxNullBitmap, isToggle = FALSE, clientData = &PL_sv_undef, shortHelp = wxEmptyString, longHelp = wxEmptyString )
    size_t pos
    int toolId
    Wx_Bitmap* bitmap1
    Wx_Bitmap* bitmap2
    bool isToggle
    SV* clientData
    wxString shortHelp
    wxString longHelp
  CODE:
    RETVAL = THIS->InsertTool( pos, toolId, *bitmap1, *bitmap2, isToggle,
        0, shortHelp, longHelp );
    if( !SvOK( clientData ) )
    {
      SV* newdata = sv_newmortal();
      sv_setsv( newdata, clientData );
      THIS->SetClientData( new _wxUserDataO( newdata ) );
    }
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
    SV* data
  CODE:
    delete THIS->GetToolClientData( id );

    if( data == &PL_sv_undef )
    {
      THIS->SetToolClientData( id, 0 );
    }
    else
    {
      SV* newdata = sv_newmortal();
      sv_setsv( newdata, data );
      THIS->SetToolClientData( id, new _wxUserDataO( newdata ) );
    }

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
