/////////////////////////////////////////////////////////////////////////////
// Name:        typedef.h
// Purpose:     forward declare and typdef wxClass to Wx_Class
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_TYPEDEF_H
#define _WXPERL_TYPEDEF_H

// forward declares and typedefs a class wxClass to Wx_Class
// and declares the string holding the class name
#if _WXP_DEFINE_CLASSNAME

#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[] = "Wx::" #name; 

#else
  
#define FD_TD( name ) \
  class wx##name; \
  typedef wx##name Wx_##name; \
  extern "C" const char wxPl##name##Name[];

#endif

// event classes
FD_TD( Event );
FD_TD( ActivateEvent );
FD_TD( CloseEvent );
FD_TD( CommandEvent );
FD_TD( DropFilesEvent );
FD_TD( EraseEvent );
FD_TD( FocusEvent );
#if WXPERL_W_VERSION_GE( 2, 3 )
FD_TD( HelpEvent );
#endif
FD_TD( IdleEvent );
FD_TD( InitDialogEvent );
FD_TD( JoystickEvent );
FD_TD( KeyEvent );
FD_TD( ListEvent );
FD_TD( MenuEvent );
FD_TD( MouseEvent );
FD_TD( MoveEvent );
FD_TD( NotebookEvent );
FD_TD( NotifyEvent );
FD_TD( PaintEvent );
FD_TD( SashEvent );
FD_TD( ScrollWinEvent );
FD_TD( SizeEvent );
FD_TD( SpinEvent );
FD_TD( SplitterEvent );
FD_TD( SysColourChangedEvent );
FD_TD( TreeEvent );
FD_TD( UpdateUIEvent );

// other classes

class _wxPlValidator; typedef _wxPlValidator Wx_PlValidator;
class _wxPlSizer;     typedef _wxPlSizer     Wx_PlSizer;

FD_TD( App );
FD_TD( Bitmap );
FD_TD( BitmapButton );
FD_TD( BitmapHandler );
FD_TD( BoxSizer );
FD_TD( Brush );
FD_TD( BusyCursor );
FD_TD( BusyInfo );
FD_TD( Button );
FD_TD( Caret );
#if WXPERL_W_VERSION_GE( 2, 3 )
FD_TD( CaretSuspend );
#endif
FD_TD( CheckBox );
FD_TD( CheckListBox );
FD_TD( Choice );
FD_TD( ClassInfo );
FD_TD( ClientDC );
FD_TD( Colour );
FD_TD( ColourData );
FD_TD( ColourDialog );
FD_TD( ComboBox );
FD_TD( Control );
FD_TD( ControlWithItems );
FD_TD( Cursor );
FD_TD( DC );
FD_TD( Dialog );
FD_TD( DirDialog );
#if WXPERL_W_VERSION_GE( 2, 3 )
FD_TD( DrawObject );
#endif
FD_TD( DropTarget );
FD_TD( EvtHandler );
FD_TD( FileDialog );
FD_TD( FlexGridSizer );
FD_TD( Font );
FD_TD( FontDialog );
FD_TD( Frame );
FD_TD( Gauge );
FD_TD( GridSizer );
FD_TD( Icon );
FD_TD( Image );
FD_TD( ImageHandler );
FD_TD( ImageList );
FD_TD( IndividualLayoutConstraint );
FD_TD( LayoutConstraints );
FD_TD( ListBox );
FD_TD( ListCtrl );
FD_TD( ListItem );
FD_TD( Locale );
FD_TD( Log );
FD_TD( LogTextCtrl );
FD_TD( Mask );
FD_TD( MemoryDC );
FD_TD( Menu );
FD_TD( MenuBar );
FD_TD( MenuItem );
FD_TD( MessageDialog );
FD_TD( MiniFrame );
FD_TD( MultiChoiceDialog );
FD_TD( Notebook );
FD_TD( NotebookSizer );
FD_TD( PageSetupDialog );
FD_TD( PaintDC );
FD_TD( Palette );
FD_TD( Panel );
FD_TD( Pen );
FD_TD( Point );
FD_TD( PrintDialog );
FD_TD( ProgressDialog );
FD_TD( RadioBox );
FD_TD( RadioButton );
FD_TD( Rect );
FD_TD( Region );
FD_TD( SashWindow );
FD_TD( ScreenDC );
FD_TD( ScrollBar );
FD_TD( ScrolledWindow );
FD_TD( SingleChoiceDialog );
FD_TD( Size );
FD_TD( Sizer );
FD_TD( SizerItem );
FD_TD( Slider );
FD_TD( SpinButton );
FD_TD( SpinCtrl );
FD_TD( SplitterWindow );
FD_TD( StaticBitmap );
FD_TD( StaticBox );
FD_TD( StaticBoxSizer );
FD_TD( StaticCtrl );
FD_TD( StaticLine );
FD_TD( StaticText );
FD_TD( StatusBar );
FD_TD( StopWatch );
FD_TD( TextCtrl );
FD_TD( TextEntryDialog );
FD_TD( ToolBar );
FD_TD( ToolBarBase );
FD_TD( ToolBarToolBase );
FD_TD( ToolTip );
FD_TD( TreeCtrl );
FD_TD( TreeItemData );
FD_TD( TreeItemId );
FD_TD( Validator );
FD_TD( Window );
FD_TD( WindowDC );
FD_TD( WindowDisabler );

FD_TD( BMPHandler );
FD_TD( PNGHandler );
FD_TD( PCXHandler );
FD_TD( PNMHandler );
FD_TD( GIFHandler );
FD_TD( JPEGHandler );
FD_TD( TIFFHandler );

//typedef wxQueryLayoutInfoEvent Wx_QueryLayoutInfoEvent;

#undef FD_TD

#endif // _WXPERL_TYPEDEF_H
