/////////////////////////////////////////////////////////////////////////////
// Name:        Event.xs
// Purpose:     XS for Wx::EvtHandler, Wx::Event and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Event.xs,v 1.36 2003/12/13 17:13:31 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"

#include <wx/event.h>
#include <wx/dc.h>
#include <stdarg.h>

#include <wx/clntdata.h>

// re-include for client data
#include "cpp/helpers.h"

#undef THIS

#include "cpp/e_cback.h"
#include "cpp/e_cback.cpp"

#include "cpp/event.h"

WXPLI_BOOT_ONCE(Wx_Evt);
#define boot_Wx_Evt wxPli_boot_Wx_Evt

MODULE=Wx_Evt

INCLUDE: XS/EvtHandler.xs

MODULE=Wx_Evt PACKAGE=Wx::Event

# unimplemented ( and probably will never be: problems with object
#                 cloning/destruction )
# GetEventObject
# GetObjectType
# SetEventObject

## XXX threads
void
Wx_Event::DESTROY()

# void
# Wx_Event::Destroy()
#   CODE:
#     delete THIS;

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

Wx_UserDataCD*
Wx_CommandEvent::GetClientData()
  CODE:
    RETVAL = (Wx_UserDataCD*) THIS->GetClientObject();
  OUTPUT:
    RETVAL

long
Wx_CommandEvent::GetExtraLong()

int
Wx_CommandEvent::GetInt()

int
Wx_CommandEvent::GetSelection()

wxString
Wx_CommandEvent::GetString()

bool
Wx_CommandEvent::IsChecked()

bool
Wx_CommandEvent::IsSelection()

void
Wx_CommandEvent::SetClientData( data )
    Wx_UserDataCD* data
  CODE:
    THIS->SetClientObject( data );

void
Wx_CommandEvent::SetExtraLong( extraLong )
    long extraLong

void
Wx_CommandEvent::SetInt( intCommand )
    int intCommand

void
Wx_CommandEvent::SetString( string )
    wxString string

MODULE=Wx_Evt PACKAGE=Wx::PlEvent

Wx_Event*
Wx_PlEvent::new( id, type )
    int id
    wxEventType type
  CODE:
    RETVAL = new wxPlEvent( CLASS, id, type );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::PlCommandEvent

Wx_Event*
Wx_PlCommandEvent::new( id, type )
    int id
    wxEventType type
  CODE:
    RETVAL = new wxPlCommandEvent( CLASS, id, type );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::PlThreadEvent

Wx_Event*
Wx_PlThreadEvent::new( id, type, data )
    int id
    wxEventType type
    SV* data
  CODE:
    RETVAL = new wxPlThreadEvent( CLASS, id, type, data );
  OUTPUT:
    RETVAL

SV*
Wx_PlThreadEvent::GetData()
  PPCODE:
    SV* t = THIS->GetData();
    SvREFCNT_inc( t );
    XPUSHs( t );

void
Wx_PlThreadEvent::SetData( data )
    SV* data

MODULE=Wx_Evt PACKAGE=Wx::ActivateEvent

Wx_ActivateEvent*
Wx_ActivateEvent::new( type = 0, active = TRUE, id = 0 )
    wxEventType type
    bool active
    int id

bool
Wx_ActivateEvent::GetActive()

MODULE=Wx_Evt PACKAGE=Wx::CloseEvent

Wx_CloseEvent*
Wx_CloseEvent::new( commandEventType = 0, id = 0 )
    wxEventType commandEventType
    int id

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

MODULE=Wx_Evt PACKAGE=Wx::EraseEvent

Wx_EraseEvent*
Wx_EraseEvent::new( id = 0, dc = 0 )
    int id
    Wx_DC* dc

Wx_DC*
Wx_EraseEvent::GetDC()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), FALSE );

MODULE=Wx_Evt PACKAGE=Wx::FocusEvent

Wx_FocusEvent*
Wx_FocusEvent::new( eventType = 0, id = 0 )
    wxEventType eventType
    int id

MODULE=Wx_Evt PACKAGE=Wx::IconizeEvent

bool
Wx_IconizeEvent::Iconized()

MODULE=Wx_Evt PACKAGE=Wx::KeyEvent

Wx_KeyEvent*
Wx_KeyEvent::new( keyEventType )
    wxEventType keyEventType

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

Wx_HelpEvent*
Wx_HelpEvent::new()

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

MODULE=Wx_Evt PACKAGE=Wx::IdleEvent

Wx_IdleEvent*
Wx_IdleEvent::new()

bool
Wx_IdleEvent::MoreRequested()

void
Wx_IdleEvent::RequestMore( needMore = TRUE )
    bool needMore

MODULE=Wx_Evt PACKAGE=Wx::InitDialogEvent

Wx_InitDialogEvent*
Wx_InitDialogEvent::new( id = 0 )
    int id

MODULE=Wx_Evt PACKAGE=Wx::JoystickEvent

Wx_JoystickEvent*
Wx_JoystickEvent::new( eventType = 0, state = 0, joystick = wxJOYSTICK1, change = 0 )
    wxEventType eventType
    int state
    int joystick
    int change

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

MODULE=Wx_Evt PACKAGE=Wx::MenuEvent

Wx_MenuEvent*
Wx_MenuEvent::new( eventType = 0, id = 0 )
    wxEventType eventType
    int id

int
Wx_MenuEvent::GetMenuId()

bool
Wx_MenuEvent::IsPopup()

MODULE=Wx_Evt PACKAGE=Wx::MouseEvent

Wx_MouseEvent*
Wx_MouseEvent::new( eventType = 0 )
    wxEventType eventType

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

int
Wx_MouseEvent::GetWheelRotation()

int
Wx_MouseEvent::GetWheelDelta()

int
Wx_MouseEvent::GetLinesPerAction()

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

Wx_MoveEvent*
Wx_MoveEvent::new( point, id = 0 )
    Wx_Point point
    int id

Wx_Point*
Wx_MoveEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxRect*
wxMoveEvent::GetRect()
  CODE:
    RETVAL = new wxRect( THIS->GetRect() );
  OUTPUT: RETVAL

#endif

MODULE=Wx_Evt PACKAGE=Wx::NotifyEvent

Wx_NotifyEvent*
Wx_NotifyEvent::new( eventType = wxEVT_NULL, id = 0 )
    wxEventType eventType
    int id

bool
Wx_NotifyEvent::IsAllowed()

void
Wx_NotifyEvent::Veto()

void
Wx_NotifyEvent::Allow()

MODULE=Wx_Evt PACKAGE=Wx::PaintEvent

Wx_PaintEvent*
Wx_PaintEvent::new( id = 0 )
    int id

MODULE=Wx_Evt PACKAGE=Wx::SizeEvent

Wx_SizeEvent*
Wx_SizeEvent::new( size, id = 0 )
    Wx_Size size
    int id

Wx_Size*
Wx_SizeEvent::GetSize()
  CODE:
    RETVAL = new wxSize( THIS->GetSize() );
  OUTPUT:
    RETVAL

#if WXPERL_W_VERSION_GE( 2, 5, 1 )

wxRect*
wxSizeEvent::GetRect()
  CODE:
    RETVAL = new wxRect( THIS->GetRect() );
  OUTPUT: RETVAL

#endif

MODULE=Wx_Evt PACKAGE=Wx::ScrollEvent

int
wxScrollEvent::GetOrientation()

int
wxScrollEvent::GetPosition()

MODULE=Wx_Evt PACKAGE=Wx::ScrollWinEvent

Wx_ScrollWinEvent*
Wx_ScrollWinEvent::new( eventType = 0, pos = 0, orientation = 0 )
    wxEventType eventType
    int pos
    int orientation

int
Wx_ScrollWinEvent::GetOrientation()

int
Wx_ScrollWinEvent::GetPosition()

MODULE=Wx_Evt PACKAGE=Wx::SysColourChangedEvent

Wx_SysColourChangedEvent*
Wx_SysColourChangedEvent::new()

MODULE=Wx_Evt PACKAGE=Wx::UpdateUIEvent

Wx_UpdateUIEvent*
Wx_UpdateUIEvent::new( commandId = 0 )
    wxWindowID commandId

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