/////////////////////////////////////////////////////////////////////////////
// Name:        Constant.xs
// Purpose:     defines the constant() and SetConstants() functions
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      $Id: Constant.xs,v 1.82 2003/05/12 17:02:43 mbarbon Exp $
// Copyright:   (c) 2000-2003 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#undef bool
#define PERL_NO_GET_CONTEXT
#define WXINTL_NO_GETTEXT_MACRO 1

#include <wx/defs.h>

#include <wx/filedlg.h>
#include <wx/colordlg.h>
#include <wx/textdlg.h>
#include <wx/choicdlg.h>
#include <wx/msgdlg.h>
#include <wx/gdicmn.h>
#include <wx/bitmap.h>
#include <wx/intl.h>
#include <wx/icon.h>
#include <wx/imaglist.h>
#include <wx/notebook.h>
#include <wx/dialup.h>
#include <wx/process.h>
#include <wx/pen.h>
#include <wx/brush.h>
#include <wx/layout.h>
#include <wx/splitter.h>
#include <wx/sashwin.h>
#include <wx/textctrl.h>
#include <wx/settings.h>
#include <wx/button.h>
#include <wx/dataobj.h>
#include <wx/clipbrd.h>
#include <wx/confbase.h>
#include <wx/image.h>
#include <wx/sizer.h>
#if defined(__WXMSW__)
#include <wx/taskbar.h>
#endif
#include <wx/process.h>
#include <wx/wizard.h>
#include <wx/filefn.h>

#include "cpp/wxapi.h"

#include <wx/tglbtn.h>
#include <wx/splash.h>
#include <wx/fdrepdlg.h>
#include <wx/list.h>

//////////////////////////////////////////////////////////////////////////////
// implementation for wxPlConstantsModule OnInit/OnExit
//////////////////////////////////////////////////////////////////////////////

#include "cpp/constants.h"
#include <wx/listimpl.cpp>

WX_DECLARE_LIST( PL_CONST_FUNC, wxPlConstantFunctions );
WX_DEFINE_LIST( wxPlConstantFunctions );

static wxPlConstantFunctions& s_functions()
{
    static wxPlConstantFunctions* var = new wxPlConstantFunctions;

    return *var;
}

void wxPli_add_constant_function( double (**f)( const char*, int ) )
{
    s_functions().Append( f );
}

void wxPli_remove_constant_function( double (**f)( const char*, int ) )
{
    s_functions().DeleteObject( f );
}

//////////////////////////////////////////////////////////////////////////////
// descriptor for all event macros
//////////////////////////////////////////////////////////////////////////////

struct wxPlEVT
{
    // 2 - only THIS and function
    // 3 - THIS, function, one ID
    // 4 - THIS, function, two ids
    // 5 - THIS, function, two ids, event id
    const char* name;
    unsigned char args;
    int evtID;    
};

#define SEVT( NAME, ARGS ) { #NAME, ARGS, wx##NAME },
#define EVT( NAME, ARGS, ID ) { #NAME, ARGS, ID },

// !package: Wx::Event
// !tag:
// !parser: sub { $_[0] =~ m<^\s*S?EVT\(\s*(\w+)\s*\,> }

static wxPlEVT evts[] =
{
    SEVT( EVT_WIZARD_PAGE_CHANGED, 3 )
    SEVT( EVT_WIZARD_PAGE_CHANGING, 3 )
    SEVT( EVT_WIZARD_CANCEL, 3 )
    SEVT( EVT_WIZARD_HELP, 3 )
    { 0, 0, 0 }
};

#if 0
	wxWindowID	id;
	int	lastid = (int)SvIV(ST(2));
	wxEventType	type = (wxEventType)SvIV(ST(3));
	SV*	method = ST(4);
	Wx_EvtHandler *	THIS;

    id = wxPli_get_wxwindowid( aTHX_ ST(1) );;

    THIS = (Wx_EvtHandler *) wxPli_sv_2_object( aTHX_ ST(0), "Wx::EvtHandler" );;
    THIS->Connect(id, lastid, type,
                    (wxObjectEventFunction)&wxPliEventCallback::Handler,
                    new wxPliEventCallback( method, ST(0) ) );
#endif

#include "cpp/e_cback.h"

// THIS, ID, function
XS(Connect3);
XS(Connect3)
{
    dXSARGS;
    assert( items == 3 );
    SV* THISs = ST(0);
    wxEvtHandler *THISo =
        (wxEvtHandler*)wxPli_sv_2_object( aTHX_ THISs, "Wx::EvtHandler" );
    wxWindowID id = wxPli_get_wxwindowid( aTHX_ ST(1) );
    SV* func = ST(2);
    I32 evtID = CvXSUBANY(cv).any_i32;

    if( SvOK( func ) )
    {
        THISo->Connect( id, -1, evtID,
                        (wxObjectEventFunction)&wxPliEventCallback::Handler,
                        new wxPliEventCallback( func, THISs ) );
    }
    else
    {
        THISo->Disconnect( id, -1, evtID,
                           (wxObjectEventFunction)&wxPliEventCallback::Handler,
                           0 );
    }
}

void CreateEventMacro( const char* name, unsigned char args, int id )
{
    char buffer[1024];
    CV* cv;
    dTHX;

    strcpy( buffer, "Wx::Event::" );
    strcat( buffer, name );

    switch( args )
    {
    case 3:
        cv = (CV*)newXS( buffer, Connect3, "Constants.xs" );
        sv_setpv((SV*)cv, "$$$");
        break;
    }

    CvXSUBANY(cv).any_i32 = id;
}

void SetEvents()
{
    for( size_t i = 0; evts[i].name != 0; ++i )
        CreateEventMacro( evts[i].name, evts[i].args, evts[i].evtID );
}

//////////////////////////////////////////////////////////////////////////////
// the inheritance tree
//////////////////////////////////////////////////////////////////////////////

struct wxPlINH
{
    const char* klass;
    const char* base;
};

#define I( class, base ) \
    { "Wx::" #class, "Wx::" #base },

static wxPlINH inherit[] =
{
    I( Window,          EvtHandler )
    I( Menu,            EvtHandler )
    I( MenuBar,         Window )
    I( TopLevelWindow,  Window )
    I( _App,            EvtHandler )
    I( Panel,           Window )
    I( Control,         Window )
    I( Button,          Control )
    I( BitmapButton,    Button )
    I( TextCtrl,        Control )
    I( StaticText,      Control )
    I( CheckBox,        Control )
    I( CheckListBox,    ListBox )
    I( ControlWithItems,Control )
    I( Choice,          ControlWithItems )
    I( ListBox,         ControlWithItems )
    I( Notebook,        Control )
    I( ToolBarBase,     Control )
    I( ToolBarSimple,   Control )
    I( StaticBitmap,    Control )
    I( Gauge,           Control )
    I( Gauge95,         Gauge )
    I( Slider,          Control )
    I( SpinCtrl,        Control )
    I( SpinButton,      Control )
    I( RadioBox,        Control )
    I( RadioButton,     Control )
    I( StaticLine,      Control )
    I( StaticBox,       Control )
    I( ScrollBar,       Control )
    I( StatusBarGeneric,Window )
    I( GenericScrolledWindow, Panel )
    I( GenericTreeCtrl, ScrolledWindow )
    I( MiniFrame,       Frame )
    I( SplitterWindow,  Window )
    I( SplashScreen,    Frame )
    I( ListCtrl,        Control )
    I( ListView,        ListCtrl )
    I( SashWindow,      Window )
    I( ToggleButton,    Control )
    I( Wizard,          Dialog )
    I( WizardPage,      Panel )
    I( WizardPageSimple, WizardPage )

    I( ColourDialog,    Dialog )
    I( GenericColourDialog, ColourDialog )
    I( FindReplaceDialog, Dialog )
    I( FontDialog,      Dialog )
    I( DirDialog,       Dialog )
#if defined(__WXGTK__)
    I( GenericFileDialog, Dialog )
    I( FileDialog,      GenericFileDialog )
#else
    I( FileDialog,      Dialog )
#endif
    I( TextEntryDialog, Dialog )
    I( MessageDialog,   Dialog )
    I( GenericMessageDialog, MessageDialog )
    I( ProgressDialog,  Dialog )
    I( SingleChoiceDialog, Dialog )
    I( MultiChoiceDialog, Dialog )

    I( Validator,       EvtHandler )
    I( TextValidator,   Validator )
    I( GenericValidator, Validator )
    I( PlValidator,     Validator )

    I( Font,            GDIObject )
    I( Region,          GDIObject )
    I( Bitmap,          GDIObject )
    I( Brush,           GDIObject )
    I( Pen,             GDIObject )
    I( Palette,         GDIObject )

    I( WindowDC,        DC )
    I( ClientDC,        WindowDC )

    I( BMPHandler,      ImageHandler )
    I( PNGHandler,      ImageHandler )
    I( JPEGHandler,     ImageHandler )
    I( GIFHandler,      ImageHandler )
    I( PCXHandler,      ImageHandler )
    I( PNMHandler,      ImageHandler )
    I( TIFFHandler,     ImageHandler )
    I( XPMHandler,      ImageHandler )
    I( IFFHandler,      ImageHandler )
    I( ICOHandler,      BMPHandler )
    I( CURHandler,      ICOHandler )
    I( ANIHandler,      CURHandler )

    I( LogTextCtrl,     Log )
    I( LogWindow,       Log )
    I( LogGui,          Log )
    I( PlLog,           Log )
    I( LogChain,        Log )
    I( LogPassThrough,  LogChain )
    I( PlLogPassThrough, LogPassThrough )

    I( BoxSizer,        Sizer )
    I( StaticBoxSizer,  BoxSizer )
    I( GridSizer,       Sizer )
    I( FlexGridSizer,   GridSizer )
    I( NotebookSizer,   Sizer )
    I( PlSizer,         Sizer )

    I( TaskBarIcon,     EvtHandler )
    I( Process,         EvtHandler )

    { "Wx::Stream", "Tie::Handle" },
    I( InputStream,     Stream )
    I( OutputStream,    Stream )

    ///////////////////////////////////////////
    // Conditional part
    ///////////////////////////////////////////
#define HAS_TLW    !defined(__WXMOTIF__) || WXPERL_W_VERSION_GE( 2, 5, 0 )

#if HAS_TLW
    I( Frame,           TopLevelWindow )
#else
    I( Frame,           Window )
#endif

#if HAS_TLW
    I( Dialog,          TopLevelWindow )
#else
    I( Dialog,          Panel )
#endif

#if defined(__WXMSW__)
    I( MemoryDC,        DC )
#elif defined(__WXMAC__)
    I( MemoryDC,        PaintDC )
#else
    I( MemoryDC,        WindowDC )
#endif

#if defined(__WXMSW__) || defined(__WXGTK__)
    I( PaintDC,         ClientDC )
#else
    I( PaintDC,         WindowDC )
#endif

#if defined(__WXGTK__)
    I( ScreenDC,        PaintDC )
#else
    I( ScreenDC,        WindowDC )
#endif

#if defined(__WXMSW__)
    I( TreeCtrl,        Control )
#else
    I( TreeCtrl,        GenericTreeCtrl )
#endif

#if defined(__WXGTK__)
    I( ComboBox,        Control )
#else
    I( ComboBox,        Choice )
#endif

    I( ScrolledWindow,  GenericScrolledWindow )

#if defined(__WXGTK__)
    I( StatusBar,       StatusBarGeneric )
#else
    I( StatusBar,       Window )
#endif

#if defined(__WXMOTIF__) && WXPERL_W_VERSION_GE( 2, 5, 0 )
    // wxCursor inherits from wxObject
#elif defined(__WXMOTIF__) || defined(__WXMAC__)
    I( Cursor,          Bitmap )
#elif !defined(__WXGTK__)
    I( Cursor,          GDIObject )
#endif

#if defined(__WXGTK__) || defined(__WXMOTIF__) || defined(__WXMAC__)
    I( Icon,            Bitmap )
#else
    I( Icon,            GDIObject )
#endif

#if defined(__WXGTK__)
    I( Colour,          GDIObject )
#endif

#if defined(__WXUNIVERSAL__)
    I( ToolBar,         ToolBarSimple )
#else
    I( ToolBar,         ToolBarBase )
#endif

    ///////////////////////////////////////////
    // Events
    ///////////////////////////////////////////
    I( PlEvent,         Event )
    I( PlThreadEvent,   Event )
    I( PlCommandEvent,  CommandEvent )
    I( ActivateEvent,   Event )
    I( CommandEvent,    Event )
    I( CloseEvent,      Event )
    I( EraseEvent,      Event )
    I( FindDialogEvent, CommandEvent )
    I( FocusEvent,      Event )
    I( KeyEvent,        Event )
    I( HelpEvent,       CommandEvent )
    I( IconizeEvent,    Event )
    I( IdleEvent,       Event )
    I( InitDialogEvent, Event )
    I( JoystickEvent,   Event )
    I( ListEvent,       NotifyEvent )
    I( MenuEvent,       Event )
    I( MouseEvent,      Event )
    I( MoveEvent,       Event )
    I( NotebookEvent,   NotifyEvent )
    I( NotifyEvent,     CommandEvent )
    I( PaintEvent,      Event )
    I( ProcessEvent,    Event )
    I( QueryLayoutInfoEvent, Event )
    I( SashEvent,       CommandEvent )
    I( ScrollEvent,     CommandEvent )
    I( SizeEvent,       Event )
    I( ScrollWinEvent,  Event )
#if defined(__WXMAC__)
    I( SpinEvent,       ScrollEvent )
#else
    I( SpinEvent,       NotifyEvent )
#endif
    I( SysColourChangedEvent, Event )
    I( TextUrlEvent,    CommandEvent )
    I( TimerEvent,      Event )
    I( TreeEvent,       NotifyEvent )
    I( UpdateUIEvent,   CommandEvent )
    I( WizardEvent,     NotifyEvent )

    I( SplitterEvent,   NotifyEvent )

    { 0, 0 }
};

void SetInheritance()
{
    dTHX;

    for( size_t i = 0; inherit[i].klass; ++i )
    {
        char buffer[1024];
        strcpy( buffer, inherit[i].klass );
        strcat( buffer, "::ISA" );

        AV* isa = get_av( buffer, 1 );
        av_store( isa, 0, newSVpv( CHAR_P inherit[i].base, 0 ) );
    }
}

//////////////////////////////////////////////////////////////////////////////
// the constant() function
//////////////////////////////////////////////////////////////////////////////

// !package: Wx
// !tag:

static double constant( const char *name, int arg ) 
{
  WX_PL_CONSTANT_INIT();

  // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
#define r( n ) \
    if( strEQ( name, #n ) ) \
        return n;

  switch( fl ) {
  case 'A':
    r( wxALIGN_LEFT );                  // sizer grid statictext
    r( wxALIGN_CENTRE );                // sizer grid statictext
    r( wxALIGN_CENTER );                // sizer grid statictext
    r( wxALIGN_RIGHT );                 // sizer grid statictext
    r( wxALIGN_TOP );                   // sizer grid
    r( wxALIGN_BOTTOM );                // sizer grid
    r( wxALIGN_CENTER_VERTICAL );       // sizer
    r( wxALIGN_CENTER_HORIZONTAL );     // sizer
    r( wxALIGN_CENTRE_VERTICAL );       // sizer
    r( wxALIGN_CENTRE_HORIZONTAL );     // sizer
    r( wxALL );                         // sizer

    r( wxACCEL_ALT );
    r( wxACCEL_CTRL );
    r( wxACCEL_NORMAL );
    r( wxACCEL_SHIFT );

    r( wxAND );                         // dc
    r( wxAND_INVERT );                  // dc
    r( wxAND_REVERSE );                 // dc

    r( wxADJUST_MINSIZE );              // layout sizer
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

    // !export: Type_Boolean
    if( strEQ( name, "Type_Boolean" ) )
        return wxConfigBase::Type_Boolean;
    r( wxBU_EXACTFIT );                 // button

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
    r( wxCENTER );                      // dialog sizer
    r( wxCENTRE );                      // dialog sizer
    r( wxCLIP_CHILDREN );               // window
    r( wxCHOICEDLG_STYLE );
    r( wxCHANGE_DIR );                  // filedlg
    r( wxCLIP_SIBLINGS );               // window

    r( wxCLEAR );                       // dc
    r( wxCOPY );                        // dc

    r( wxCONFIG_USE_LOCAL_FILE );       // config
    r( wxCONFIG_USE_GLOBAL_FILE );      // config
    r( wxCONFIG_USE_RELATIVE_PATH );    // config

    r( wxCURSOR_ARROW );                // cursor
    r( wxCURSOR_ARROWWAIT );            // cursor
    r( wxCURSOR_RIGHT_ARROW );          // cursor
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

#define wxCenterX wxCentreX
#define wxCenterY wxCentreY

    r( wxCentreX );                     // layout constraints
    r( wxCentreY );                     // layout constraints
    r( wxCenterX );                     // layout constraints
    r( wxCenterY );                     // layout constraints
    break;
  case 'D':
    r( wxDECORATIVE );                  // font
    r( wxDEFAULT );                     // font
    r( wxDEFAULT_DIALOG_STYLE );        // dialog
    r( wxDEFAULT_FRAME_STYLE );         // frame
    r( wxDIALOG_MODAL );                // dialog
    r( wxDOUBLE_BORDER );               // window
    r( wxDIALOG_NO_PARENT );            // dialog
    r( wxDIALOG_EX_CONTEXTHELP );       // dialog

    r( wxDD_NEW_DIR_BUTTON );

    r( wxDOT );                         // pen
    r( wxDOT_DASH );                    // pen

    r( wxDIR );
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
#if wxPERL_USE_TOGGLEBTN
    r( wxEVT_COMMAND_TOGGLEBUTTON_CLICKED );
#endif
    r( wxEVT_COMMAND_TEXT_MAXLEN );
    r( wxEVT_COMMAND_TEXT_URL );
    r( wxEVT_COMMAND_TOOL_RCLICKED );
    r( wxEVT_COMMAND_TOOL_ENTER );
    r( wxEVT_COMMAND_SPINCTRL_UPDATED );
    r( wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING );
    r( wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED );
    r( wxEVT_COMMAND_SPLITTER_UNSPLIT );
    r( wxEVT_COMMAND_SPLITTER_DOUBLECLICKED );

    r( wxEVT_TIMER );

#if defined(__WXMSW__)
    r( wxEVT_TASKBAR_MOVE );
    r( wxEVT_TASKBAR_LEFT_DOWN );
    r( wxEVT_TASKBAR_LEFT_UP );
    r( wxEVT_TASKBAR_RIGHT_DOWN );
    r( wxEVT_TASKBAR_RIGHT_UP );
    r( wxEVT_TASKBAR_LEFT_DCLICK );
    r( wxEVT_TASKBAR_RIGHT_DCLICK );
#endif
    r( wxEVT_COMMAND_FIND );
    r( wxEVT_COMMAND_FIND_NEXT );
    r( wxEVT_COMMAND_FIND_REPLACE );
    r( wxEVT_COMMAND_FIND_REPLACE_ALL );
    r( wxEVT_COMMAND_FIND_CLOSE );

    r( wxEVT_MOUSEWHEEL )
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

    r( wxEVT_SASH_DRAGGED );

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
    // r( wxEVT_MENU_CHAR );
    // r( wxEVT_MENU_INIT );
    r( wxEVT_MENU_HIGHLIGHT );
    r( wxEVT_MENU_OPEN );
    r( wxEVT_MENU_CLOSE );
    // r( wxEVT_POPUP_MENU_INIT );
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

    //r( wxEVT_DIALUP_CONNECTED );
    //r( wxEVT_DIALUP_DISCONNECTED );

    r( wxEVT_COMMAND_LEFT_CLICK );
    r( wxEVT_COMMAND_LEFT_DCLICK );
    r( wxEVT_COMMAND_RIGHT_CLICK );
    r( wxEVT_COMMAND_RIGHT_DCLICK );
    r( wxEVT_COMMAND_SET_FOCUS );
    r( wxEVT_COMMAND_KILL_FOCUS );
    r( wxEVT_COMMAND_ENTER );

    r( wxEVT_HELP );
    r( wxEVT_DETAILED_HELP );

//    r( wxEVT_WIZARD_PAGE_CHANGED );
//    r( wxEVT_WIZARD_PAGE_CHANGING );
//    r( wxEVT_WIZARD_CANCEL );
//    r( wxEVT_WIZARD_HELP );

    r( wxEXPAND );                      // sizer
    r( wxEXEC_SYNC );
    r( wxEXEC_ASYNC );
    r( wxEXEC_NOHIDE );
    break;
  case 'F':
    r( wxFDIAGONAL_HATCH );             // brush pen

    r( wxFILE_MUST_EXIST );
    r( wxFLOOD_SURFACE );               // dc
    r( wxFLOOD_BORDER );                // dc

#if WXPERL_W_VERSION_GE( 2, 5, 0 )
    r( wxFLEX_GROWMODE_NONE );          // sizer
    r( wxFLEX_GROWMODE_SPECIFIED );     // sizer
    r( wxFLEX_GROWMODE_ALL );           // sizer
#endif
    r( wxFONTENCODING_DEFAULT );        // font
    r( wxFONTENCODING_SYSTEM );         // font
    r( wxFRAME_FLOAT_ON_PARENT );       // frame
    r( wxFRAME_NO_WINDOW_MENU );
    r( wxFRAME_NO_TASKBAR );            // frame
    r( wxFRAME_TOOL_WINDOW );           // frame
    r( wxFRAME_EX_CONTEXTHELP );        // frame
#if WXPERL_W_VERSION_GE( 2, 4, 1 )
    r( wxFRAME_SHAPED );                // frame
#endif

    r( wxFILE );

    r( wxFR_DOWN );                     // findreplace
    r( wxFR_WHOLEWORD );                // findreplace
    r( wxFR_MATCHCASE );                // findreplace
    r( wxFR_REPLACEDIALOG );            // findreplace
    r( wxFR_NOUPDOWN );                 // findreplace
    r( wxFR_NOMATCHCASE );              // findreplace
    r( wxFR_NOWHOLEWORD );              // findreplace
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
    r( wxFONTENCODING_ALTERNATIVE );    // font
    r( wxFONTENCODING_BULGARIAN );      // font
    r( wxFONTENCODING_CP437 );          // font
    r( wxFONTENCODING_CP850 );          // font
    r( wxFONTENCODING_CP852 );          // font
    r( wxFONTENCODING_CP855 );          // font
    r( wxFONTENCODING_CP866 );          // font
    r( wxFONTENCODING_CP874 );          // font
    r( wxFONTENCODING_CP1250 );         // font
    r( wxFONTENCODING_CP1251 );         // font
    r( wxFONTENCODING_CP1252 );         // font
    r( wxFONTENCODING_CP1253 );         // font
    r( wxFONTENCODING_CP1254 );         // font
    r( wxFONTENCODING_CP1255 );         // font
    r( wxFONTENCODING_CP1256 );         // font
    r( wxFONTENCODING_CP1257 );         // font
    r( wxFONTENCODING_UTF7 );           // font
    r( wxFONTENCODING_UTF8 );           // font
    r( wxFONTENCODING_UNICODE );        // font

    // !export: Type_Float
    if( strEQ( name, "Type_Float" ) )
        return wxConfigBase::Type_Float;
    break;
  case 'G':
    r( wxGA_HORIZONTAL );               // gauge
    r( wxGA_VERTICAL );                 // gauge
    r( wxGA_PROGRESSBAR );              // gauge
    r( wxGA_SMOOTH );                   // gauge
    r( wxGROW );                        // sizer
    break;
  case 'H':
    r( wxHIDE_READONLY );               // filedialog
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
    r( wxICON_ERROR );                  // icon

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
    r( wxID_HELP );                     // id
    r( wxID_HIGHEST );
    r( wxID_LOWEST );

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

    r( wxID_CONTEXT_HELP );             // id
    r( wxID_YESTOALL );                 // id
    r( wxID_NOTOALL );                  // id
    r( wxID_ABORT );                    // id
    r( wxID_RETRY );                    // id
    r( wxID_IGNORE );                   // id

    r( wxIMAGELIST_DRAW_NORMAL );       // imagelist
    r( wxIMAGELIST_DRAW_TRANSPARENT );  // imagelist
    r( wxIMAGELIST_DRAW_SELECTED );     // imagelist
    r( wxIMAGELIST_DRAW_FOCUSED );      // imagelist

    r( wxINVERT );                      // dc

    r( wxITALIC );                      // font

    r( wxInRegion );                    // region

    r( wxITEM_SEPARATOR );              // menu
    r( wxITEM_NORMAL );                 // menu
    r( wxITEM_CHECK );                  // menu
    r( wxITEM_RADIO );                  // menu

    // !export: Type_Integer
    if( strEQ( name, "Type_Integer" ) )
        return wxConfigBase::Type_Integer;
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
  case 'K':
    if( strnEQ( name, "WXK_", 4 ) )
    {
        r( WXK_BACK );                  // keycode
        r( WXK_TAB );                   // keycode
        r( WXK_RETURN );                // keycode
        r( WXK_ESCAPE );                // keycode
        r( WXK_SPACE );                 // keycode
        r( WXK_DELETE );                // keycode
        r( WXK_START );                 // keycode
        r( WXK_LBUTTON );               // keycode
        r( WXK_RBUTTON );               // keycode
        r( WXK_CANCEL );                // keycode
        r( WXK_MBUTTON );               // keycode
        r( WXK_CLEAR );                 // keycode
        r( WXK_SHIFT );                 // keycode
        r( WXK_CONTROL );               // keycode
        r( WXK_MENU );                  // keycode
        r( WXK_PAUSE );                 // keycode
        r( WXK_CAPITAL );               // keycode
        r( WXK_PRIOR );                 // keycode
        r( WXK_NEXT );                  // keycode
        r( WXK_END );                   // keycode
        r( WXK_HOME );                  // keycode
        r( WXK_LEFT );                  // keycode
        r( WXK_UP );                    // keycode
        r( WXK_RIGHT );                 // keycode
        r( WXK_DOWN );                  // keycode
        r( WXK_SELECT );                // keycode
        r( WXK_PRINT );                 // keycode
        r( WXK_EXECUTE );               // keycode
        r( WXK_SNAPSHOT );              // keycode
        r( WXK_INSERT );                // keycode
        r( WXK_HELP );                  // keycode
        r( WXK_NUMPAD0 );               // keycode
        r( WXK_NUMPAD1 );               // keycode
        r( WXK_NUMPAD2 );               // keycode
        r( WXK_NUMPAD3 );               // keycode
        r( WXK_NUMPAD4 );               // keycode
        r( WXK_NUMPAD5 );               // keycode
        r( WXK_NUMPAD6 );               // keycode
        r( WXK_NUMPAD7 );               // keycode
        r( WXK_NUMPAD8 );               // keycode
        r( WXK_NUMPAD9 );               // keycode
        r( WXK_MULTIPLY );              // keycode
        r( WXK_ADD );                   // keycode
        r( WXK_SEPARATOR );             // keycode
        r( WXK_SUBTRACT );              // keycode
        r( WXK_DECIMAL );               // keycode
        r( WXK_DIVIDE );                // keycode
        r( WXK_F1 );                    // keycode
        r( WXK_F2 );                    // keycode
        r( WXK_F3 );                    // keycode
        r( WXK_F4 );                    // keycode
        r( WXK_F5 );                    // keycode
        r( WXK_F6 );                    // keycode
        r( WXK_F7 );                    // keycode
        r( WXK_F8 );                    // keycode
        r( WXK_F9 );                    // keycode
        r( WXK_F10 );                   // keycode
        r( WXK_F11 );                   // keycode
        r( WXK_F12 );                   // keycode
        r( WXK_F13 );                   // keycode
        r( WXK_F14 );                   // keycode
        r( WXK_F15 );                   // keycode
        r( WXK_F16 );                   // keycode
        r( WXK_F17 );                   // keycode
        r( WXK_F18 );                   // keycode
        r( WXK_F19 );                   // keycode
        r( WXK_F20 );                   // keycode
        r( WXK_F21 );                   // keycode
        r( WXK_F22 );                   // keycode
        r( WXK_F23 );                   // keycode
        r( WXK_F24 );                   // keycode
        r( WXK_NUMLOCK );               // keycode
        r( WXK_SCROLL  );               // keycode
    }

    r( wxKILL_OK );                     // process
    r( wxKILL_BAD_SIGNAL );             // process
    r( wxKILL_ACCESS_DENIED );          // process
    r( wxKILL_NO_PROCESS );             // process
    r( wxKILL_ERROR );                  // process
    break;
  case 'L':
    r( wxLB_SINGLE );                   // listbox
    r( wxLB_MULTIPLE );                 // listbox
    r( wxLB_EXTENDED );                 // listbox
    r( wxLB_HSCROLL );                  // listbox
    r( wxLB_ALWAYS_SB );                // listbox
    r( wxLB_NEEDED_SB );                // listbox
    r( wxLB_OWNERDRAW );                // listbox
    r( wxLB_SORT );                     // listbox
    r( wxLEFT );                        // sizer layout constraints
    r( wxLIGHT );                       // font

    r( wxLI_HORIZONTAL );               // staticline
    r( wxLI_VERTICAL );                 // staticline

    r( wxLONG_DASH );                   // pen

    r( wxLeft );                        // layout constraints
    r( wxLeftOf );                      // layout constraints

    r( wxLOCALE_LOAD_DEFAULT );         // locale
    r( wxLOCALE_CONV_ENCODING );        // locale

    if( strnEQ( name, "wxLANGUAGE_", 11 ) )
    {
      // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> && return ( "wxLANGUAGE_" . $1, $2 ) }
#define rr( n ) \
    if( strEQ( nm, #n ) ) \
        return wxLANGUAGE_##n;
        const char* nm = name + 11;

        rr( DEFAULT );                  // locale
        rr( UNKNOWN );                  // locale
        rr( ABKHAZIAN );                // locale
        rr( AFAR );                     // locale
        rr( AFRIKAANS );                // locale
        rr( ALBANIAN );                 // locale
        rr( AMHARIC );                  // locale
        rr( ARABIC );                   // locale
        rr( ARABIC_ALGERIA );           // locale
        rr( ARABIC_BAHRAIN );           // locale
        rr( ARABIC_EGYPT );             // locale
        rr( ARABIC_IRAQ );              // locale
        rr( ARABIC_JORDAN );            // locale
        rr( ARABIC_KUWAIT );            // locale
        rr( ARABIC_LEBANON );           // locale
        rr( ARABIC_LIBYA );             // locale
        rr( ARABIC_MOROCCO );           // locale
        rr( ARABIC_OMAN );              // locale
        rr( ARABIC_QATAR );             // locale
        rr( ARABIC_SAUDI_ARABIA );      // locale
        rr( ARABIC_SUDAN );             // locale
        rr( ARABIC_SYRIA );             // locale
        rr( ARABIC_TUNISIA );           // locale
        rr( ARABIC_UAE );               // locale
        rr( ARABIC_YEMEN );             // locale
        rr( ARMENIAN );                 // locale
        rr( ASSAMESE );                 // locale
        rr( AYMARA );                   // locale
        rr( AZERI );                    // locale
        rr( AZERI_CYRILLIC );           // locale
        rr( AZERI_LATIN );              // locale
        rr( BASHKIR );                  // locale
        rr( BASQUE );                   // locale
        rr( BELARUSIAN );               // locale
        rr( BENGALI );                  // locale
        rr( BHUTANI );                  // locale
        rr( BIHARI );                   // locale
        rr( BISLAMA );                  // locale
        rr( BRETON );                   // locale
        rr( BULGARIAN );                // locale
        rr( BURMESE );                  // locale
        rr( CAMBODIAN );                // locale
        rr( CATALAN );                  // locale
        rr( CHINESE );                  // locale
        rr( CHINESE_SIMPLIFIED );       // locale
        rr( CHINESE_TRADITIONAL );      // locale
        rr( CHINESE_HONGKONG );         // locale
        rr( CHINESE_MACAU );            // locale
        rr( CHINESE_SINGAPORE );        // locale
        rr( CHINESE_TAIWAN );           // locale
        rr( CORSICAN );                 // locale
        rr( CROATIAN );                 // locale
        rr( CZECH );                    // locale
        rr( DANISH );                   // locale
        rr( DUTCH );                    // locale
        rr( DUTCH_BELGIAN );            // locale
        rr( ENGLISH );                  // locale
        rr( ENGLISH_UK );               // locale
        rr( ENGLISH_US );               // locale
        rr( ENGLISH_AUSTRALIA );        // locale
        rr( ENGLISH_BELIZE );           // locale
        rr( ENGLISH_BOTSWANA );         // locale
        rr( ENGLISH_CANADA );           // locale
        rr( ENGLISH_CARIBBEAN );        // locale
        rr( ENGLISH_DENMARK );          // locale
        rr( ENGLISH_EIRE );             // locale
        rr( ENGLISH_JAMAICA );          // locale
        rr( ENGLISH_NEW_ZEALAND );      // locale
        rr( ENGLISH_PHILIPPINES );      // locale
        rr( ENGLISH_SOUTH_AFRICA );     // locale
        rr( ENGLISH_TRINIDAD );         // locale
        rr( ENGLISH_ZIMBABWE );         // locale
        rr( ESPERANTO );                // locale
        rr( ESTONIAN );                 // locale
        rr( FAEROESE );                 // locale
        rr( FARSI );                    // locale
        rr( FIJI );                     // locale
        rr( FINNISH );                  // locale
        rr( FRENCH );                   // locale
        rr( FRENCH_BELGIAN );           // locale
        rr( FRENCH_CANADIAN );          // locale
        rr( FRENCH_LUXEMBOURG );        // locale
        rr( FRENCH_MONACO );            // locale
        rr( FRENCH_SWISS );             // locale
        rr( FRISIAN );                  // locale
        rr( GALICIAN );                 // locale
        rr( GEORGIAN );                 // locale
        rr( GERMAN );                   // locale
        rr( GERMAN_AUSTRIAN );          // locale
        rr( GERMAN_BELGIUM );           // locale
        rr( GERMAN_LIECHTENSTEIN );     // locale
        rr( GERMAN_LUXEMBOURG );        // locale
        rr( GERMAN_SWISS );             // locale
        rr( GREEK );                    // locale
        rr( GREENLANDIC );              // locale
        rr( GUARANI );                  // locale
        rr( GUJARATI );                 // locale
        rr( HAUSA );                    // locale
        rr( HEBREW );                   // locale
        rr( HINDI );                    // locale
        rr( HUNGARIAN );                // locale
        rr( ICELANDIC );                // locale
        rr( INDONESIAN );               // locale
        rr( INTERLINGUA );              // locale
        rr( INTERLINGUE );              // locale
        rr( INUKTITUT );                // locale
        rr( INUPIAK );                  // locale
        rr( IRISH );                    // locale
        rr( ITALIAN );                  // locale
        rr( ITALIAN_SWISS );            // locale
        rr( JAPANESE );                 // locale
        rr( JAVANESE );                 // locale
        rr( KANNADA );                  // locale
        rr( KASHMIRI );                 // locale
        rr( KASHMIRI_INDIA );           // locale
        rr( KAZAKH );                   // locale
        rr( KERNEWEK );                 // locale
        rr( KINYARWANDA );              // locale
        rr( KIRGHIZ );                  // locale
        rr( KIRUNDI );                  // locale
        rr( KONKANI );                  // locale
        rr( KOREAN );                   // locale
        rr( KURDISH );                  // locale
        rr( LAOTHIAN );                 // locale
        rr( LATIN );                    // locale
        rr( LATVIAN );                  // locale
        rr( LINGALA );                  // locale
        rr( LITHUANIAN );               // locale
        rr( MACEDONIAN );               // locale
        rr( MALAGASY );                 // locale
        rr( MALAY );                    // locale
        rr( MALAYALAM );                // locale
        rr( MALAY_BRUNEI_DARUSSALAM );  // locale
        rr( MALAY_MALAYSIA );           // locale
        rr( MALTESE );                  // locale
        rr( MANIPURI );                 // locale
        rr( MAORI );                    // locale
        rr( MARATHI );                  // locale
        rr( MOLDAVIAN );                // locale
        rr( MONGOLIAN );                // locale
        rr( NAURU );                    // locale
        rr( NEPALI );                   // locale
        rr( NEPALI_INDIA );             // locale
        rr( NORWEGIAN_BOKMAL );         // locale
        rr( NORWEGIAN_NYNORSK );        // locale
        rr( OCCITAN );                  // locale
        rr( ORIYA );                    // locale
        rr( OROMO );                    // locale
        rr( PASHTO );                   // locale
        rr( POLISH );                   // locale
        rr( PORTUGUESE );               // locale
        rr( PORTUGUESE_BRAZILIAN );     // locale
        rr( PUNJABI );                  // locale
        rr( QUECHUA );                  // locale
        rr( RHAETO_ROMANCE );           // locale
        rr( ROMANIAN );                 // locale
        rr( RUSSIAN );                  // locale
        rr( RUSSIAN_UKRAINE );          // locale
        rr( SAMOAN );                   // locale
        rr( SANGHO );                   // locale
        rr( SANSKRIT );                 // locale
        rr( SCOTS_GAELIC );             // locale
        rr( SERBIAN );                  // locale
        rr( SERBIAN_CYRILLIC );         // locale
        rr( SERBIAN_LATIN );            // locale
        rr( SERBO_CROATIAN );           // locale
        rr( SESOTHO );                  // locale
        rr( SETSWANA );                 // locale
        rr( SHONA );                    // locale
        rr( SINDHI );                   // locale
        rr( SINHALESE );                // locale
        rr( SISWATI );                  // locale
        rr( SLOVAK );                   // locale
        rr( SLOVENIAN );                // locale
        rr( SOMALI );                   // locale
        rr( SPANISH );                  // locale
        rr( SPANISH_ARGENTINA );        // locale
        rr( SPANISH_BOLIVIA );          // locale
        rr( SPANISH_CHILE );            // locale
        rr( SPANISH_COLOMBIA );         // locale
        rr( SPANISH_COSTA_RICA );       // locale
        rr( SPANISH_DOMINICAN_REPUBLIC ); // locale
        rr( SPANISH_ECUADOR );          // locale
        rr( SPANISH_EL_SALVADOR );      // locale
        rr( SPANISH_GUATEMALA );        // locale
        rr( SPANISH_HONDURAS );         // locale
        rr( SPANISH_MEXICAN );          // locale
        rr( SPANISH_MODERN );           // locale
        rr( SPANISH_NICARAGUA );        // locale
        rr( SPANISH_PANAMA );           // locale
        rr( SPANISH_PARAGUAY );         // locale
        rr( SPANISH_PERU );             // locale
        rr( SPANISH_PUERTO_RICO );      // locale
        rr( SPANISH_URUGUAY );          // locale
        rr( SPANISH_US );               // locale
        rr( SPANISH_VENEZUELA );        // locale
        rr( SUNDANESE );                // locale
        rr( SWAHILI );                  // locale
        rr( SWEDISH );                  // locale
        rr( SWEDISH_FINLAND );          // locale
        rr( TAGALOG );                  // locale
        rr( TAJIK );                    // locale
        rr( TAMIL );                    // locale
        rr( TATAR );                    // locale
        rr( TELUGU );                   // locale
        rr( THAI );                     // locale
        rr( TIBETAN );                  // locale
        rr( TIGRINYA );                 // locale
        rr( TONGA );                    // locale
        rr( TSONGA );                   // locale
        rr( TURKISH );                  // locale
        rr( TURKMEN );                  // locale
        rr( TWI );                      // locale
        rr( UIGHUR );                   // locale
        rr( UKRAINIAN );                // locale
        rr( URDU );                     // locale
        rr( URDU_INDIA );               // locale
        rr( URDU_PAKISTAN );            // locale
        rr( UZBEK );                    // locale
        rr( UZBEK_CYRILLIC );           // locale
        rr( UZBEK_LATIN );              // locale
        rr( VIETNAMESE );               // locale
        rr( VOLAPUK );                  // locale
        rr( WELSH );                    // locale
        rr( WOLOF );                    // locale
        rr( XHOSA );                    // locale
        rr( YIDDISH );                  // locale
        rr( YORUBA );                   // locale
        rr( ZHUANG );                   // locale
        rr( ZULU );                     // locale
        rr( USER_DEFINED );             // locale
        //prefix
        // !parser: sub { $_[0] =~ m<^\s*r\w*\(\s*(\w+)\s*\);\s*(?://(.*))?$> }
#undef rr
    }
    break;
  case 'M':
    r( wxMAXIMIZE );                    // frame
    r( wxMAXIMIZE_BOX );                // frame
    r( wxMENU_TEAROFF );                // menu
    r( wxMINIMIZE );                    // frame
    r( wxMINIMIZE_BOX );                // frame
    r( wxMODERN );                      // font
    r( wxMULTIPLE );                    // filedialog
    
    r( wxMAJOR_VERSION );
    r( wxMINOR_VERSION );

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
    r( wxNO );
    r( wxNO_BORDER );                   // frame toolbar
    r( wxNO_3D );                       // dialog window
    r( wxNO_FULL_REPAINT_ON_RESIZE );   // window
    r( wxNORMAL );                      // font
    r( wxNOT_FOUND );             
    r( wxNO_DEFAULT );

    r( wxNAND );                        // dc
    r( wxNOR );                         // dc
    r( wxNO_OP );                       // dc
    break;
  case 'O':
    r( wxOK );
    r( wxOPEN );                        // filedialog
    r( wxOVERWRITE_PROMPT );            // filedialog
    
    r( wxODDEVEN_RULE );                // dc
    r( wxOR );                          // dc
    r( wxOR_INVERT );                   // dc
    r( wxOR_REVERSE );                  // dc

    r( wxOutRegion );                   // region
    break;
  case 'P':
    r( wxPROCESS_ENTER );

    r( wxPD_APP_MODAL );                // progressdialog
    r( wxPD_AUTO_HIDE );                // progressdialog
    r( wxPD_CAN_ABORT );                // progressdialog
    r( wxPD_ELAPSED_TIME );             // progressdialog
    r( wxPD_ESTIMATED_TIME );           // progressdialog
    r( wxPD_REMAINING_TIME );           // progressdialog
    //    r( wxPD_SMOOTH );                   // progressdialog

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

#define wxSPLASH_CENTER_ON_PARENT wxSPLASH_CENTRE_ON_PARENT
#define wxSPLASH_CENTER_ON_SCREEN wxSPLASH_CENTRE_ON_SCREEN
#define wxSPLASH_NO_CENTER wxSPLASH_NO_CENTRE

    r( wxSPLASH_CENTRE_ON_PARENT );     // splashscreen
    r( wxSPLASH_CENTRE_ON_SCREEN );     // splashscreen
    r( wxSPLASH_NO_CENTRE );            // splashscreen
    r( wxSPLASH_CENTER_ON_PARENT );     // splashscreen
    r( wxSPLASH_CENTER_ON_SCREEN );     // splashscreen
    r( wxSPLASH_NO_CENTER );            // splashscreen
    r( wxSPLASH_TIMEOUT );              // splashscreen
    r( wxSPLASH_NO_TIMEOUT );           // splashscreen

    r( wxSAVE );                        // filedialog
    //    r( wxSB_SIZEGRIP );
    r( wxSB_HORIZONTAL );               // scrollbar
    r( wxSB_VERTICAL );                 // scrollbar
    r( wxSCRIPT );                      // font
    r( wxSIMPLE_BORDER );               // window
    r( wxSLANT );                       // font
    r( wxSTATIC_BORDER );               // window
    r( wxSTAY_ON_TOP );                 // frame dialog
    r( wxST_NO_AUTORESIZE );            // statictext
    r( wxST_SIZEGRIP );
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

    r( wxSIZE_AUTO_WIDTH );             // window
    r( wxSIZE_AUTO_HEIGHT );            // window
    r( wxSIZE_AUTO );                   // window
    r( wxSIZE_USE_EXISTING );           // window
    r( wxSIZE_ALLOW_MINUS_ONE );        // window

    r( wxSIGNONE );                     // process
    r( wxSIGHUP );                      // process
    r( wxSIGINT );                      // process
    r( wxSIGQUIT );                     // process
    r( wxSIGILL );                      // process
    r( wxSIGTRAP );                     // process
    r( wxSIGABRT );                     // process
    r( wxSIGEMT );                      // process
    r( wxSIGFPE );                      // process
    r( wxSIGKILL );                     // process
    r( wxSIGBUS );                      // process
    r( wxSIGSEGV );                     // process
    r( wxSIGSYS );                      // process
    r( wxSIGPIPE );                     // process
    r( wxSIGALRM );                     // process
    r( wxSIGTERM );                     // process

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

    r( wxSASH_STATUS_OK );              // sashwindow
    r( wxSASH_STATUS_OUT_OF_RANGE );    // sashwindow
    r( wxSASH_TOP );                    // sashwindow
    r( wxSASH_RIGHT );                  // sashwindow
    r( wxSASH_BOTTOM );                 // sashwindow
    r( wxSASH_LEFT );                   // sashwindow
    r( wxSASH_NONE );                   // sashwindow

    r( wxSW_3D );                       // sashwindow
    r( wxSW_3DSASH );                   // sashwindow
    r( wxSW_3DBORDER );                 // sashwindow
    r( wxSW_BORDER );                   // sashwindow

    r( wxSameAs );                      // layout constraints

    // fonts
    r( wxSYS_OEM_FIXED_FONT );
    r( wxSYS_ANSI_FIXED_FONT );
    r( wxSYS_ANSI_VAR_FONT );
    r( wxSYS_SYSTEM_FONT ); 
    r( wxSYS_DEVICE_DEFAULT_FONT );
    r( wxSYS_DEFAULT_GUI_FONT );

    // colours
    r( wxSYS_COLOUR_SCROLLBAR );
    r( wxSYS_COLOUR_BACKGROUND );
    r( wxSYS_COLOUR_ACTIVECAPTION );
    r( wxSYS_COLOUR_INACTIVECAPTION );
    r( wxSYS_COLOUR_MENU );
    r( wxSYS_COLOUR_WINDOW );
    r( wxSYS_COLOUR_WINDOWFRAME );
    r( wxSYS_COLOUR_MENUTEXT );
    r( wxSYS_COLOUR_WINDOWTEXT );
    r( wxSYS_COLOUR_CAPTIONTEXT );
    r( wxSYS_COLOUR_ACTIVEBORDER );
    r( wxSYS_COLOUR_INACTIVEBORDER );
    r( wxSYS_COLOUR_APPWORKSPACE );
    r( wxSYS_COLOUR_HIGHLIGHT );
    r( wxSYS_COLOUR_HIGHLIGHTTEXT );
    r( wxSYS_COLOUR_BTNFACE );
    r( wxSYS_COLOUR_BTNSHADOW );
    r( wxSYS_COLOUR_GRAYTEXT );
    r( wxSYS_COLOUR_BTNTEXT );
    r( wxSYS_COLOUR_INACTIVECAPTIONTEXT );
    r( wxSYS_COLOUR_BTNHIGHLIGHT );

    r( wxSYS_COLOUR_3DDKSHADOW );
    r( wxSYS_COLOUR_3DLIGHT );
    r( wxSYS_COLOUR_INFOTEXT );
    r( wxSYS_COLOUR_INFOBK );

    r( wxSYS_COLOUR_LISTBOX );

    r( wxSYS_COLOUR_DESKTOP );
    r( wxSYS_COLOUR_3DFACE );
    r( wxSYS_COLOUR_3DSHADOW );
    r( wxSYS_COLOUR_3DHIGHLIGHT );
    r( wxSYS_COLOUR_3DHILIGHT );
    r( wxSYS_COLOUR_BTNHILIGHT );

    // metrics
    r( wxSYS_MOUSE_BUTTONS );
    r( wxSYS_BORDER_X );
    r( wxSYS_BORDER_Y );
    r( wxSYS_CURSOR_X );
    r( wxSYS_CURSOR_Y );
    r( wxSYS_DCLICK_X );
    r( wxSYS_DCLICK_Y );
    r( wxSYS_DRAG_X );
    r( wxSYS_DRAG_Y );
    r( wxSYS_EDGE_X );
    r( wxSYS_EDGE_Y );
    r( wxSYS_HSCROLL_ARROW_X );
    r( wxSYS_HSCROLL_ARROW_Y );
    r( wxSYS_HTHUMB_X );
    r( wxSYS_ICON_X );
    r( wxSYS_ICON_Y );
    r( wxSYS_ICONSPACING_X );
    r( wxSYS_ICONSPACING_Y );
    r( wxSYS_WINDOWMIN_X );
    r( wxSYS_WINDOWMIN_Y );
    r( wxSYS_SCREEN_X );
    r( wxSYS_SCREEN_Y );
    r( wxSYS_FRAMESIZE_X );
    r( wxSYS_FRAMESIZE_Y );
    r( wxSYS_SMALLICON_X );
    r( wxSYS_SMALLICON_Y );
    r( wxSYS_HSCROLL_Y );
    r( wxSYS_VSCROLL_X );
    r( wxSYS_VSCROLL_ARROW_X );
    r( wxSYS_VSCROLL_ARROW_Y );
    r( wxSYS_VTHUMB_Y );
    r( wxSYS_CAPTION_Y );
    r( wxSYS_MENU_Y );
    r( wxSYS_NETWORK_PRESENT );
    r( wxSYS_PENWINDOWS_PRESENT );
    r( wxSYS_SHOW_SOUNDS );
    r( wxSYS_SWAP_BUTTONS );

    // capabilities
    r( wxSYS_CAN_DRAW_FRAME_DECORATIONS );
    r( wxSYS_CAN_ICONIZE_FRAME );
    // !export: Type_String
    if( strEQ( name, "Type_String" ) )
        return wxConfigBase::Type_String;
    break;
  case 'T':
    r( wxTAB_TRAVERSAL );               // panel
    r( wxTB_FLAT );                     // toolbar
    r( wxTB_DOCKABLE );                 // toolbar
    r( wxTB_HORIZONTAL );               // toolbar
    r( wxTB_VERTICAL );                 // toolbar
    r( wxTB_3DBUTTONS );                // toolbar
    r( wxTB_TEXT );                     // toolbar
    r( wxTB_NOICONS );                  // toolbar
    r( wxTE_PROCESS_ENTER );            // textctrl
    r( wxTE_PROCESS_TAB );              // textctrl
    r( wxTE_MULTILINE );                // textctrl
    r( wxTE_NOHIDESEL );                // textctrl
    r( wxTE_PASSWORD );                 // textctrl
    r( wxTE_READONLY );                 // textctrl
    r( wxTE_RICH );                     // textctrl
    r( wxTE_RICH2 );                    // textctrl
    r( wxTE_LEFT );                     // textctrl
    r( wxTE_RIGHT );                    // textctrl
    r( wxTE_CENTRE );                   // textctrl
    r( wxTE_CENTER );                   // textctrl
    r( wxTE_AUTO_URL );                 // textctrl
    r( wxTHICK_FRAME );                 // frame dialog
    r( wxTINY_CAPTION_HORIZ );
    r( wxTINY_CAPTION_VERT );
    r( wxTOP );                         // sizer layout constraints
    r( wxTRANSPARENT_WINDOW );          // window
    r( wxTRANSPARENT );                 // dc brush pen

    r( wxTop );                         // layout constraints
    break;
  case 'U':
    r( wxUnconstrained );               // layout constraints
    // !export: Type_Unknown
    if( strEQ( name, "Type_Unknown" ) )
        return wxConfigBase::Type_Unknown;

    r( wxUSER_DASH );                   // pen
    break;
  case 'V':
    r( wxVERTICAL );                    // window dialog frame sizer
    r( wxVERTICAL_HATCH );              // brush pen
    r( wxVSCROLL );                     // window
    break;
  case 'W':
    r( wxWANTS_CHARS );
    r( wxWINDING_RULE );                // dc
    r( wxWidth );                       // layout constraints
    r( wxWIZARD_EX_HELPBUTTON );

    r( wxWS_EX_VALIDATE_RECURSIVELY );
    r( wxWS_EX_BLOCK_EVENTS );
    r( wxWS_EX_TRANSIENT );
    break;
  case 'X':
    r( wxXOR );                         // dc
    break;
  case 'Y':
    r( wxYES );
    r( wxYES_NO );
    r( wxYES_DEFAULT );
    break;
  default:
    break;
  }

#undef r
  // now search for modules...
  {
    wxPlConstantFunctions::Node* node;
    PL_CONST_FUNC* func;
    double ret;

    for( node = s_functions().GetFirst(); node; node = node->GetNext() )
    {
      func = node->GetData();
      ret = (*func)( name, arg );
      if( !errno )
        return ret;
    }
  }

  WX_PL_CONSTANT_CLEANUP();
/*
 not_there:
  errno = ENOENT;
  return 0;
*/
}

// XXX hacky
static void my_sv_setref_pv( pTHX_ SV* mysv, const char* pack, void* ptr )
{
    if( SvROK( mysv ) )
    {
        HV* stash = gv_stashpv( CHAR_P pack, 1 );
        sv_setiv( SvRV( mysv ), (IV)ptr );
        sv_bless( mysv, stash );
    }
    else
    {
        sv_setref_pv( mysv, CHAR_P pack, ptr );
    }
}

static void wxPli_make_const( const char* name )
{
    dTHX;
    char buffer[256];
    HV* stash = gv_stashpv( CHAR_P "Wx", 1 );

    strcpy( buffer, "Wx::" );
    strcpy( buffer + 4, name );

    SV* sv = get_sv( buffer, 1 );
    newCONSTSUB( stash, (char*)name, sv );
}

static void wxPli_set_const( const char* name, const char* klass, void* ptr )
{
    dTHX;
    char buffer[256];

    strcpy( buffer, "Wx::" );
    strcpy( buffer + 4, name );

    SV* sv = get_sv( buffer, 1 );

    my_sv_setref_pv( aTHX_ sv, klass, ptr );
}

#undef sv_setref_pv
#define sv_setref_pv( s, p, pt ) my_sv_setref_pv( aTHX_ s, p, pt )

// !parser: sub { $_[0] =~ m<^\s*wxPli_\w+\(\s*\"(wx\w+)\"\s*\);\s*(?://(.*))?$> }
// !package: Wx

void SetConstantsOnce()
{
    dTHX;

    wxPli_make_const( "wxVERSION_STRING" );

    wxPli_make_const( "wxRED" );                // color colour
    wxPli_make_const( "wxGREEN" );              // color colour
    wxPli_make_const( "wxBLUE" );               // color colour
    wxPli_make_const( "wxBLACK" );              // color colour
    wxPli_make_const( "wxWHITE" );              // color colour
    wxPli_make_const( "wxCYAN" );               // color colour
    wxPli_make_const( "wxLIGHT_GREY" );         // color colour

    wxPli_make_const( "wxIMAGE_OPTION_BMP_FORMAT" );    // image
    wxPli_make_const( "wxIMAGE_OPTION_CUR_HOTSPOT_X" ); // image
    wxPli_make_const( "wxIMAGE_OPTION_CUR_HOTSPOT_Y" ); // image
    wxPli_make_const( "wxIMAGE_OPTION_FILENAME" );      // image

    // these are correctly cloned
    SV* tmp;
    tmp = get_sv( "Wx::wxVERSION_STRING", 0 );
    wxPli_wxChar_2_sv( aTHX_ wxVERSION_STRING, tmp );

    tmp = get_sv( "Wx::wxIMAGE_OPTION_BMP_FORMAT", 0 );
    wxPli_wxChar_2_sv( aTHX_ wxIMAGE_OPTION_BMP_FORMAT, tmp );

    tmp = get_sv( "Wx::wxIMAGE_OPTION_CUR_HOTSPOT_X", 0 );
    wxPli_wxChar_2_sv( aTHX_ wxIMAGE_OPTION_CUR_HOTSPOT_X, tmp );

    tmp = get_sv( "Wx::wxIMAGE_OPTION_CUR_HOTSPOT_Y", 0 );
    wxPli_wxChar_2_sv( aTHX_ wxIMAGE_OPTION_CUR_HOTSPOT_Y, tmp );

    tmp = get_sv( "Wx::wxIMAGE_OPTION_FILENAME", 0 );
    wxPli_wxChar_2_sv( aTHX_ wxIMAGE_OPTION_FILENAME, tmp );

    int platform;
    int universal;
    int xstatic;
    int unicode;

#if defined(__WXMSW__)
    platform = 1;
#elif defined(__WXGTK__)
    platform = 2;
#elif defined(__WXMOTIF__)
    platform = 3;
#elif defined(__WXMAC__)
    platform = 4;
#elif defined(__WXX11__)
    platform = 5;
#else
    #error must add case
#endif

#if defined(__WXUNIVERSAL__)
    universal = 1;
#else
    universal = 0;
#endif

#if defined(WXPL_STATIC)
    xstatic = 1;
#else
    xstatic = 0;
#endif

#if wxUSE_UNICODE
    unicode = 1;
#else
    unicode = 0;
#endif

    tmp = get_sv( "Wx::_platform", 1 );
    sv_setiv( tmp, platform );

    tmp = get_sv( "Wx::_universal", 1 );
    sv_setiv( tmp, universal );

    tmp = get_sv( "Wx::_static", 1 );
    sv_setiv( tmp, xstatic );

    tmp = get_sv( "Wx::_unicode", 1 );
    sv_setiv( tmp, unicode );
    tmp = get_sv( "Wx::wxUNICODE", 1 );
    sv_setiv( tmp, unicode );

    // constant functions
    wxPli_make_const( "wxUNICODE" /* don't export */ );
    wxPli_make_const( "wxVERSION" /* don't export */ );
}

// !parser:

void SetConstants()
{
    dTHX;
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

    tmp = get_sv( "Wx::_null_palette", 0 );
    sv_setref_pv( tmp, "Wx::Palette", new wxPalette( wxNullPalette ) );

    tmp = get_sv( "Wx::_null_accelerator", 0 );
    sv_setref_pv( tmp, "Wx::AcceleratorTable",
        new wxAcceleratorTable( wxNullAcceleratorTable ) );

    //
    // Predefined colours
    //
    wxPli_set_const( "wxRED", "Wx::Colour", new wxColour( *wxRED ) );
    wxPli_set_const( "wxGREEN", "Wx::Colour", new wxColour( *wxGREEN ) );
    wxPli_set_const( "wxBLUE", "Wx::Colour", new wxColour( *wxBLUE ) );
    wxPli_set_const( "wxBLACK", "Wx::Colour", new wxColour( *wxBLACK ) );
    wxPli_set_const( "wxWHITE", "Wx::Colour", new wxColour( *wxWHITE ) );
    wxPli_set_const( "wxCYAN", "Wx::Colour", new wxColour( *wxCYAN ) );
    wxPli_set_const( "wxLIGHT_GREY", "Wx::Colour",
                     new wxColour( *wxLIGHT_GREY ) );

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
    // Clipboard & Drag'n'Drop
    //
    tmp = get_sv( "Wx::_format_invalid", 0 );
    sv_setref_pv( tmp, "Wx::DataFormat", new wxDataFormat( wxFormatInvalid ) );

    tmp = get_sv( "Wx::_clipboard", 0 );
    sv_setref_pv( tmp, "Wx::Clipboard", wxTheClipboard );
}

WXPLI_BOOT_ONCE(Wx_Const);
#define boot_Wx_Const wxPli_boot_Wx_Const

MODULE=Wx_Const PACKAGE=Wx

double
constant(name,arg)
    const char* name
    int arg

void
SetEvents()

void
SetInheritance()

char*
_get_packages()
  CODE:
    static const char packages[] = ""
#if wxPERL_USE_DND && !defined(__WXMAC__) && !defined(__WXMOTIF__)
    "use Wx::DND;"
#endif
#if wxPERL_USE_DOCVIEW && !defined(__WXMAC__)
    "use Wx::DocView;"
#endif
#if wxPERL_USE_FILESYS
    "use Wx::FS;"
#endif
#if wxPERL_USE_GRID
    "use Wx::Grid;"
#endif
#if wxPERL_USE_HELP
    "use Wx::Help;"
#endif
#if wxPERL_USE_HTML
    "use Wx::Html;"
#endif
#if wxPERL_USE_MDI
    "use Wx::MDI;"
#endif
#if wxPERL_USE_PRINT
    "use Wx::Print;"
#endif
#if wxPERL_USE_SOCKET
    "use Wx::Socket;"
#endif
#if wxPERL_USE_CALENDAR
    "use Wx::Calendar;"
#endif
#if wxPERL_USE_DATETIME
    "use Wx::DateTime;"
#endif
    ;

    RETVAL = (char*)packages;
  OUTPUT:
    RETVAL
