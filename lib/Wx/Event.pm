#############################################################################
## Name:        Event.pm
## Purpose:     Wx::*Event classes and EVT_* macros
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::Event;

use strict;
use vars qw(@ISA @EXPORT_OK);

use Carp;
use Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw();

sub _id($) {
  croak 'Undefined id'
    unless defined $_[0]; ref( $_[0] ) ? $_[0]->GetId() : $_[0];
}

# ActivateEvent

sub EVT_ACTIVATE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE, $_[1] ); }
sub EVT_ACTIVATE_APP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE_APP, $_[1] ); }

# CommandEvent

sub EVT_COMMAND($$$) { $_[0]->Connect( _id( $_[1] ), -1, $_[1], $_[2] ); }
sub EVT_COMMAND_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], $_[3], $_[4] ); }
sub EVT_BUTTON($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_BUTTON_CLICKED, $_[2] ); }
sub EVT_CHECKBOX($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_CHECKBOX_CLICKED, $_[2] ); }
sub EVT_CHOICE($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_CHOICE_SELECTED, $_[2] ); }
sub EVT_LISTBOX($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_LISTBOX_SELECTED, $_[2] ); }
sub EVT_LISTBOX_DCLICK($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, $_[2] ); }
sub EVT_TEXT($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_TEXT_UPDATED, $_[2] ); }
sub EVT_TEXT_ENTER($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_TEXT_ENTER, $_[2] ); }
sub EVT_MENU($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[2] ); }
sub EVT_MENU_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_COMMAND_MENU_RANGE, $_[3] ); }
sub EVT_SLIDER($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SLIDER_UPDATED, $_[2] ); }
sub EVT_RADIOBOX($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_RADIOBOX_SELECTED, $_[2] ); }
sub EVT_RADIOBUTTON($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_RADIOBUTTON_SELECTED, $_[2] ); }
sub EVT_SCROLLBAR($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SCROLLBAR_UPDATED, $_[2] ); }
sub EVT_COMBOBOX($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_COMBOBOX_SELECTED, $_[2] ); }
sub EVT_TOOL($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[2] ); }
sub EVT_TOOL_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[3] ); }
sub EVT_TOOL_RCLICKED($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[2] ); }
sub EVT_TOOL_RCLICKED_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[3] ); }
sub EVT_TOOL_ENTER($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_TOOL_ENTER, $_[2] ); }
sub EVT_COMMAND_LEFT_CLICK($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_LEFT_CLICK, $_[2] ); }
sub EVT_COMMAND_LEFT_DCLICK($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_LEFT_DCLICK, $_[2] ); }
sub EVT_COMMAND_RIGHT_CLICK($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_RIGHT_CLICK, $_[2] ); }
sub EVT_COMMAND_SET_FOCUS($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SET_FOCUS, $_[2] ); }
sub EVT_COMMAND_KILL_FOCUS($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_KILL_FOCUS, $_[2] ); }
sub EVT_COMMAND_ENTER($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_ENTER, $_[2] ); }

#
# CloseEvent
#

sub EVT_CLOSE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_CLOSE_WINDOW, $_[1] ); }
sub EVT_END_SESSION($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_END_SESSION, $_[1] ); }
sub EVT_QUERY_END_SESSION($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_QUERY_END_SESSION, $_[1] ); }

#
# DropFilesEvent
#

sub EVT_DROP_FILES($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_DROP_FILES, $_[1] ); }

#
# EraseEvent
#

sub EVT_ERASE_BACKGROUND($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ERASE_BACKGROUND, $_[1] ); }

#
# FocusEvent
#

sub EVT_SET_FOCUS($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SET_FOCUS, $_[1] ); }
sub EVT_KILL_FOCUS($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_KILL_FOCUS, $_[1] ); }

#
# KeyEvent
#

sub EVT_CHAR($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR, $_[1] ); }
sub EVT_CHAR_HOOK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_CHAR_HOOK, $_[1] ); }
sub EVT_KEY_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_DOWN, $_[1] ); }
sub EVT_KEY_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_KEY_UP, $_[1] ); }

#
# IdleEvent
#

sub EVT_IDLE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_IDLE, $_[1] ); }

#
# InitDialogEvent
#

sub EVT_INIT_DIALOG($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_INIT_DIALOG, $_[1] ); }

#
# JoystickEvent
#

sub EVT_JOY_BUTTON_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_DOWN, $_[1] ); }
sub EVT_JOY_BUTTON_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_BUTTON_UP, $_[1] ); }
sub EVT_JOY_MOVE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_MOVE, $_[1] ); }
sub EVT_JOY_ZMOVE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_JOY_ZMOVE, $_[1] ); }

#
# MenuEvent
#

sub EVT_MENU_CHAR($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CHAR, $_[1] ); }
sub EVT_MENU_INIT($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_INIT, $_[1] ); }
sub EVT_MENU_HIGHLIGHT($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_HIGHLIGHT, $_[1] ); }
sub EVT_POPUP_MENU($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_POPUP_MENU, $_[1] ); }
sub EVT_CONTEXT_MENU($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_CONTEXT_MENU, $_[1] ); }

#
# MouseEvent
#

sub EVT_LEFT_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DOWN, $_[1] ); }
sub EVT_LEFT_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_UP, $_[1] ); }
sub EVT_LEFT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_LEFT_DCLICK, $_[1] ); }
sub EVT_MIDDLE_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DOWN, $_[1] ); }
sub EVT_MIDDLE_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_UP, $_[1] ); }
sub EVT_MIDDLE_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MIDDLE_DCLICK, $_[1] ); }
sub EVT_RIGHT_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DOWN, $_[1] ); }
sub EVT_RIGHT_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_UP, $_[1] ); }
sub EVT_RIGHT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_RIGHT_DCLICK, $_[1] ); }
sub EVT_MOTION($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MOTION, $_[1] ); }
sub EVT_ENTER_WINDOW($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ENTER_WINDOW, $_[1] ); }
sub EVT_LEAVE_WINDOW($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_LEAVE_WINDOW, $_[1] ); }

#
# MoveEvent
#

sub EVT_MOVE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVE, $_[1] ); }

#
# NotebookEvent
#

sub EVT_NOTEBOOK_PAGE_CHANGING($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, $_[2] ); }
sub EVT_NOTEBOOK_PAGE_CHANGED($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, $_[2] ); }

#
# PaintEvent
#

sub EVT_PAINT($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_PAINT, $_[1] ); }

#
# SizeEvent
#

sub EVT_SIZE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SIZE, $_[1] ); }

#
# ScrollWinEvent
#

sub EVT_SCROLLWIN_TOP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_TOP, $_[1] ); }
sub EVT_SCROLLWIN_BOTTOM($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_BOTTOM, $_[1] ); }
sub EVT_SCROLLWIN_LINEUP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_LINEUP, $_[1] ); }
sub EVT_SCROLLWIN_LINEDOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_LINEDOWN, $_[1] ); }
sub EVT_SCROLLWIN_PAGEUP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_PAGEUP, $_[1] ); }
sub EVT_SCROLLWIN_PAGEDOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_PAGEDOWN, $_[1] ); }
sub EVT_SCROLLWIN_THUMBTRACK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_THUMBTRACK, $_[1] ); }
sub EVT_SCROLLWIN_THUMBRELEASE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLLWIN_THUMBRELEASE, $_[1] ); }

#
# SpinEvent
#

sub EVT_SPIN_UP($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] ); }
sub EVT_SPIN_DOWN($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] ); }
sub EVT_SPIN($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] ); }
sub EVT_SPINCTRL($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SPINCTRL_UPDATED, $_[2] ); }

#
# SplitterEvent
#
sub EVT_SPLITTER_SASH_POS_CHANGING { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, $_[2] ) }
sub EVT_SPLITTER_SASH_POS_CHANGED { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, $_[2] ) }
sub EVT_SPLITTER_UNSPLIT { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SPLITTER_UNSPLIT, $_[2] ) }
sub EVT_SPLITTER_DOUBLECLICKED { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_COMMAND_SPLITTER_DOUBLECLICK, $_[2] ) }

#
# SysColourChangedEvent
#

sub EVT_SYS_COLOUR_CHANGED($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SYS_COLOUR_CHANGED, $_[1] ); }

#
# UpdateUIEvent
#

sub EVT_UPDATE_UI($$$) { $_[0]->Connect( _id( $_[1] ), -1, &Wx::wxEVT_UPDATE_UI, $_[2] ); }
sub EVT_UPDATE_UI_RANGE($$$$) { $_[0]->Connect( _id( $_[1] ), _id( $_[2] ), &Wx::wxEVT_UPDATE_UI, $_[3] ); }

no strict;

#
# Event hierarchy
#

package Wx::ActivateEvent;   @ISA = qw(Wx::Event);
package Wx::CommandEvent;    @ISA = qw(Wx::Event);
package Wx::CloseEvent;      @ISA = qw(Wx::Event);
package Wx::DropFilesEvent;  @ISA = qw(Wx::Event);
package Wx::EraseEvent;      @ISA = qw(Wx::Event);
package Wx::FocusEvent;      @ISA = qw(Wx::Event);
package Wx::KeyEvent;        @ISA = qw(Wx::Event);
package Wx::IdleEvent;       @ISA = qw(Wx::Event);
package Wx::InitDialogEvent; @ISA = qw(Wx::Event);
package Wx::JoystickEvent;   @ISA = qw(Wx::Event);
package Wx::MenuEvent;       @ISA = qw(Wx::Event);
package Wx::MouseEvent;      @ISA = qw(Wx::Event);
package Wx::MoveEvent;       @ISA = qw(Wx::Event);
package Wx::NotebookEvent;   @ISA = qw(Wx::NotifyEvent);
package Wx::NotifyEvent;     @ISA = qw(Wx::CommandEvent);
package Wx::PaintEvent;      @ISA = qw(Wx::Event);
package Wx::QueryLayoutInfoEvent; @ISA = qw(Wx::Event);
package Wx::SizeEvent;       @ISA = qw(Wx::Event);
package Wx::ScrollWinEvent;  @ISA = qw(Wx::Event);
package Wx::SpinEvent;       @ISA = qw(Wx::NotifyEvent);
package Wx::SplitterEvent;   @ISA = qw(Wx::CommandEvent);
package Wx::SysColourChangedEvent; @ISA = qw(Wx::Event);
package Wx::UpdateUIEvent;   @ISA = qw(Wx::CommandEvent);

1;

__END__

# Local variables: #
# mode: cperl #
# End: #
