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

use Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw();

sub _id($) {
  Wx::_croak 'Undefined id'
    unless defined $_[0]; ref( $_[0] ) ? $_[0]->GetId() : $_[0];
}

# !parser: sub { $_[0] =~ m/sub (EVT_\w+)/ }
# !package: Wx::Event

#
# ActivateEvent
#

sub EVT_ACTIVATE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE, $_[1] ); }
sub EVT_ACTIVATE_APP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ACTIVATE_APP, $_[1] ); }

#
# CommandEvent
#

sub EVT_COMMAND($$$$) { $_[0]->Connect( $_[1], -1, $_[2], $_[3] ); }
sub EVT_COMMAND_RANGE($$$$$) { $_[0]->Connect( $_[1], $_[2], $_[3], $_[4] ); }
sub EVT_BUTTON($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_BUTTON_CLICKED, $_[2] ); }
sub EVT_CHECKBOX($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKBOX_CLICKED, $_[2] ); }
sub EVT_CHOICE($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHOICE_SELECTED, $_[2] ); }
sub EVT_LISTBOX($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_SELECTED, $_[2] ); }
sub EVT_LISTBOX_DCLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, $_[2] ); }
sub EVT_TEXT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_UPDATED, $_[2] ); }
sub EVT_TEXT_ENTER($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_ENTER, $_[2] ); }
sub EVT_TEXT_MAXLEN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_MAXLEN, $_[2] ); }
sub EVT_TEXT_URL($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TEXT_URL, $_[2] ); }
sub EVT_MENU($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[2] ); }
sub EVT_MENU_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_COMMAND_MENU_SELECTED, $_[3] ); }
sub EVT_SLIDER($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SLIDER_UPDATED, $_[2] ); }
sub EVT_RADIOBOX($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBOX_SELECTED, $_[2] ); }
sub EVT_RADIOBUTTON($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RADIOBUTTON_SELECTED, $_[2] ); }
sub EVT_SCROLLBAR($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SCROLLBAR_UPDATED, $_[2] ); }
sub EVT_COMBOBOX($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_COMBOBOX_SELECTED, $_[2] ); }
sub EVT_TOOL($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[2] ); }
sub EVT_TOOL_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_COMMAND_TOOL_CLICKED, $_[3] ); }
sub EVT_TOOL_RCLICKED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[2] ); }
sub EVT_TOOL_RCLICKED_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_COMMAND_TOOL_RCLICKED, $_[3] ); }
sub EVT_TOOL_ENTER($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOOL_ENTER, $_[2] ); }
sub EVT_COMMAND_LEFT_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_CLICK, $_[2] ); }
sub EVT_COMMAND_LEFT_DCLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LEFT_DCLICK, $_[2] ); }
sub EVT_COMMAND_RIGHT_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_RIGHT_CLICK, $_[2] ); }
sub EVT_COMMAND_SET_FOCUS($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SET_FOCUS, $_[2] ); }
sub EVT_COMMAND_KILL_FOCUS($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_KILL_FOCUS, $_[2] ); }
sub EVT_COMMAND_ENTER($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_ENTER, $_[2] ); }
sub EVT_TOGGLEBUTTON($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, $_[2] ); }
sub EVT_CHECKLISTBOX($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, $_[2] ); }

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
# FindDialogEvent
#

sub EVT_FIND($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND, $_[2] ); }
sub EVT_FIND_NEXT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_NEXT, $_[2] ); }
sub EVT_FIND_REPLACE($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE, $_[2] ); }
sub EVT_FIND_REPLACE_ALL($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_REPLACE_ALL, $_[2] ); }
sub EVT_FIND_CLOSE($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_FIND_CLOSE, $_[2] ); }

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
# Grid*Event
#

sub EVT_GRID_CELL_LEFT_CLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_CLICK, $_[1] ); }
sub EVT_GRID_CELL_RIGHT_CLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_CLICK, $_[1] ); }
sub EVT_GRID_CELL_LEFT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_LEFT_DCLICK, $_[1] ); }
sub EVT_GRID_CELL_RIGHT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_RIGHT_DCLICK, $_[1] ); }
sub EVT_GRID_LABEL_LEFT_CLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_CLICK, $_[1] ); }
sub EVT_GRID_LABEL_RIGHT_CLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_CLICK, $_[1] ); }
sub EVT_GRID_LABEL_LEFT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_LEFT_DCLICK, $_[1] ); }
sub EVT_GRID_LABEL_RIGHT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_LABEL_RIGHT_DCLICK, $_[1] ); }
sub EVT_GRID_ROW_SIZE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_ROW_SIZE, $_[1] ); }
sub EVT_GRID_COL_SIZE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_COL_SIZE, $_[1] ); }
sub EVT_GRID_RANGE_SELECT($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_RANGE_SELECT, $_[1] ); }
sub EVT_GRID_CELL_CHANGE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_CELL_CHANGE, $_[1] ); }
sub EVT_GRID_SELECT_CELL($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_SELECT_CELL, $_[1] ); }
sub EVT_GRID_EDITOR_SHOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_SHOWN, $_[1] ); }
sub EVT_GRID_EDITOR_HIDDEN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_HIDDEN, $_[1] ); }
sub EVT_GRID_EDITOR_CREATED($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_GRID_EDITOR_CREATED, $_[1] ); }

#
# HelpEvent
#

sub EVT_HELP($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_HELP, $_[2] ); }
sub EVT_HELP_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_HELP, $_[3] ); }
sub EVT_DETAILED_HELP($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_DETAILED_HELP, $_[2] ); }
sub EVT_DETAILED_HELP_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_DETAILED_HELP, $_[3] ); }

#
# IconizeEvent
#

sub EVT_ICONIZE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_ICONIZE, $_[1] ); }

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
# ListEvent
#

sub EVT_LIST_BEGIN_DRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_DRAG, $_[2] ); }
sub EVT_LIST_BEGIN_RDRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_RDRAG, $_[2] ); }
sub EVT_LIST_BEGIN_LABEL_EDIT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, $_[2] ); }
sub EVT_LIST_CACHE_HINT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_CACHE_HINT, $_[2] ); }
sub EVT_LIST_END_LABEL_EDIT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_END_LABEL_EDIT, $_[2] ); }
sub EVT_LIST_DELETE_ITEM($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ITEM, $_[2] ); }
sub EVT_LIST_DELETE_ALL_ITEMS($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, $_[2] ); }
sub EVT_LIST_GET_INFO($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_GET_INFO, $_[2] ); }
sub EVT_LIST_SET_INFO($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_SET_INFO, $_[2] ); }
sub EVT_LIST_ITEM_SELECTED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_SELECTED, $_[2] ); }
sub EVT_LIST_ITEM_DESELECTED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_DESELECTED, $_[2] ); }
sub EVT_LIST_KEY_DOWN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_KEY_DOWN, $_[2] ); }
sub EVT_LIST_INSERT_ITEM($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_INSERT_ITEM, $_[2] ); }
sub EVT_LIST_COL_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_CLICK, $_[2] ); }
sub EVT_LIST_RIGHT_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_RIGHT_CLICK, $_[2] ); }
sub EVT_LIST_MIDDLE_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_MIDDLE_CLICK, $_[2] ); }
sub EVT_LIST_ITEM_ACTIVATED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_ACTIVATED, $_[2] ); }
sub EVT_LIST_COL_RIGHT_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, $_[2] ); }
sub EVT_LIST_COL_BEGIN_DRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, $_[2] ); }
sub EVT_LIST_COL_DRAGGING($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_DRAGGING, $_[2] ); }
sub EVT_LIST_COL_END_DRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_COL_END_DRAG, $_[2] ); }
sub EVT_LIST_ITEM_FOCUSED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_FOCUSED, $_[2] ); }
sub EVT_LIST_ITEM_RIGHT_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, $_[2] ); }

#
# MenuEvent
#

sub EVT_MENU_CHAR($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CHAR, $_[1] ); }
sub EVT_MENU_INIT($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_INIT, $_[1] ); }
sub EVT_MENU_HIGHLIGHT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_MENU_HIGHLIGHT, $_[2] ); }
sub EVT_POPUP_MENU($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_POPUP_MENU, $_[1] ); }
sub EVT_CONTEXT_MENU($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_CONTEXT_MENU, $_[1] ); }
sub EVT_MENU_OPEN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_OPEN, $_[1] ); }
sub EVT_MENU_CLOSE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MENU_CLOSE, $_[1] ); }

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
sub EVT_MOUSEWHEEL($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MOUSEWHEEL, $_[1] ); }
sub EVT_MOUSE_EVENTS($$) {
  my( $x, $y ) = @_;
  EVT_LEFT_DOWN( $x, $y );
  EVT_LEFT_UP( $x, $y );
  EVT_LEFT_DCLICK( $x, $y );
  EVT_MIDDLE_DOWN( $x, $y );
  EVT_MIDDLE_UP( $x, $y );
  EVT_MIDDLE_DCLICK( $x, $y );
  EVT_RIGHT_DOWN( $x, $y );
  EVT_RIGHT_UP( $x, $y );
  EVT_RIGHT_DCLICK( $x, $y );
  EVT_MOTION( $x, $y );
  EVT_ENTER_WINDOW( $x, $y );
  EVT_LEAVE_WINDOW( $x, $y );
  EVT_MOUSEWHEEL( $x, $y ) if $Wx::_wx_version >= 2.003001;
}

#
# MoveEvent
#

sub EVT_MOVE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_MOVE, $_[1] ); }

#
# NotebookEvent
#

sub EVT_NOTEBOOK_PAGE_CHANGING($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, $_[2] ); }
sub EVT_NOTEBOOK_PAGE_CHANGED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, $_[2] ); }

#
# PaintEvent
#

sub EVT_PAINT($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_PAINT, $_[1] ); }

#
# ProcessEvent
#

sub EVT_END_PROCESS($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_END_PROCESS, $_[2] ); }

#
# SashEvent
#

sub EVT_SASH_DRAGGED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SASH_DRAGGED, $_[2] ); }
sub EVT_SASH_DRAGGED_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_SASH_DRAGGED, $_[3] ); }

#
# SizeEvent
#

sub EVT_SIZE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SIZE, $_[1] ); }

#
# ScrollEvent
#

sub EVT_SCROLL_TOP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_TOP, $_[1] ); }
sub EVT_SCROLL_BOTTOM($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_BOTTOM, $_[1] ); }
sub EVT_SCROLL_LINEUP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_LINEUP, $_[1] ); }
sub EVT_SCROLL_LINEDOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[1] ); }
sub EVT_SCROLL_PAGEUP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_PAGEUP, $_[1] ); }
sub EVT_SCROLL_PAGEDOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_PAGEDOWN, $_[1] ); }
sub EVT_SCROLL_THUMBTRACK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[1] ); }
sub EVT_SCROLL_THUMBRELEASE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, $_[1] ); }

sub EVT_COMMAND_SCROLL_TOP($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_TOP, $_[2] ); }
sub EVT_COMMAND_SCROLL_BOTTOM($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_BOTTOM, $_[2] ); }
sub EVT_COMMAND_SCROLL_LINEUP($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] ); }
sub EVT_COMMAND_SCROLL_LINEDOWN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] ); }
sub EVT_COMMAND_SCROLL_PAGEUP($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEUP, $_[2] ); }
sub EVT_COMMAND_SCROLL_PAGEDOWN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_PAGEDOWN, $_[2] ); }
sub EVT_COMMAND_SCROLL_THUMBTRACK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] ); }
sub EVT_COMMAND_SCROLL_THUMBRELEASE($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBRELEASE, $_[2] ); }

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

sub EVT_SPIN_UP($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEUP, $_[2] ); }
sub EVT_SPIN_DOWN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_LINEDOWN, $_[2] ); }
sub EVT_SPIN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_SCROLL_THUMBTRACK, $_[2] ); }
sub EVT_SPINCTRL($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPINCTRL_UPDATED, $_[2] ); }

#
# SplitterEvent
#

sub EVT_SPLITTER_SASH_POS_CHANGING($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, $_[2] ) }
sub EVT_SPLITTER_SASH_POS_CHANGED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, $_[2] ) }
sub EVT_SPLITTER_UNSPLIT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_UNSPLIT, $_[2] ) }
sub EVT_SPLITTER_DOUBLECLICKED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_SPLITTER_DOUBLECLICK, $_[2] ) }

#
# TimerEvent
#

sub EVT_TIMER($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_TIMER, $_[2] ); }

#
# SysColourChangedEvent
#

sub EVT_SYS_COLOUR_CHANGED($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_SYS_COLOUR_CHANGED, $_[1] ); }

#
# Taskbar
#

sub EVT_TASKBAR_MOVE($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_MOVE, $_[1] ); }
sub EVT_TASKBAR_LEFT_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_DOWN, $_[1] ); }
sub EVT_TASKBAR_LEFT_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_UP, $_[1] ); }
sub EVT_TASKBAR_RIGHT_DOWN($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_DOWN, $_[1] ); }
sub EVT_TASKBAR_RIGHT_UP($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_UP, $_[1] ); }
sub EVT_TASKBAR_LEFT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_LEFT_DCLICK, $_[1] ); }
sub EVT_TASKBAR_RIGHT_DCLICK($$) { $_[0]->Connect( -1, -1, &Wx::wxEVT_TASKBAR_RIGHT_DCLICK, $_[1] ); }

#
# TreeEvent
#

sub EVT_TREE_BEGIN_DRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_DRAG, $_[2] ); }
sub EVT_TREE_BEGIN_RDRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_RDRAG, $_[2] ); }
sub EVT_TREE_END_DRAG($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_END_DRAG, $_[2] ); }
sub EVT_TREE_BEGIN_LABEL_EDIT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, $_[2] ); }
sub EVT_TREE_END_LABEL_EDIT($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_END_LABEL_EDIT, $_[2] ); }
sub EVT_TREE_GET_INFO($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_GET_INFO, $_[2] ); }
sub EVT_TREE_SET_INFO($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SET_INFO, $_[2] ); }
sub EVT_TREE_ITEM_EXPANDED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDED, $_[2] ); }
sub EVT_TREE_ITEM_EXPANDING($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_EXPANDING, $_[2] ); }
sub EVT_TREE_ITEM_COLLAPSED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSED, $_[2] ); }
sub EVT_TREE_ITEM_COLLAPSING($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_COLLAPSING, $_[2] ); }
sub EVT_TREE_SEL_CHANGED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGED, $_[2] ); }
sub EVT_TREE_SEL_CHANGING($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_SEL_CHANGING, $_[2] ); }
sub EVT_TREE_KEY_DOWN($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_KEY_DOWN, $_[2] ); }
sub EVT_TREE_DELETE_ITEM($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_DELETE_ITEM, $_[2] ); }
sub EVT_TREE_ITEM_ACTIVATED($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_ACTIVATED, $_[2] ); }
sub EVT_TREE_ITEM_RIGHT_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, $_[2] ); }
sub EVT_TREE_ITEM_MIDDLE_CLICK($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, $_[2] ); }

#
# UpdateUIEvent
#

sub EVT_UPDATE_UI($$$) { $_[0]->Connect( $_[1], -1, &Wx::wxEVT_UPDATE_UI, $_[2] ); }
sub EVT_UPDATE_UI_RANGE($$$$) { $_[0]->Connect( $_[1], $_[2], &Wx::wxEVT_UPDATE_UI, $_[3] ); }

no strict;

#
# Event hierarchy
#

package Wx::PlEvent;         @ISA = qw(Wx::Event);
package Wx::PlThreadEvent;   @ISA = qw(Wx::Event);
package Wx::PlCommandEvent;  @ISA = qw(Wx::CommandEvent);
package Wx::ActivateEvent;   @ISA = qw(Wx::Event);
package Wx::CommandEvent;    @ISA = qw(Wx::Event);
package Wx::CloseEvent;      @ISA = qw(Wx::Event);
package Wx::EraseEvent;      @ISA = qw(Wx::Event);
package Wx::FindDialogEvent; @ISA = qw(Wx::CommandEvent);
package Wx::FocusEvent;      @ISA = qw(Wx::Event);
package Wx::KeyEvent;        @ISA = qw(Wx::Event);
package Wx::HelpEvent;       @ISA = qw(Wx::CommandEvent);
package Wx::IconizeEvent;    @ISA = qw(Wx::Event);
package Wx::IdleEvent;       @ISA = qw(Wx::Event);
package Wx::InitDialogEvent; @ISA = qw(Wx::Event);
package Wx::JoystickEvent;   @ISA = qw(Wx::Event);
package Wx::ListEvent;       @ISA = qw(Wx::NotifyEvent);
package Wx::MenuEvent;       @ISA = qw(Wx::Event);
package Wx::MouseEvent;      @ISA = qw(Wx::Event);
package Wx::MoveEvent;       @ISA = qw(Wx::Event);
package Wx::NotebookEvent;   @ISA = qw(Wx::NotifyEvent);
package Wx::NotifyEvent;     @ISA = qw(Wx::CommandEvent);
package Wx::PaintEvent;      @ISA = qw(Wx::Event);
package Wx::ProcessEvent;    @ISA = qw(Wx::Event);
package Wx::QueryLayoutInfoEvent; @ISA = qw(Wx::Event);
package Wx::SashEvent;       @ISA = qw(Wx::CommandEvent);
package Wx::SizeEvent;       @ISA = qw(Wx::Event);
package Wx::ScrollWinEvent;  @ISA = qw(Wx::Event);
package Wx::SpinEvent;       @ISA = qw(Wx::NotifyEvent);
package Wx::SplitterEvent;   @ISA = qw(Wx::CommandEvent);
package Wx::SysColourChangedEvent; @ISA = qw(Wx::Event);
package Wx::TextUrlEvent;    @ISA = qw(Wx::CommandEvent);
package Wx::TimerEvent;      @ISA = qw(Wx::Event);
package Wx::TreeEvent;       @ISA = qw(Wx::NotifyEvent);
package Wx::UpdateUIEvent;   @ISA = qw(Wx::CommandEvent);

package Wx::SplitterEvent;

if( $Wx::_wx_version >= 2.003003 ) { @ISA = qw(Wx::NotifyEvent) }

1;

__END__

# Local variables: #
# mode: cperl #
# End: #
