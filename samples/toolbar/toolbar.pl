#!/usr/bin/perl
#############################################################################
## Name:        minimal.pl
## Purpose:     Minimal wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

package MyApp;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::App);

sub OnInit {
  my( $this ) = @_;
  my( $frame ) = MyFrame->new( undef, -1, "Wx::ToolBar sample",
                               [100, 100], [450, 300] );

  $frame->Show( 1 );
  $frame->SetStatusText( 'Hello, wxPerl!' );
  $this->SetTopWindow( $frame );

  return 1;
}

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::Frame);

use Wx qw(wxTE_MULTILINE wxBITMAP_TYPE_ICO);
use Wx qw(:id);
use Wx::Event qw(EVT_SIZE EVT_MENU EVT_COMBOBOX EVT_UPDATE_UI
 EVT_TOOL_ENTER);

my( $ID_TOOLBAR, $ID_COMBO ) = ( 1 .. 100 );
my( $IDM_TOOLBAR_TOGGLE_ANOTHER_TOOLBAR, $IDM_TOOLBAR_TOGGLETOOLBARSIZE,
    $IDM_TOOLBAR_TOGGLETOOLBARORIENT, $IDM_TOOLBAR_TOGGLETOOLBARROWS,
    $IDM_TOOLBAR_ENABLEPRINT, $IDM_TOOLBAR_DELETEPRINT,
    $IDM_TOOLBAR_INSERTPRINT, $IDM_TOOLBAR_TOGGLEHELP,
    $IDM_TOOLBAR_TOGGLEFULLSCREEN ) = ( 10_000 .. 10_100 );

use Wx qw(wxBITMAP_TYPE_BMP wxBITMAP_TYPE_XPM);

sub BITMAP {
  if( $Wx::_platform == $Wx::_msw ) {
    Wx::Bitmap->new( "bitmaps/$_[0].bmp", wxBITMAP_TYPE_BMP );
  } else {
    Wx::Bitmap->new( "bitmaps/$_[0].xpm", wxBITMAP_TYPE_XPM );
  }
}

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_ );

  $this->{TEXTWINDOW} = Wx::TextCtrl->new( $this, -1, '', [0, 0], [-1, -1],
                                           wxTE_MULTILINE );
  $this->{ROWS} = 1;
  $this->{SMALLTOOLBAR} = 1;
  $this->{HORIZONTALTOOLBAR} = 1;

  $this->SetIcon( Wx::Icon->new( '../../wxpl.ico', wxBITMAP_TYPE_ICO ) );
  $this->CreateStatusBar();

  my( $tmenu ) = Wx::Menu->new();
  $tmenu->Append( $IDM_TOOLBAR_TOGGLE_ANOTHER_TOOLBAR,
                  "Toggle &another toolbar\tCtrl-A",
                  "Show/Hide another test toolbar", 1 );
  $tmenu->Append( $IDM_TOOLBAR_TOGGLETOOLBARSIZE,
                  "&Toggle toolbar size\tCtrl-S",
                  "Toggle between big/small tollbar", 1 );
  $tmenu->Append( $IDM_TOOLBAR_TOGGLETOOLBARORIENT,
                  "Toggle toolbar &orientation\tCtrl-O",
                  "Toggle toolbar orientation", 1 );
  $tmenu->Append( $IDM_TOOLBAR_TOGGLETOOLBARROWS,
                  "Toggle number of &rows\tCtrl-R",
                  "Toggle number of toolbar rows between 1 and 2", 1 );
  $tmenu->AppendSeparator();
  $tmenu->Append( $IDM_TOOLBAR_ENABLEPRINT, "&Enable print button\tCtrl-E" );
  $tmenu->Append( $IDM_TOOLBAR_DELETEPRINT, "&Delete print button\tCtrl-D" );
  $tmenu->Append( $IDM_TOOLBAR_INSERTPRINT, "&Insert print button\tCtrl-I" );
  $tmenu->Append( $IDM_TOOLBAR_TOGGLEHELP,  "Toggle &help button\tCtrl-T" );
  $tmenu->AppendSeparator();
  $tmenu->Append( $IDM_TOOLBAR_TOGGLEFULLSCREEN, "Toggle &Fullsecreen mode\tCtrl-F" );

  my( $fmenu ) = Wx::Menu->new();
  $fmenu->Append( wxID_EXIT, "E&xit", "Quit toolbar sample" );

  my( $hmenu ) = Wx::Menu->new();
  $hmenu->Append( wxID_HELP, "&About", "About toolbar sample" );

  my( $menu ) = Wx::MenuBar->new();
  $menu->Append( $fmenu, '&File' );
  $menu->Append( $tmenu, '&Toolbar' );
  $menu->Append( $hmenu, '&Help' );

  $this->SetMenuBar( $menu );

  $this->RecreateToolbar();

  EVT_SIZE( $this, \&OnSize );
  EVT_MENU( $this, wxID_EXIT, \&OnQuit );
  EVT_MENU( $this, wxID_HELP, \&OnAbout );
  EVT_MENU( $this, $IDM_TOOLBAR_TOGGLE_ANOTHER_TOOLBAR, \&OnToggleAnotherToolbar );
  EVT_MENU( $this, $IDM_TOOLBAR_TOGGLETOOLBARSIZE, \&OnToggleToolbarSize );
  EVT_MENU( $this, $IDM_TOOLBAR_TOGGLETOOLBARORIENT, \&OnToggleToolbarOrient );
  EVT_MENU( $this, $IDM_TOOLBAR_TOGGLETOOLBARROWS, \&OnToggleToolbarRows );

  EVT_MENU( $this, $IDM_TOOLBAR_ENABLEPRINT, \&OnEnablePrint );
  EVT_MENU( $this, $IDM_TOOLBAR_DELETEPRINT, \&OnDeletePrint );
  EVT_MENU( $this, $IDM_TOOLBAR_INSERTPRINT, \&OnInsertPrint );
  EVT_MENU( $this, $IDM_TOOLBAR_TOGGLEHELP, \&OnToggleHelp );
  EVT_MENU( $this, $IDM_TOOLBAR_TOGGLEFULLSCREEN, \&OnToggleFullScreen );

  EVT_MENU( $this, -1, \&OnToolLeftClick );
  EVT_COMBOBOX( $this, $ID_COMBO, \&OnCombo );
  EVT_TOOL_ENTER( $this, $ID_TOOLBAR, \&OnToolEnter );

  EVT_UPDATE_UI( $this, wxID_COPY, \&OnUpdateCopyAndCut );
  EVT_UPDATE_UI( $this, wxID_CUT, \&OnUpdateCopyAndCut );

  return $this;
}

sub OnSize {
  my( $this, $event ) = @_;

  if( $this->{TBAR} ) { $this->LayoutChildren() }
  else { $event->Skip() }
}

sub OnUpdateCopyAndCut {
  my( $this, $event ) = @_;

  $event->Enable( $this->{TEXTWINDOW}->CanCopy() );
}

use Wx qw(wxDefaultPosition wxDefaultSize wxNullBitmap wxTB_VERTICAL);

sub OnToggleAnotherToolbar {
  my( $this, $event ) = @_;

  if( $this->{TBAR} ) {
    $this->{TBAR}->Destroy();
    $this->{TBAR} = undef;
  } else {
    my( $t ) = $this->{TBAR} = Wx::ToolBar->new( $this, -1,
                                                 wxDefaultPosition,
                                                 wxDefaultSize,
                                                 wxTB_VERTICAL );

    $t->AddTool( wxID_HELP,
                 BITMAP( 'help' ),
                 wxNullBitmap, 0, undef, 'This is the help button',
                 'This is the long help for the help button' );
    $t->Realize();
  }

  $this->LayoutChildren();
}

sub LayoutChildren {
  my( $this ) = shift;
  my( $size ) = $this->GetClientSize();
  my( $t, $offset );

  if( $t = $this->{TBAR} ) {
    $t->SetSize( -1, $size->y );
    $t->Move( 0, 0 );

    $offset = $t->GetSize()->x;
  } else {
    $offset = 0;
  }

  $this->{TEXTWINDOW}->SetSize( $offset, 0, $size->x - $offset, $size->y );
}

sub OnToggleToolbarSize {
  my( $this, $event ) = @_;

  $this->{SMALLTOOLBAR} = !$this->{SMALLTOOLBAR};

  $this->RecreateToolbar();
}

sub OnToggleToolbarRows {
  my( $this, $event ) = @_;

  $this->{ROWS} = 3 - $this->{ROWS};
  $this->GetToolBar()->SetRows( $this->{HORIZONTALTOOLBAR} ?
                                $this->{ROWS} : 10 / $this->{ROWS} );
}

sub OnToggleToolbarOrient {
  my( $this, $event ) = @_;

  $this->{HORIZONTALTOOLBAR} = !$this->{HORIZONTALTOOLBAR};
  $this->RecreateToolbar();
}

sub OnToolLeftClick {
  my( $this, $event ) = @_;

  $this->{TEXTWINDOW}->WriteText( sprintf "Clicked on tool %d\n",
                                  $event->GetId() );
  if( $event->GetId() == wxID_HELP ) {
    if( $event->GetExtraLong() != 0 ) {
      $this->{TEXTWINDOW}->WriteText( "Help button down now\n" );
    } else {
      $this->{TEXTWINDOW}->WriteText( "Help button up now\n" );
    }
  }

  if( $event->GetId() == wxID_COPY ) {
    $this->DoEnablePrint();
  }

  if( $event->GetId() == wxID_CUT ) {
    $this->DoToggleHelp();
  }

  if( $event->GetId() == wxID_PRINT ) {
    $this->DoDeletePrint();
  }
}

sub OnEnablePrint { $_[0]->DoEnablePrint }
sub OnDeletePrint { $_[0]->DoDeletePrint }
sub OnToggleHelp { $_[0]->DoToggleHelp }

sub DoEnablePrint {
  my( $this ) = shift;

  my( $t ) = $this->GetToolBar();
  $t->EnableTool( wxID_PRINT, !$t->GetToolEnabled( wxID_PRINT ) );
}

sub DoDeletePrint {
  my( $this ) = shift;

  $this->GetToolBar()->DeleteTool( wxID_PRINT );
}

sub DoToggleHelp {
  my( $this ) = shift;
  my( $t ) = $this->GetToolBar();

  $t->ToggleTool( wxID_HELP, !$t->GetToolState( wxID_HELP ) );
}

sub OnInsertPrint {
  my( $this, $event ) = @_;

  my( $bmp ) = BITMAP( 'print' );
  $this->GetToolBar()->InsertTool( 0, wxID_PRINT, $bmp, wxNullBitmap,
                                   0, undef, 'Delete this tool',
                                   'This button was inserted into the toolbar'
                                 );
  $this->GetToolBar->Realize;
}

use Wx qw(:toolbar :id wxBITMAP_TYPE_BMP wxNullBitmap wxDefaultPosition
          wxDefaultSize wxSIZE);

sub RecreateToolbar {
  my( $this ) = shift;
  my( $toolbar ) = $this->GetToolBar();
  $toolbar && $toolbar->Destroy();
  $this->SetToolBar( undef );

  my( $style ) = ( $this->{HORIZONTALTOOLBAR} ? wxTB_HORIZONTAL : wxTB_VERTICAL ) |
    wxNO_BORDER | wxTB_FLAT | wxTB_DOCKABLE;
  $toolbar = $this->CreateToolBar( $style, $ID_TOOLBAR );
  $toolbar->SetMargins( 4, 4 );

  my( @bitmaps );
  foreach ( qw(new open save copy cut paste print help) ) {
    push @bitmaps, BITMAP( $_ );
  }

  if( !$this->{SMALLTOOLBAR} ) {
    my( $w, $h ) = ( $bitmaps[0]->GetWidth() * 2,
                     $bitmaps[0]->GetHeight() * 2 );

    @bitmaps = map {
      Wx::Image->new( $_ )->Scale( $w, $h )->ConvertToBitmap();
    } @bitmaps;

    $toolbar->SetToolBitmapSize( wxSIZE( $w, $h ) );
  }

  my( $width ) = ( $Wx::_platform = $Wx::_msw ) ? 24 : 16;
#  my( $curX ) = 5;

  $toolbar->AddTool( wxID_NEW, $bitmaps[0], wxNullBitmap, 0, undef, 'New File' );
  $toolbar->AddTool( wxID_OPEN, $bitmaps[1], wxNullBitmap, 0, undef, 'Open File' );
  if( $this->{HORIZONTALTOOLBAR} ) {
    my( $c ) = Wx::ComboBox->new( $toolbar, $ID_COMBO, '', wxDefaultPosition,
                                  wxDefaultSize,
                                  [ 'This', 'is a', 'combobox', 'in a', 'toolbar' ] );
    $toolbar->AddControl( $c );
  }
  $toolbar->AddTool( wxID_SAVE, $bitmaps[2], wxNullBitmap, 1, undef,
                     'Toggle button 1' );
  $toolbar->AddTool( wxID_COPY, $bitmaps[3], wxNullBitmap, 1, undef,
                     'Toggle button 1' );
  $toolbar->AddTool( wxID_CUT, $bitmaps[4], wxNullBitmap, 0, undef,
                     'Toggle button 1' );
  $toolbar->AddTool( wxID_PASTE, $bitmaps[5], wxNullBitmap, 0, undef,
                     'Toggle button 1' );
  $toolbar->AddTool( wxID_PRINT, $bitmaps[6], wxNullBitmap, 0, undef,
                     'Toggle button 1' );
  $toolbar->AddSeparator();
  $toolbar->AddTool( wxID_HELP, $bitmaps[7], wxNullBitmap, 1, undef,
                     'Toggle button 1' );

  $toolbar->Realize();
  $toolbar->SetRows( $this->{HORIZONTALTOOLBAR} ? $this->{ROWS} :
                     10 / $this->{ROWS} );
}

# sub OnCreateToolBar {
#   my( $this, $style, $id, $name ) = @_;

#   return Wx::ToolBarSimple->new( $this, $id, wxDefaultPosition, wxDefaultSize,
#                                  $style, $name );
# }

sub OnCombo {
  my( $this, $event ) = @_;

  Wx::LogStatus( "ComboBox string '%s' selected", $event->GetString() );
}

sub OnQuit {
  $_[0]->Close( 1 );
}

sub OnAbout {
  Wx::MessageBox( 'wxPerl Toolbar sample', 'About Wx::ToolBar' );
}

sub OnToolEnter {
  my( $this, $event ) = @_;

  if( $event->GetSelection() > -1 ) {
    $this->SetStatusText( sprintf 'This is tool number %d',
                          $event->GetSelection() );
  } else {
    $this->SetStatusText( '' );
  }
}

sub OnToggleFullScreen {
  my( $this ) = shift;

  $this->ShowFullScreen( !$this->IsFullScreen() );
}

package main;

my( $app ) = MyApp->new();

$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
