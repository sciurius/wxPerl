/////////////////////////////////////////////////////////////////////////////
// Name:        Constant.xs
// Purpose:     defines the constant() and SetConstants() functions
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

#include <wx/filedlg.h>
#include <wx/colordlg.h>
#include <wx/textdlg.h>
#include <wx/choicdlg.h>
#include <wx/msgdlg.h>
#include <wx/gdicmn.h>
#include <wx/bitmap.h>
#include <wx/icon.h>
#include <wx/imaglist.h>
#include <wx/pen.h>
#include <wx/brush.h>
#include <wx/layout.h>
#include <wx/splitter.h>
#include <stdarg.h>

#undef _

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#undef bool
#undef Move
#undef Copy

#if __VISUALC__
#pragma warning (disable: 4800 )
#endif

#include "cpp/compat.h"

static double constant( const char *name, int arg ) 
{
  errno = 0;
  char fl = name[0];

  if( tolower( name[0] ) == 'w' && tolower( name[1] ) == 'x' )
    fl = name[2];

#define r( n ) \
if( strEQ( name, #n ) ) \
  return n;

  switch( fl ) {
  case 'A':
    r( wxALIGN_LEFT );                  // sizer statictext
    r( wxALIGN_CENTRE );                // sizer statictext
    r( wxALIGN_RIGHT );                 // sizer statictext
    r( wxALIGN_TOP );                   // sizer
    r( wxALIGN_BOTTOM );                // sizer
    r( wxALIGN_CENTER_VERTICAL );       // sizer
    r( wxALIGN_CENTER_HORIZONTAL );     // sizer
    r( wxALL );                         // sizer

    r( wxAND );                         // dc
    r( wxAND_INVERT );                  // dc
    r( wxAND_REVERSE );                 // dc

    r( wxAbove );                       // layout constraints
    r( wxAbsolute );                    // layout constraints
    r( wxAsIs );                        // layout constraints
    break;
  case 'B':
    r( wxBITMAP_TYPE_BMP );             // bitmap icon image
    r( wxBITMAP_TYPE_BMP_RESOURCE );    // bitmap icon image
    r( wxBITMAP_TYPE_CUR );             // bitmap icon image
    r( wxBITMAP_TYPE_CUR_RESOURCE );    // bitmap icon image
    r( wxBITMAP_TYPE_ICO );             // bitmap icon image
    r( wxBITMAP_TYPE_ICO_RESOURCE );    // bitmap icon image
    r( wxBITMAP_TYPE_GIF );             // bitmap icon image
    r( wxBITMAP_TYPE_XBM );             // bitmap icon image
    r( wxBITMAP_TYPE_XPM );             // bitmap icon image
    r( wxBITMAP_TYPE_JPEG );            // bitmap icon image
    r( wxBITMAP_TYPE_PNG );             // bitmap icon image
    r( wxBITMAP_TYPE_PNM );             // bitmap icon image
    r( wxBITMAP_TYPE_PCX );             // bitmap icon image
    r( wxBITMAP_TYPE_ANY );             // bitmap icon image
    r( wxBITMAP_TYPE_TIF );             // bitmap icon image

    r( wxBOLD );                        // font
    r( wxBOTH );                        // window dialog frame
    r( wxBOTTOM );                      // sizer
    r( wxBU_TOP );                      // button
    r( wxBU_LEFT );                     // button
    r( wxBU_BOTTOM );                   // button
    r( wxBU_AUTODRAW );                 // button
    r( wxBU_RIGHT );                    // button

    r( wxBDIAGONAL_HATCH );             // brush pen

    r( wxBottom );                      // layout constraints 
    r( wxBelow );                       // layout constraints
    break;
  case 'C':
    r( wxCANCEL );                      // dialog
    r( wxCAPTION );                     // frame dialog

    r( wxCAP_ROUND );                   // pen
    r( wxCAP_PROJECTING );              // pen
    r( wxCAP_BUTT );                    // pen
    r( wxCAP_ROUND );                   // pen

    r( wxCB_SIMPLE );                   // combobox
    r( wxCB_DROPDOWN );                 // combobox
    r( wxCB_READONLY );                 // combobox
    r( wxCB_SORT );                     // combobox
    r( wxCENTRE );                      // dialog sizer
    r( wxCENTER );                      // dialog sizer
    r( wxCLIP_CHILDREN );               // window

    r( wxCLEAR );                       // dc
    r( wxCOPY );                        // dc

    r( wxCURSOR_ARROW );                // cursor
    r( wxCURSOR_BULLSEYE );             // cursor
    r( wxCURSOR_CHAR );                 // cursor
    r( wxCURSOR_CROSS );                // cursor
    r( wxCURSOR_HAND );                 // cursor
    r( wxCURSOR_IBEAM );                // cursor
    r( wxCURSOR_LEFT_BUTTON );          // cursor
    r( wxCURSOR_MAGNIFIER );            // cursor
    r( wxCURSOR_MIDDLE_BUTTON );        // cursor
    r( wxCURSOR_NO_ENTRY );             // cursor
    r( wxCURSOR_PAINT_BRUSH );          // cursor
    r( wxCURSOR_PENCIL );               // cursor
    r( wxCURSOR_POINT_LEFT );           // cursor
    r( wxCURSOR_POINT_RIGHT );          // cursor
    r( wxCURSOR_QUESTION_ARROW );       // cursor
    r( wxCURSOR_RIGHT_BUTTON );         // cursor
    r( wxCURSOR_SIZENESW );             // cursor
    r( wxCURSOR_SIZENS );               // cursor
    r( wxCURSOR_SIZENWSE );             // cursor
    r( wxCURSOR_SIZEWE );               // cursor
    r( wxCURSOR_SIZING );               // cursor
    r( wxCURSOR_SPRAYCAN );             // cursor
    r( wxCURSOR_WAIT );                 // cursor
    r( wxCURSOR_WATCH );                // cursor

    r( wxCROSSDIAG_HATCH );             // brush pen
    r( wxCROSS_HATCH );                 // brush pen

    r( wxCentreX );                     // layout constraints
    r( wxCentreY );                     // layout constraints
    break;
  case 'D':
    r( wxDECORATIVE );                  // font
    r( wxDEFAULT );                     // font
    r( wxDEFAULT_DIALOG_STYLE );        // dialog
    r( wxDEFAULT_FRAME_STYLE );         // frame
    r( wxDIALOG_MODAL );                // dialog
    r( wxDOUBLE_BORDER );               // window

    r( wxDOT );                         // pen
    r( wxDOT_DASH );                    // pen

    break;
  case 'E':
    r( wxEQUIV );                       // dc

    r( wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED );
    r( wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING );
    r( wxEVT_COMMAND_BUTTON_CLICKED );
    r( wxEVT_COMMAND_CHECKBOX_CLICKED );
    r( wxEVT_COMMAND_CHOICE_SELECTED );
    r( wxEVT_COMMAND_LISTBOX_SELECTED );
    r( wxEVT_COMMAND_LISTBOX_DOUBLECLICKED );
    r( wxEVT_COMMAND_CHECKLISTBOX_TOGGLED );
    r( wxEVT_COMMAND_TEXT_UPDATED );
    r( wxEVT_COMMAND_TEXT_ENTER );
    r( wxEVT_COMMAND_MENU_SELECTED );
    r( wxEVT_COMMAND_TOOL_CLICKED );
    r( wxEVT_COMMAND_SLIDER_UPDATED );
    r( wxEVT_COMMAND_RADIOBOX_SELECTED );
    r( wxEVT_COMMAND_RADIOBUTTON_SELECTED );
    r( wxEVT_COMMAND_SCROLLBAR_UPDATED );
    r( wxEVT_COMMAND_VLBOX_SELECTED );
    r( wxEVT_COMMAND_COMBOBOX_SELECTED );
    r( wxEVT_COMMAND_TOOL_RCLICKED );
    r( wxEVT_COMMAND_TOOL_ENTER );
    r( wxEVT_COMMAND_SPINCTRL_UPDATED );

    r( wxEVT_TIMER );

    r( wxEVT_LEFT_DOWN );
    r( wxEVT_LEFT_UP );
    r( wxEVT_MIDDLE_DOWN );
    r( wxEVT_MIDDLE_UP );
    r( wxEVT_RIGHT_DOWN );
    r( wxEVT_RIGHT_UP );
    r( wxEVT_MOTION );
    r( wxEVT_ENTER_WINDOW );
    r( wxEVT_LEAVE_WINDOW );
    r( wxEVT_LEFT_DCLICK );
    r( wxEVT_MIDDLE_DCLICK );
    r( wxEVT_RIGHT_DCLICK );
    r( wxEVT_SET_FOCUS );
    r( wxEVT_KILL_FOCUS );

    r( wxEVT_NC_LEFT_DOWN );
    r( wxEVT_NC_LEFT_UP );
    r( wxEVT_NC_MIDDLE_DOWN );
    r( wxEVT_NC_MIDDLE_UP );
    r( wxEVT_NC_RIGHT_DOWN );
    r( wxEVT_NC_RIGHT_UP );
    r( wxEVT_NC_MOTION );
    r( wxEVT_NC_ENTER_WINDOW );
    r( wxEVT_NC_LEAVE_WINDOW );
    r( wxEVT_NC_LEFT_DCLICK );
    r( wxEVT_NC_MIDDLE_DCLICK );
    r( wxEVT_NC_RIGHT_DCLICK );

    r( wxEVT_CHAR );
    r( wxEVT_CHAR_HOOK );
    r( wxEVT_NAVIGATION_KEY );
    r( wxEVT_KEY_DOWN );
    r( wxEVT_KEY_UP );

    r( wxEVT_SET_CURSOR );

    r( wxEVT_SCROLL_TOP );
    r( wxEVT_SCROLL_BOTTOM );
    r( wxEVT_SCROLL_LINEUP );
    r( wxEVT_SCROLL_LINEDOWN );
    r( wxEVT_SCROLL_PAGEUP );
    r( wxEVT_SCROLL_PAGEDOWN );
    r( wxEVT_SCROLL_THUMBTRACK );
    r( wxEVT_SCROLL_THUMBRELEASE );

    r( wxEVT_SCROLLWIN_TOP );
    r( wxEVT_SCROLLWIN_BOTTOM );
    r( wxEVT_SCROLLWIN_LINEUP );
    r( wxEVT_SCROLLWIN_LINEDOWN );
    r( wxEVT_SCROLLWIN_PAGEUP );
    r( wxEVT_SCROLLWIN_PAGEDOWN );
    r( wxEVT_SCROLLWIN_THUMBTRACK );
    r( wxEVT_SCROLLWIN_THUMBRELEASE );

    r( wxEVT_SIZE );
    r( wxEVT_MOVE );
    r( wxEVT_CLOSE_WINDOW );
    r( wxEVT_END_SESSION );
    r( wxEVT_QUERY_END_SESSION );
    r( wxEVT_ACTIVATE_APP );
    r( wxEVT_POWER );
    r( wxEVT_ACTIVATE );
    r( wxEVT_CREATE );
    r( wxEVT_DESTROY );
    r( wxEVT_SHOW );
    r( wxEVT_ICONIZE );
    r( wxEVT_MAXIMIZE );
    r( wxEVT_MOUSE_CAPTURE_CHANGED );
    r( wxEVT_PAINT );
    r( wxEVT_ERASE_BACKGROUND );
    r( wxEVT_NC_PAINT );
    r( wxEVT_PAINT_ICON );
    r( wxEVT_MENU_CHAR );
    r( wxEVT_MENU_INIT );
    r( wxEVT_MENU_HIGHLIGHT );
    r( wxEVT_POPUP_MENU_INIT );
    r( wxEVT_CONTEXT_MENU );
    r( wxEVT_SYS_COLOUR_CHANGED );
    r( wxEVT_SETTING_CHANGED );
    r( wxEVT_QUERY_NEW_PALETTE );
    r( wxEVT_PALETTE_CHANGED );
    r( wxEVT_JOY_BUTTON_DOWN );
    r( wxEVT_JOY_BUTTON_UP );
    r( wxEVT_JOY_MOVE );
    r( wxEVT_JOY_ZMOVE );
    r( wxEVT_DROP_FILES );
    r( wxEVT_DRAW_ITEM );
    r( wxEVT_MEASURE_ITEM );
    r( wxEVT_COMPARE_ITEM );
    r( wxEVT_INIT_DIALOG );
    r( wxEVT_IDLE );
    r( wxEVT_UPDATE_UI );

    r( wxEVT_END_PROCESS );

    r( wxEVT_DIALUP_CONNECTED );
    r( wxEVT_DIALUP_DISCONNECTED );

    r( wxEVT_COMMAND_LEFT_CLICK );
    r( wxEVT_COMMAND_LEFT_DCLICK );
    r( wxEVT_COMMAND_RIGHT_CLICK );
    r( wxEVT_COMMAND_RIGHT_DCLICK );
    r( wxEVT_COMMAND_SET_FOCUS );
    r( wxEVT_COMMAND_KILL_FOCUS );
    r( wxEVT_COMMAND_ENTER );

    r( wxEXPAND );                      // sizer
    break;
  case 'F':
    r( wxFDIAGONAL_HATCH );             // brush pen

    r( wxFILE_MUST_EXIST );
    r( wxFLOOD_SURFACE );               // dc
    r( wxFLOOD_BORDER );                // dc
    r( wxFONTENCODING_DEFAULT );        // font
    r( wxFONTENCODING_SYSTEM );         // font
    r( wxFRAME_FLOAT_ON_PARENT );       // frame
    r( wxFRAME_TOOL_WINDOW );           // frame

    r( wxFONTENCODING_ISO8859_1 );      // font
    r( wxFONTENCODING_ISO8859_2 );      // font
    r( wxFONTENCODING_ISO8859_3 );      // font
    r( wxFONTENCODING_ISO8859_4 );      // font
    r( wxFONTENCODING_ISO8859_5 );      // font
    r( wxFONTENCODING_ISO8859_6 );      // font
    r( wxFONTENCODING_ISO8859_7 );      // font
    r( wxFONTENCODING_ISO8859_8 );      // font
    r( wxFONTENCODING_ISO8859_9 );      // font
    r( wxFONTENCODING_ISO8859_10 );     // font
    r( wxFONTENCODING_ISO8859_11 );     // font
    r( wxFONTENCODING_ISO8859_12 );     // font
    r( wxFONTENCODING_ISO8859_13 );     // font
    r( wxFONTENCODING_ISO8859_14 );     // font
    r( wxFONTENCODING_ISO8859_15 );     // font
    r( wxFONTENCODING_KOI8 );           // font
    r( wxFONTENCODING_CP1250 );         // font
    r( wxFONTENCODING_CP1251 );         // font
    r( wxFONTENCODING_CP1252 );         // font
    break;
  case 'G':
    r( wxGA_HORIZONTAL );               // gauge
    r( wxGA_VERTICAL );                 // gauge
    r( wxGA_PROGRESSBAR );              // gauge
    r( wxGA_SMOOTH );                   // gauge
    r( wxGROW );                        // sizer
    break;
  case 'H':
    r( wxHIDE_READONLY );               
    r( wxHORIZONTAL );                  // toolbar sizer
    r( wxHORIZONTAL_HATCH );            // dc

    r( wxHSCROLL );                     // window textctrl

    r( wxHeight );                      // layout constraints
    break;
  case 'I':
    r( wxICONIZE );                     // frame
    r( wxICON_EXCLAMATION );            // icon
    r( wxICON_HAND );                   // icon
    r( wxICON_QUESTION );               // icon
    r( wxICON_INFORMATION );            // icon
    r( wxICON_WARNING );                // icon

    r( wxID_OPEN );                     // id
    r( wxID_CLOSE );                    // id
    r( wxID_NEW );                      // id
    r( wxID_SAVE );                     // id
    r( wxID_SAVEAS );                   // id
    r( wxID_REVERT );                   // id
    r( wxID_EXIT );                     // id
    r( wxID_UNDO );                     // id
    r( wxID_REDO );                     // id
    r( wxID_PRINT );                    // id
    r( wxID_PRINT_SETUP );              // id
    r( wxID_PREVIEW );                  // id
    r( wxID_ABOUT );                    // id
    r( wxID_HELP_CONTENTS );            // id
    r( wxID_HELP_COMMANDS );            // id
    r( wxID_HELP_PROCEDURES );          // id
    r( wxID_HELP_CONTEXT );             // id

    r( wxID_CUT );                      // id
    r( wxID_COPY );                     // id
    r( wxID_PASTE );                    // id
    r( wxID_CLEAR );                    // id
    r( wxID_FIND );                     // id
    r( wxID_DUPLICATE );                // id
    r( wxID_SELECTALL );                // id

    r( wxID_FILE1 );                    // id   
    r( wxID_FILE2 );                    // id   
    r( wxID_FILE3 );                    // id   
    r( wxID_FILE4 );                    // id   
    r( wxID_FILE5 );                    // id   
    r( wxID_FILE6 );                    // id   
    r( wxID_FILE7 );                    // id   
    r( wxID_FILE8 );                    // id   
    r( wxID_FILE9 );                    // id   

    r( wxID_OK );                       // id
    r( wxID_CANCEL );                   // id
    r( wxID_APPLY );                    // id
    r( wxID_YES );                      // id
    r( wxID_NO );                       // id
    r( wxID_STATIC );                   // id

    r( wxIMAGELIST_DRAW_NORMAL );       // imagelist
    r( wxIMAGELIST_DRAW_TRANSPARENT );  // imagelist
    r( wxIMAGELIST_DRAW_SELECTED );     // imagelist
    r( wxIMAGELIST_DRAW_FOCUSED );      // imagelist

    r( wxINVERT );                      // dc

    r( wxITALIC );                      // font

    r( wxInRegion );                    // region
    break;
  case 'J':
    r( wxJOIN_BEVEL );                  // pen
    r( wxJOIN_ROUND );                  // pen
    r( wxJOIN_MITER );                  // pen

    r( wxJOYSTICK1 );                   // joystick
    r( wxJOYSTICK2 );                   // joystick
    r( wxJOY_BUTTON1 );                 // joystick
    r( wxJOY_BUTTON2 );                 // joystick
    r( wxJOY_BUTTON3 );                 // joystick
    r( wxJOY_BUTTON4 );                 // joystick
    r( wxJOY_BUTTON_ANY );              // joystick
    break;
  case 'L':
    r( wxLB_SINGLE );                   // listbox
    r( wxLB_MULTIPLE );                 // listbox
    r( wxLB_EXTENDED );                 // listbox
    r( wxLB_HSCROLL );                  // listbox
    r( wxLB_ALWAYS_SB );                // listbox
    r( wxLB_NEEDED_SB );                // listbox
    r( wxLB_SORT );                     // listbox
    r( wxLEFT );                        // sizer layout constraints
    r( wxLIGHT );                       // font

    r( wxLI_HORIZONTAL );               // staticline
    r( wxLI_VERTICAL );                 // staticline

    r( wxLONG_DASH );                   // pen

    r( wxLeft );                        // layout constraints
    r( wxLeftOf );                      // layout constraints
    break;
  case 'M':
    r( wxMAXIMIZE );                    // frame
    r( wxMAXIMIZE_BOX );                // frame
    r( wxMENU_TEAROFF );                // menu
    r( wxMINIMIZE );                    // frame
    r( wxMINIMIZE_BOX );                // frame
    r( wxMODERN );                      // font
    r( wxMULTIPLE );                    
    
    r( wxMM_TWIPS );                    // dc
    r( wxMM_POINTS );                   // dc
    r( wxMM_METRIC );                   // dc
    r( wxMM_LOMETRIC );                 // dc
    r( wxMM_TEXT );                     // dc
    break;
  case 'N':
    r( wxNB_FIXEDWIDTH );               // notebook
    r( wxNB_LEFT );                     // notebook
    r( wxNB_RIGHT );                    // notebook
    r( wxNB_BOTTOM );                   // notebook
    r( wxNO_BORDER );                   // frame toolbar
    r( wxNO_3D );                       // dialog window
    r( wxNO_FULL_REPAINT_ON_RESIZE );   // window
    r( wxNORMAL );                      // font
    r( wxNOT_FOUND );             

    r( wxNAND );                        // dc
    r( wxNOR );                         // dc
    r( wxNO_OP );                       // dc
    break;
  case 'O':
    r( wxOK );
    r( wxOPEN );
    r( wxOVERWRITE_PROMPT );
    
    r( wxOR );                          // dc
    r( wxOR_INVERT );                   // dc
    r( wxOR_REVERSE );                  // dc

    r( wxOutRegion );                   // region
    break;
  case 'P':
    r( wxPROCESS_ENTER );

    r( wxPercentOf );                   // layout constraints
    r( wxPartRegion );                  // layout constraints
    break;
  case 'R':
    r( wxRAISED_BORDER );               // window
    r( wxRA_SPECIFY_ROWS );             // radiobox
    r( wxRA_SPECIFY_COLS );             // radiobox
    r( wxRB_GROUP );                    // radiobutton
    r( wxRESIZE_BORDER );               // dialog frame
    r( wxRETAINED );                    // scrolledwindow
    r( wxRIGHT );                       // sizer layout constraints
    r( wxROMAN );                       // font

    r( wxRight );                       // layout constraints
    r( wxRightOf );                     // layout constraints
    break;
  case 'S':
    r( wxSAVE );
    //    r( wxSB_SIZEGRIP );
    r( wxSB_HORIZONTAL );               // scrollbar
    r( wxSB_VERTICAL );                 // scrollbar
    r( wxSCRIPT );                      // font
    r( wxSIMPLE_BORDER );               // window
    r( wxSLANT );                       // font
    r( wxSTATIC_BORDER );               // window
    r( wxSTAY_ON_TOP );                 // frame dialog
    r( wxST_NO_AUTORESIZE );            // statictext
    r( wxSUNKEN_BORDER );               // window
    r( wxSYSTEM_MENU );                 // frame dialog
    r( wxSWISS );                       // font
    r( wxSL_HORIZONTAL );               // slider
    r( wxSL_VERTICAL );                 // slider
    r( wxSL_AUTOTICKS );                // slider
    r( wxSL_LABELS );                   // slider
    r( wxSL_LEFT );                     // slider
    r( wxSL_RIGHT );                    // slider
    r( wxSL_TOP );                      // slider
    r( wxSL_SELRANGE );                 // slider

    r( wxSP_HORIZONTAL );               // spinbutton
    r( wxSP_VERTICAL );                 // spinbutton
    r( wxSP_ARROW_KEYS );               // spinbutton spinctrl
    r( wxSP_WRAP );                     // spinbutton spinctrl

    r( wxSP_3D );                       // splitterwindow
    r( wxSP_3DSASH );                   // splitterwindow
    r( wxSP_3DBORDER );                 // splitterwindow
    r( wxSP_FULLSASH );                 // splitterwindow
    r( wxSP_BORDER );                   // splitterwindow
    r( wxSP_NOBORDER );                 // splitterwindow
    r( wxSP_PERMIT_UNSPLIT );           // splitterwindow
    r( wxSP_LIVE_UPDATE );              // splitterwindow
    r( wxSPLIT_HORIZONTAL );            // splitterwindow
    r( wxSPLIT_VERTICAL );              // splitterwindow

    r( wxSHAPED );                      // sizer

    r( wxSHORT_DASH );                  // pen
    r( wxSTIPPLE );                     // brush pen
    r( wxSTIPPLE_MASK_OPAQUE );         // brush pen

    r( wxSET );                         // dc
    r( wxSRC_INVERT );                  // dc

    r( wxSOLID );                       // dc brush pen

    r( wxSameAs );                      // layout constraints
    break;
  case 'T':
    r( wxTAB_TRAVERSAL );               // panel
    r( wxTB_FLAT );                     // toolbar
    r( wxTB_DOCKABLE );                 // toolbar
    r( wxTB_HORIZONTAL );               // toolbar
    r( wxTB_VERTICAL );                 // toolbar
    r( wxTB_3DBUTTONS );                // toolbar
    r( wxTE_PROCESS_ENTER );            // textctrl
    r( wxTE_PROCESS_TAB );              // textctrl
    r( wxTE_MULTILINE );                // textctrl
    r( wxTE_PASSWORD );                 // textctrl
    r( wxTE_READONLY );                 // textctrl
    r( wxTE_RICH );                     // textctrl
    r( wxTHICK_FRAME );                 // frame dialog
    r( wxTOP );                         // sizer layout constraints
    r( wxTRANSPARENT_WINDOW );          // window
    r( wxTRANSPARENT );                 // dc brush pen

    r( wxTop );                         // layout constraints
    break;
  case 'U':
    r( wxUnconstrained );               // layout constraints

    r( wxUSER_DASH );                   // pen
    break;
  case 'V':
    r( wxVERTICAL );                    // window dialog frame sizer
    r( wxVERTICAL_HATCH );              // brush pen
    r( wxVSCROLL );                     // window
    break;
  case 'W':
    r( wxWANTS_CHARS );
    r( wxWidth );                       // layout constraints
    break;
  case 'X':
    r( wxXOR );                         // dc
    break;
  case 'Y':
    r( wxYES );
    r( wxYES_NO );
    break;
  default:
    break;
  }

#undef r

  errno = EINVAL;
  return 0;

 not_there:
  errno = ENOENT;
  return 0;
}

void SetConstants()
{
    SV* tmp;

    tmp = get_sv( "Wx::_default_position", 0 );
    sv_setref_pv( tmp, "Wx::Point", new wxPoint( wxDefaultPosition ) );

    tmp = get_sv( "Wx::_default_size", 0 );
    sv_setref_pv( tmp, "Wx::Size", new wxSize( wxDefaultSize ) );

    tmp = get_sv( "Wx::_default_validator", 0 );
    sv_setref_pv( tmp, "Wx::Validator", (wxValidator*)&wxDefaultValidator );

    //
    // Null GDI objects
    //
    tmp = get_sv( "Wx::_null_bitmap", 0 );
    sv_setref_pv( tmp, "Wx::Bitmap", new wxBitmap( wxNullBitmap ) );

    tmp = get_sv( "Wx::_null_icon", 0 );
    sv_setref_pv( tmp, "Wx::Icon", new wxIcon( wxNullIcon ) );

    tmp = get_sv( "Wx::_null_colour", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( wxNullColour ) );

    tmp = get_sv( "Wx::_null_cursor", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( wxNullCursor ) );

    tmp = get_sv( "Wx::_null_font", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( wxNullFont ) );

    tmp = get_sv( "Wx::_null_pen", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( wxNullPen ) );

    tmp = get_sv( "Wx::_null_brush", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( wxNullBrush ) );

    //
    // Predefined colours
    //
    tmp = get_sv( "Wx::_colour_black", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxBLACK ) );

    tmp = get_sv( "Wx::_colour_red", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxRED ) );

    tmp = get_sv( "Wx::_colour_green", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxGREEN ) );

    tmp = get_sv( "Wx::_colour_blue", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxBLUE ) );

    tmp = get_sv( "Wx::_colour_white", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxWHITE ) );

    tmp = get_sv( "Wx::_colour_cyan", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxCYAN ) );

    tmp = get_sv( "Wx::_colour_light_grey", 0 );
    sv_setref_pv( tmp, "Wx::Colour", new wxColour( *wxLIGHT_GREY ) );


    //
    // predefined cursors
    //
    tmp = get_sv( "Wx::_cursor_standard", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( *wxSTANDARD_CURSOR ) );

    tmp = get_sv( "Wx::_cursor_hourglass", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( *wxHOURGLASS_CURSOR ) );

    tmp = get_sv( "Wx::_cursor_cross", 0 );
    sv_setref_pv( tmp, "Wx::Cursor", new wxCursor( *wxCROSS_CURSOR ) );

    //
    // predefined fonts
    //
    tmp = get_sv( "Wx::_font_normal", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxNORMAL_FONT ) );

    tmp = get_sv( "Wx::_font_small", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxSMALL_FONT ) );

    tmp = get_sv( "Wx::_font_italic", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxITALIC_FONT ) );

    tmp = get_sv( "Wx::_font_swiss", 0 );
    sv_setref_pv( tmp, "Wx::Font", new wxFont( *wxSWISS_FONT ) );

    //
    // predefined pens
    //
    tmp = get_sv( "Wx::_pen_red", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxRED_PEN ) );

    tmp = get_sv( "Wx::_pen_cyan", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxCYAN_PEN ) );

    tmp = get_sv( "Wx::_pen_green", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxGREEN_PEN ) );

    tmp = get_sv( "Wx::_pen_black", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxBLACK_PEN ) );

    tmp = get_sv( "Wx::_pen_white", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxWHITE_PEN ) );

    tmp = get_sv( "Wx::_pen_transparent", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxTRANSPARENT_PEN ) );

    tmp = get_sv( "Wx::_pen_black_dashed", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxBLACK_DASHED_PEN ) );

    tmp = get_sv( "Wx::_pen_grey", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxGREY_PEN ) );

    tmp = get_sv( "Wx::_pen_medium_grey", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxMEDIUM_GREY_PEN ) );

    tmp = get_sv( "Wx::_pen_light_grey", 0 );
    sv_setref_pv( tmp, "Wx::Pen", new wxPen( *wxLIGHT_GREY_PEN ) );

    //
    // Predefined brushes
    //
    tmp = get_sv( "Wx::_brush_blue", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxBLUE_BRUSH ) );

    tmp = get_sv( "Wx::_brush_green", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxGREEN_BRUSH ) );

    tmp = get_sv( "Wx::_brush_white", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxWHITE_BRUSH ) );

    tmp = get_sv( "Wx::_brush_black", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxBLACK_BRUSH ) );

    tmp = get_sv( "Wx::_brush_grey", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxGREY_BRUSH ) );

    tmp = get_sv( "Wx::_brush_medium_grey", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxMEDIUM_GREY_BRUSH ) );

    tmp = get_sv( "Wx::_brush_light_grey", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxLIGHT_GREY_BRUSH ) );

    tmp = get_sv( "Wx::_brush_transparent", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxTRANSPARENT_BRUSH ) );

    tmp = get_sv( "Wx::_brush_cyan", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxCYAN_BRUSH ) );

    tmp = get_sv( "Wx::_brush_red", 0 );
    sv_setref_pv( tmp, "Wx::Brush", new wxBrush( *wxRED_BRUSH ) );

    //
    // Miscellaneous
    //
    tmp = get_sv( "Wx::_version_string", 0 );
    sv_setpv( tmp, wxVERSION_STRING );

    tmp = get_sv( "Wx::_platform", 0 );
#if __WXMSW__
    sv_setiv( tmp, 1 );
#elif __WXGTK__
    sv_setiv( tmp, 2 );
#else
    sv_setiv( tmp, 3 );
#endif
}

MODULE=Wx_Const PACKAGE=Wx

double
constant(name,arg)
    const char* name
    int arg



