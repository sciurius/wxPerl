/////////////////////////////////////////////////////////////////////////////
// Name:        Event.xs
// Purpose:     XS for Wx::EvtHandler, Wx::Event and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool

#include <wx/defs.h>

#include <wx/event.h>
#include <wx/notebook.h>
#include <wx/spinctrl.h>
#include <wx/sashwin.h>
#include <wx/dc.h>
#include <wx/splitter.h>
#include <wx/textctrl.h>
#include <wx/listctrl.h>
#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#undef THIS

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#ifdef __WXMSW__
#include <wx/msw/winundef.h>
#endif // __WXMSW__

#include "cpp/compat.h"
#include "cpp/typedef.h"
#include "cpp/helpers.h"

#include "cpp/e_cback.h"
#include "cpp/e_cback.cpp"

#include "cpp/evthandler.h"

MODULE=Wx_Evt

INCLUDE: XS/EvtHandler.xs

MODULE=Wx_Evt PACKAGE=Wx::Event

#FIXME// unimplemented
# GetEventObject
# GetObjectType
# SetEventObject

Wx_Event*
Wx_Event::new( id = 0 )
    int id

# void
# Wx_Event::DESTROY()

void
Wx_Event::Destroy()
  CODE:
    delete THIS;

wxEventType
Wx_Event::GetEventType()

int
Wx_Event::GetId()

bool
Wx_Event::GetSkipped()

long
Wx_Event::GetTimestamp()

void
Wx_Event::SetEventType( type )
    wxEventType type

void
Wx_Event::SetId( id )
    int id

void
Wx_Event::SetTimestamp( timeStamp )
    long timeStamp

void
Wx_Event::Skip( skip = TRUE )
    bool skip

MODULE=Wx_Evt PACKAGE=Wx::CommandEvent

Wx_CommandEvent*
Wx_CommandEvent::new( type = 0, id = 0 )
    wxEventType type
    int id

void
Wx_CommandEvent::GetClientData()
  PREINIT:
    _wxUserDataCD* ud;
  PPCODE:
    if( ( ud = (_wxUserDataCD*) THIS->GetClientObject() ) )
    {
      SvREFCNT_inc( ud->m_data );
      XPUSHs( ud->m_data );
    }
    else
    {
      XPUSHs( &PL_sv_undef );
    }

long
Wx_CommandEvent::GetExtraLong()

int
Wx_CommandEvent::GetInt()

int
Wx_CommandEvent::GetSelection()

const char*
Wx_CommandEvent::GetString()

bool
Wx_CommandEvent::IsChecked()

bool
Wx_CommandEvent::IsSelection()

void
Wx_CommandEvent::SetClientData( data )
    SV* data
  CODE:
    if( !SvOK( data ) )
    {
      THIS->SetClientObject( 0 );
    }
    else
    {
      SV* newdata = sv_newmortal();
      sv_setsv( newdata, data );
      THIS->SetClientObject( new _wxUserDataCD( newdata ) );
    }

void
Wx_CommandEvent::SetExtraLong( extraLong )
    long extraLong

void
Wx_CommandEvent::SetInt( intCommand )
    int intCommand

void
Wx_CommandEvent::SetString( string )
    const char* string

MODULE=Wx_Evt PACKAGE=Wx::ActivateEvent

# Wx_ActivateEvent*
# Wx_ActivateEvent::new( type = 0, active = TRUE, id = 0 )
#     wxEventType type
#     bool active
#     int id

bool
Wx_ActivateEvent::GetActive()

MODULE=Wx_Evt PACKAGE=Wx::CloseEvent

# Wx_CloseEvent*
# Wx_CloseEvent::new( commandEventType = 0, id = 0 )
#     wxEventType commandEventType
#     int id

bool
Wx_CloseEvent::CanVeto()

bool
Wx_CloseEvent::GetLoggingOff()

void
Wx_CloseEvent::SetCanVeto( canVeto )
    bool canVeto

void
Wx_CloseEvent::SetLoggingOff( loggingOff )
    bool loggingOff

void
Wx_CloseEvent::Veto( veto = TRUE )
    bool veto

MODULE=Wx_Evt PACKAGE=Wx::DropFilesEvent

void
Wx_DropFilesEvent::GetFiles()
  PPCODE:
    wxString* files = THIS->GetFiles();
    int i, max = THIS->GetNumberOfFiles();
    EXTEND( SP, max );
    for( i = 0; i < max; ++i )
    {
      PUSHs( sv_2mortal( newSVpv( CHAR_P files[i].c_str(), 0 ) ) );
    }

int
Wx_DropFilesEvent::GetNumberOfFiles()

Wx_Point*
Wx_DropFilesEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::EraseEvent

#FIXME// unimplemented
# GetPosition

# Wx_EraseEvent*
# Wx_EraseEvent::new( id = 0, dc = 0 )
#     int id
#     Wx_DC* dc

Wx_DC*
Wx_EraseEvent::GetDC()

MODULE=Wx_Evt PACKAGE=Wx::FocusEvent

# Wx_FocusEvent*
# Wx_FocusEvent::new( eventType = 0, id = 0 )
#     wxEventType eventType
#     int id

MODULE=Wx_Evt PACKAGE=Wx::KeyEvent

# Wx_KeyEvent*
# Wx_KeyEvent::new( keyEventType )
#     wxEventType keyEventType

bool
Wx_KeyEvent::AltDown()

bool
Wx_KeyEvent::ControlDown()

int
Wx_KeyEvent::GetKeyCode()

long
Wx_KeyEvent::GetX()

long
Wx_KeyEvent::GetY()

bool
Wx_KeyEvent::MetaDown()

bool
Wx_KeyEvent::HasModifiers()

bool
Wx_KeyEvent::ShiftDown()

MODULE=Wx_Evt PACKAGE=Wx::HelpEvent

# Wx_HelpEvent::new()

#if WXPERL_W_VERSION_GE( 2, 3 )

Wx_Point*
Wx_HelpEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

wxString
Wx_HelpEvent::GetLink()

wxString
Wx_HelpEvent::GetTarget()

void
Wx_HelpEvent::SetPosition( point )
    Wx_Point point

void
Wx_HelpEvent::SetLink( link )
    wxString link

void
Wx_HelpEvent::SetTarget( target )
    wxString target

#endif

MODULE=Wx_Evt PACKAGE=Wx::IdleEvent

# Wx_IdleEvent*
# Wx_IdleEvent::new()

bool
Wx_IdleEvent::MoreRequested()

void
Wx_IdleEvent::RequestMore( needMore = TRUE )
    bool needMore

MODULE=Wx_Evt PACKAGE=Wx::InitDialogEvent

# Wx_InitDialogEvent*
# Wx_InitDialogEvent::new( id = 0 )
#     int id

MODULE=Wx_Evt PACKAGE=Wx::JoystickEvent

# Wx_JoystickEvent*
# Wx_JoystickEvent::new( eventType = 0, state = 0, joystick = wxJOYSTICK1, change = 0 )
#     wxEventType eventType
#     int state
#     int joystick
#     int change

bool
Wx_JoystickEvent::ButtonDown( button = wxJOY_BUTTON_ANY )
    int button

bool
Wx_JoystickEvent::ButtonIsDown( button = wxJOY_BUTTON_ANY )
    int button

bool
Wx_JoystickEvent::ButtonUp( button = wxJOY_BUTTON_ANY )
    int button

int
Wx_JoystickEvent::GetButtonChange()

int
Wx_JoystickEvent::GetButtonState()

int
Wx_JoystickEvent::GetJoystick()

Wx_Point*
Wx_JoystickEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

int
Wx_JoystickEvent::GetZPosition()

bool
Wx_JoystickEvent::IsButton()

bool
Wx_JoystickEvent::IsMove()

bool
Wx_JoystickEvent::IsZMove()

MODULE=Wx_Evt PACKAGE=Wx::ListEvent

int
Wx_ListEvent::GetCode()

long
Wx_ListEvent::GetIndex()

long
Wx_ListEvent::GetOldIndex()

int
Wx_ListEvent::GetColumn()

bool
Wx_ListEvent::Cancelled()

Wx_Point*
Wx_ListEvent::GetPoint()
  CODE:
    RETVAL = new wxPoint( THIS->GetPoint() );
  OUTPUT:
    RETVAL

wxString
Wx_ListEvent::GetLabel()

wxString
Wx_ListEvent::GetText()

int
Wx_ListEvent::GetImage()

long
Wx_ListEvent::GetData()

long
Wx_ListEvent::GetMask()

Wx_ListItem*
Wx_ListEvent::GetItem()
  CODE:
    RETVAL = new wxListItem( THIS->GetItem() );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::MenuEvent

# Wx_MenuEvent*
# Wx_MenuEvent::new( eventType = 0, id = 0 )
#     wxEventType eventType
#     int id

int
Wx_MenuEvent::GetMenuId()

MODULE=Wx_Evt PACKAGE=Wx::MouseEvent

# Wx_MouseEvent*
# Wx_MouseEvent::new( eventType = 0 )
#     wxEventType eventType

bool
Wx_MouseEvent::AltDown()

bool
Wx_MouseEvent::Button( button = -1 )
    int button

bool
Wx_MouseEvent::ButtonDClick( button = -1 )
    int button

bool
Wx_MouseEvent::ButtonDown( button = -1 )
    int button

bool
Wx_MouseEvent::ButtonUp( button = -1 )
    int button

bool
Wx_MouseEvent::ControlDown()

bool
Wx_MouseEvent::Dragging()

bool
Wx_MouseEvent::Entering()

Wx_Point*
Wx_MouseEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

void
Wx_MouseEvent::GetPositionXY()
  PREINIT:
    long x;
    long y;
  PPCODE:
    THIS->GetPosition( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

Wx_Point*
Wx_MouseEvent::GetLogicalPosition( dc )
    Wx_DC* dc
  CODE:
    RETVAL = new wxPoint( THIS->GetLogicalPosition( *dc ) );
  OUTPUT:
    RETVAL

long
Wx_MouseEvent::GetX()

long
Wx_MouseEvent::GetY()

bool
Wx_MouseEvent::IsButton()

bool
Wx_MouseEvent::Leaving()

bool
Wx_MouseEvent::LeftDClick()

bool
Wx_MouseEvent::LeftDown()

bool
Wx_MouseEvent::LeftIsDown()

bool
Wx_MouseEvent::LeftUp()

bool
Wx_MouseEvent::MetaDown()

bool
Wx_MouseEvent::MiddleDClick()

bool
Wx_MouseEvent::MiddleDown()

bool
Wx_MouseEvent::MiddleIsDown()

bool
Wx_MouseEvent::MiddleUp()

bool
Wx_MouseEvent::Moving()

bool
Wx_MouseEvent::RightDClick()

bool
Wx_MouseEvent::RightDown()

bool
Wx_MouseEvent::RightIsDown()

bool
Wx_MouseEvent::RightUp()

bool
Wx_MouseEvent::ShiftDown()

MODULE=Wx_Evt PACKAGE=Wx::MoveEvent

# Wx_MoveEvent*
# Wx_MoveEvent::new( point, id = 0 )
#     Wx_Point point
#     int id

Wx_Point*
Wx_MoveEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::NotebookEvent

int
Wx_NotebookEvent::GetOldSelection()

int
Wx_NotebookEvent::GetSelection()

void
Wx_NotebookEvent::SetOldSelection( sel )
    int sel

void
Wx_NotebookEvent::SetSelection( oldSel )
    int oldSel

MODULE=Wx_Evt PACKAGE=Wx::NotifyEvent

bool
Wx_NotifyEvent::IsAllowed()

void
Wx_NotifyEvent::Veto()

MODULE=Wx_Evt PACKAGE=Wx::PaintEvent

# Wx_PaintEvent*
# Wx_PaintEvent::new( id = 0 )
#     int id

MODULE=Wx_Evt PACKAGE=Wx::SashEvent

wxSashEdgePosition
Wx_SashEvent::GetEdge()

Wx_Rect*
Wx_SashEvent::GetDragRect()
  CODE:
    RETVAL = new wxRect( THIS->GetDragRect() );
  OUTPUT:
    RETVAL

wxSashDragStatus
Wx_SashEvent::GetDragStatus()

MODULE=Wx_Evt PACKAGE=Wx::SizeEvent

# Wx_SizeEvent*
# Wx_SizeEvent::new( size, id = 0 )
#     Wx_Size size
#     int id
#   CODE:
#     RETVAL = new wxSizeEvent( size, id );
#   OUTPUT:
#     RETVAL

Wx_Size*
Wx_SizeEvent::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::SpinEvent

# Wx_SpinEvent*
# Wx_SpinEvent::new( commandType = wxEVT_NULL, id = 0 )
#     wxEventType commandType
#     int id

int
Wx_SpinEvent::GetPosition()

void
Wx_SpinEvent::SetPosition( pos )
    int pos

MODULE=Wx_Evt PACKAGE=Wx::SplitterEvent

int
Wx_SplitterEvent::GetSashPosition()

int
Wx_SplitterEvent::GetX()

int
Wx_SplitterEvent::GetY()

Wx_Window*
Wx_SplitterEvent::GetWindowBeingRemoved()

void
Wx_SplitterEvent::SetSashPosition( pos )
    int pos


MODULE=Wx_Evt PACKAGE=Wx::ScrollWinEvent

# Wx_ScrollWinEvent*
# Wx_ScrollWinEvent::new( eventType = 0, pos = 0, orientation = 0 )
#     wxEventType eventType
#     int pos
#     int orientation

int
Wx_ScrollWinEvent::GetOrientation()

int
Wx_ScrollWinEvent::GetPosition()

MODULE=Wx_Evt PACKAGE=Wx::SysColourChangedEvent

# Wx_SysColourChangedEvent*
# Wx_SysColourChangedEvent::new()

MODULE=Wx_Evt PACKAGE=Wx::UpdateUIEvent

# Wx_UpdateUIEvent*
# Wx_UpdateUIEvent::new( commandId = 0 )
#     wxWindowID commandId

void
Wx_UpdateUIEvent::Check( check )
    bool check

void
Wx_UpdateUIEvent::Enable( enable )
    bool enable

bool
Wx_UpdateUIEvent::GetChecked()

bool
Wx_UpdateUIEvent::GetEnabled()

wxString
Wx_UpdateUIEvent::GetText()

void
Wx_UpdateUIEvent::SetText( text )
    wxString text

MODULE=Wx_Evt