/////////////////////////////////////////////////////////////////////////////
// Name:        Event.xs
// Purpose:     XS for Wx::EvtHandler, Wx::Event and derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Event.xs,v 1.51 2006/05/07 16:37:51 mbarbon Exp $
// Copyright:   (c) 2000-2005 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define PERL_NO_GET_CONTEXT

#include "cpp/wxapi.h"
#include "cpp/typedef.h"

#include <wx/event.h>
#include <wx/window.h>
#include <wx/dc.h>
#include <wx/menu.h>
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
# GetObjectType
# SetEventObject

## XXX threads
void
wxEvent::DESTROY()

# void
# wxEvent::Destroy()
#   CODE:
#     delete THIS;

void
wxEvent::GetEventObject()
  PPCODE:
    // to avoid problems with deletion, only windows are supported
    wxObject* obj = THIS->GetEventObject();
    wxWindow* win = wxDynamicCast( obj, wxWindow );

    EXTEND( SP, 1 );
    if(win == NULL)
        PUSHs( &PL_sv_undef );
    else
        PUSHs( wxPli_object_2_sv( aTHX_ NEWSV( 0, 0 ), win ) );
        
wxEventType
wxEvent::GetEventType()

int
wxEvent::GetId()

bool
wxEvent::GetSkipped()

long
wxEvent::GetTimestamp()

void
wxEvent::SetEventType( type )
    wxEventType type

void
wxEvent::SetId( id )
    wxWindowID id

void
wxEvent::SetTimestamp( timeStamp )
    long timeStamp

void
wxEvent::Skip( skip = true )
    bool skip

bool
wxEvent::ShouldPropagate()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

int
wxEvent::StopPropagation()

void
wxEvent::ResumePropagation( propagationLevel )
    int propagationLevel

#else

void
wxEvent::SetPropagate( doIt )
    bool doIt

#endif

MODULE=Wx_Evt PACKAGE=Wx::CommandEvent

wxCommandEvent*
wxCommandEvent::new( type = 0, id = 0 )
    wxEventType type
    wxWindowID id

Wx_UserDataCD*
wxCommandEvent::GetClientData()
  CODE:
    RETVAL = (wxPliUserDataCD*)THIS->GetClientObject();
  OUTPUT:
    RETVAL

long
wxCommandEvent::GetExtraLong()

int
wxCommandEvent::GetInt()

int
wxCommandEvent::GetSelection()

wxString
wxCommandEvent::GetString()

bool
wxCommandEvent::IsChecked()

bool
wxCommandEvent::IsSelection()

void
wxCommandEvent::SetClientData( data )
    Wx_UserDataCD* data
  CODE:
    THIS->SetClientObject( data );

void
wxCommandEvent::SetExtraLong( extraLong )
    long extraLong

void
wxCommandEvent::SetInt( intCommand )
    int intCommand

void
wxCommandEvent::SetString( string )
    wxString string

MODULE=Wx_Evt PACKAGE=Wx::ContextMenuEvent

wxContextMenuEvent*
wxContextMenuEvent::new( type = 0, id = 0, pos = wxDefaultPosition )
    wxEventType type
    wxWindowID id
    wxPoint pos

wxPoint
wxContextMenuEvent::GetPosition()

void
wxContextMenuEvent::SetPosition( pos )
    wxPoint pos

MODULE=Wx_Evt PACKAGE=Wx::PlEvent

wxEvent*
wxPlEvent::new( type, id )
    wxEventType type
    wxWindowID id
  CODE:
    RETVAL = new wxPlEvent( CLASS, type, id );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::PlCommandEvent

wxEvent*
wxPlCommandEvent::new( type, id )
    wxEventType type
    wxWindowID id
  CODE:
    RETVAL = new wxPlCommandEvent( CLASS, type, id );
  OUTPUT:
    RETVAL

MODULE=Wx_Evt PACKAGE=Wx::PlThreadEvent

wxEvent*
wxPlThreadEvent::new( type, id, data )
    wxEventType type
    wxWindowID id
    SV* data
  CODE:
    RETVAL = new wxPlThreadEvent( CLASS, type, id, data );
  OUTPUT:
    RETVAL

SV*
wxPlThreadEvent::GetData()
  PPCODE:
    SV* t = THIS->GetData();
    SvREFCNT_inc( t );
    XPUSHs( t );

void
wxPlThreadEvent::SetData( data )
    SV* data

MODULE=Wx_Evt PACKAGE=Wx::ActivateEvent

wxActivateEvent*
wxActivateEvent::new( type = 0, active = true, id = 0 )
    wxEventType type
    bool active
    wxWindowID id

bool
wxActivateEvent::GetActive()

MODULE=Wx_Evt PACKAGE=Wx::CloseEvent

wxCloseEvent*
wxCloseEvent::new( commandEventType = 0, id = 0 )
    wxEventType commandEventType
    wxWindowID id

bool
wxCloseEvent::CanVeto()

bool
wxCloseEvent::GetLoggingOff()

void
wxCloseEvent::SetCanVeto( canVeto )
    bool canVeto

void
wxCloseEvent::SetLoggingOff( loggingOff )
    bool loggingOff

void
wxCloseEvent::Veto( veto = true )
    bool veto

MODULE=Wx_Evt PACKAGE=Wx::EraseEvent

wxEraseEvent*
wxEraseEvent::new( id = 0, dc = 0 )
    wxWindowID id
    wxDC* dc

wxDC*
wxEraseEvent::GetDC()
  OUTPUT:
    RETVAL
  CLEANUP:
    wxPli_object_set_deleteable( aTHX_ ST(0), false );

MODULE=Wx_Evt PACKAGE=Wx::FocusEvent

wxFocusEvent*
wxFocusEvent::new( eventType = 0, id = 0 )
    wxEventType eventType
    wxWindowID id

MODULE=Wx_Evt PACKAGE=Wx::IconizeEvent

bool
wxIconizeEvent::Iconized()

MODULE=Wx_Evt PACKAGE=Wx::KeyEvent

wxKeyEvent*
wxKeyEvent::new( keyEventType )
    wxEventType keyEventType

bool
wxKeyEvent::AltDown()

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxKeyEvent::CmdDown()

#endif

bool
wxKeyEvent::ControlDown()

int
wxKeyEvent::GetKeyCode()

#if wxUSE_UNICODE && WXPERL_W_VERSION_GE( 2, 5, 3 )

wxChar
wxKeyEvent::GetUnicodeKey()

#endif 

#if WXPERL_W_VERSION_GE( 2, 7, 0 )

int
wxKeyEvent::GetModifiers()

#endif

long
wxKeyEvent::GetX()

long
wxKeyEvent::GetY()

bool
wxKeyEvent::MetaDown()

bool
wxKeyEvent::HasModifiers()

bool
wxKeyEvent::ShiftDown()

MODULE=Wx_Evt PACKAGE=Wx::HelpEvent

wxHelpEvent*
wxHelpEvent::new()

wxPoint*
wxHelpEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

wxString
wxHelpEvent::GetLink()

wxString
wxHelpEvent::GetTarget()

void
wxHelpEvent::SetPosition( point )
    wxPoint point

void
wxHelpEvent::SetLink( link )
    wxString link

void
wxHelpEvent::SetTarget( target )
    wxString target

MODULE=Wx_Evt PACKAGE=Wx::IdleEvent

wxIdleEvent*
wxIdleEvent::new()

bool
wxIdleEvent::MoreRequested()

void
wxIdleEvent::RequestMore( needMore = true )
    bool needMore

MODULE=Wx_Evt PACKAGE=Wx::InitDialogEvent

wxInitDialogEvent*
wxInitDialogEvent::new( id = 0 )
    wxWindowID id

MODULE=Wx_Evt PACKAGE=Wx::JoystickEvent

wxJoystickEvent*
wxJoystickEvent::new( eventType = 0, state = 0, joystick = wxJOYSTICK1, change = 0 )
    wxEventType eventType
    int state
    int joystick
    int change

bool
wxJoystickEvent::ButtonDown( button = wxJOY_BUTTON_ANY )
    int button

bool
wxJoystickEvent::ButtonIsDown( button = wxJOY_BUTTON_ANY )
    int button

bool
wxJoystickEvent::ButtonUp( button = wxJOY_BUTTON_ANY )
    int button

int
wxJoystickEvent::GetButtonChange()

int
wxJoystickEvent::GetButtonState()

int
wxJoystickEvent::GetJoystick()

wxPoint*
wxJoystickEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

int
wxJoystickEvent::GetZPosition()

bool
wxJoystickEvent::IsButton()

bool
wxJoystickEvent::IsMove()

bool
wxJoystickEvent::IsZMove()

MODULE=Wx_Evt PACKAGE=Wx::MenuEvent

wxMenuEvent*
wxMenuEvent::new( eventType = 0, id = 0 )
    wxEventType eventType
    wxWindowID id

int
wxMenuEvent::GetMenuId()

bool
wxMenuEvent::IsPopup()

#if WXPERL_W_VERSION_GE( 2, 6, 0 )

wxMenu*
wxMenuEvent::GetMenu()

#endif

MODULE=Wx_Evt PACKAGE=Wx::MouseEvent

wxMouseEvent*
wxMouseEvent::new( eventType = 0 )
    wxEventType eventType

bool
wxMouseEvent::AltDown()

bool
wxMouseEvent::Button( button = -1 )
    int button

bool
wxMouseEvent::ButtonDClick( button = -1 )
    int button

bool
wxMouseEvent::ButtonDown( button = -1 )
    int button

bool
wxMouseEvent::ButtonUp( button = -1 )
    int button

#if WXPERL_W_VERSION_GE( 2, 5, 3 )

bool
wxMouseEvent::CmdDown()

#endif

bool
wxMouseEvent::ControlDown()

bool
wxMouseEvent::Dragging()

bool
wxMouseEvent::Entering()

wxPoint*
wxMouseEvent::GetPosition()
  CODE:
    RETVAL = new wxPoint( THIS->GetPosition() );
  OUTPUT:
    RETVAL

void
wxMouseEvent::GetPositionXY()
  PREINIT:
    long x;
    long y;
  PPCODE:
    THIS->GetPosition( &x, &y );
    EXTEND( SP, 2 );
    PUSHs( sv_2mortal( newSViv( x ) ) );
    PUSHs( sv_2mortal( newSViv( y ) ) );

wxPoint*
wxMouseEvent::GetLogicalPosition( dc )
    wxDC* dc
  CODE:
    RETVAL = new wxPoint( THIS->GetLogicalPosition( *dc ) );
  OUTPUT:
    RETVAL

long
wxMouseEvent::GetX()

long
wxMouseEvent::GetY()

int
wxMouseEvent::GetWheelRotation()

int
wxMouseEvent::GetWheelDelta()

int
wxMouseEvent::GetLinesPerAction()

bool
wxMouseEvent::IsButton()

bool
wxMouseEvent::IsPageScroll()

bool
wxMouseEvent::Leaving()

bool
wxMouseEvent::LeftDClick()

bool
wxMouseEvent::LeftDown()

bool
wxMouseEvent::LeftIsDown()

bool
wxMouseEvent::LeftUp()

bool
wxMouseEvent::MetaDown()

bool
wxMouseEvent::MiddleDClick()

bool
wxMouseEvent::MiddleDown()

bool
wxMouseEvent::MiddleIsDown()

bool
wxMouseEvent::MiddleUp()

bool
wxMouseEvent::Moving()

bool
wxMouseEvent::RightDClick()

bool
wxMouseEvent::RightDown()

bool
wxMouseEvent::RightIsDown()

bool
wxMouseEvent::RightUp()

bool
wxMouseEvent::ShiftDown()

MODULE=Wx_Evt PACKAGE=Wx::MoveEvent

wxMoveEvent*
wxMoveEvent::new( point, id = 0 )
    wxPoint point
    wxWindowID id

wxPoint*
wxMoveEvent::GetPosition()
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

wxNotifyEvent*
wxNotifyEvent::new( eventType = wxEVT_NULL, id = 0 )
    wxEventType eventType
    wxWindowID id

bool
wxNotifyEvent::IsAllowed()

void
wxNotifyEvent::Veto()

void
wxNotifyEvent::Allow()

MODULE=Wx_Evt PACKAGE=Wx::PaintEvent

wxPaintEvent*
wxPaintEvent::new( id = 0 )
    wxWindowID id

MODULE=Wx_Evt PACKAGE=Wx::SizeEvent

wxSizeEvent*
wxSizeEvent::new( size, id = 0 )
    wxSize size
    wxWindowID id

wxSize*
wxSizeEvent::GetSize()
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

wxScrollWinEvent*
wxScrollWinEvent::new( eventType = 0, pos = 0, orientation = 0 )
    wxEventType eventType
    int pos
    int orientation

int
wxScrollWinEvent::GetOrientation()

int
wxScrollWinEvent::GetPosition()

MODULE=Wx_Evt PACKAGE=Wx::SysColourChangedEvent

wxSysColourChangedEvent*
wxSysColourChangedEvent::new()

MODULE=Wx_Evt PACKAGE=Wx::UpdateUIEvent

wxUpdateUIEvent*
wxUpdateUIEvent::new( commandId = 0 )
    wxWindowID commandId

void
wxUpdateUIEvent::Check( check )
    bool check

void
wxUpdateUIEvent::Enable( enable )
    bool enable

bool
wxUpdateUIEvent::GetChecked()

bool
wxUpdateUIEvent::GetEnabled()

wxString
wxUpdateUIEvent::GetText()

void
wxUpdateUIEvent::SetText( text )
    wxString text

MODULE=Wx_Evt PACKAGE=Wx::NavigationKeyEvent

wxNavigationKeyEvent*
wxNavigationKeyEvent::new()

bool
wxNavigationKeyEvent::GetDirection()

void
wxNavigationKeyEvent::SetDirection(direction)
    bool direction

bool
wxNavigationKeyEvent::IsWindowChange()

void
wxNavigationKeyEvent::SetWindowChange(change)
    bool change

wxWindow*
wxNavigationKeyEvent::GetCurrentFocus()

void
wxNavigationKeyEvent::SetCurrentFocus(focus)
    wxWindow* focus

#if WXPERL_W_VERSION_GE( 2, 5, 4 )

bool
wxNavigationKeyEvent::IsFromTab()

void
wxNavigationKeyEvent::SetFromTab( fromTab )
    bool fromTab

#endif

MODULE=Wx_Evt PACKAGE=Wx::ChildFocusEvent

wxChildFocusEvent*
wxChildFocusEvent::new( win = NULL )
    wxWindow* win

wxWindow*
wxChildFocusEvent::GetWindow() 

MODULE=Wx_Evt
