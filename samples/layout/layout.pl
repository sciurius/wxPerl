#!/usr/bin/perl
#############################################################################
## Name:        layout.pl
## Purpose:     Layout wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:      1/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx;

use vars qw($frame $menu_bar $layout_load_file $layout_test_sizer 
 $layout_test_nb $layout_quit $layout_about);

( $layout_load_file, $layout_test_sizer, $layout_test_nb, $layout_quit,
  $layout_about ) = ( 1 .. 10 );

package MyApp;

use vars qw(@ISA);

@ISA = qw(Wx::App);

sub OnInit {
  my( $this ) = @_;

  my( $frame ) = $main::frame =
    MyFrame->new( undef, 'wxPerl layout demo', 0, 0, 550, 500 );

  $frame->SetAutoLayout( 1 );
  $frame->CreateStatusBar( 2 );

  my( $file_menu ) = Wx::Menu->new();

  $file_menu->Append( $main::layout_load_file, '&Load file', 'Load a text file' );
  $file_menu->Append( $main::layout_test_sizer, '&Test sizers', 'Test sizer' );
  $file_menu->Append( $main::layout_test_nb, '&Test notebook sizers',
                      'Test notebook sizers' );
  $file_menu->AppendSeparator();
  $file_menu->Append( $main::layout_quit, 'E&xit', 'Quit program' );

  my( $help_menu ) = Wx::Menu->new();

  $help_menu->Append( $main::layout_about, '&About', 'About layout demo' );

  my( $menu_bar ) = $main::menu_bar = Wx::MenuBar->new();

  $menu_bar->Append( $file_menu, '&File' );
  $menu_bar->Append( $help_menu, '&Help' );

  $frame->SetMenuBar( $menu_bar );

  use Wx qw(wxTAB_TRAVERSAL);

  $frame->{PANEL} = Wx::Panel->new( $frame, 0, [0, 0], [1000, 500], 
                                    wxTAB_TRAVERSAL );

  my( $btn1 ) = Wx::Button->new( $frame->panel, -1, 'A button (1)' );
  my( $b1 ) = Wx::LayoutConstraints->new();

  use Wx qw(:everything);

  $b1->centreX->SameAs( $frame->panel, wxCentreX );
  $b1->top->SameAs( $frame->panel, wxTop, 5 );
  $b1->width->PercentOf( $frame->panel, wxWidth, 80 );
  $b1->height->PercentOf( $frame->panel, wxHeight, 10 );
  $btn1->SetConstraints( $b1 );

  my( $list ) = Wx::ListBox->new( $frame->panel, -1, [-1, -1], [200, 100] );

  $list->Append( 'Apple' );
  $list->Append( 'Pear' );
  $list->Append( 'Orange' );
  $list->Append( 'Banana' );
  $list->Append( 'Fruit' );

  my( $b2 ) = Wx::LayoutConstraints->new();
  $b2->top->Below( $btn1, 5 );
  $b2->left->SameAs( $frame->panel, wxLeft, 5 );
  $b2->width->PercentOf( $frame->panel, wxWidth, 40 );
  $b2->bottom->SameAs( $frame->panel, wxBottom, 5 );
  $list->SetConstraints( $b2 );

  my( $mtext ) = Wx::TextCtrl->new( $frame->panel, -1, 'Some text',
                                    [-1, -1], [150, 100] );

  my( $b3 ) = Wx::LayoutConstraints->new();
  $b3->top->Below( $btn1, 5 );
  $b3->left->RightOf( $list, 5 );
  $b3->right->SameAs( $frame->panel, wxRight, 5 );
  $b3->bottom->SameAs( $frame->panel, wxBottom, 5 );
  $mtext->SetConstraints( $b3 );

  use Wx qw(wxRETAINED);

  $frame->{CANVAS} = MyWindow->new( $frame, 0, 0, 400, 400, wxRETAINED );
  $frame->{TEXT_WINDOW} = MyTextWindow->new( $frame, 0, 250, 400, 250 );

  my( $c1 ) = Wx::LayoutConstraints->new();
  $c1->left->SameAs( $frame, wxLeft );
  $c1->top->SameAs( $frame, wxTop );
  $c1->right->PercentOf( $frame, wxWidth, 50 );
  $c1->height->PercentOf( $frame, wxHeight, 50 );
  $frame->panel->SetConstraints( $c1 );

  my( $c2 ) = Wx::LayoutConstraints->new();
  $c2->left->SameAs( $frame->panel, wxRight );
  $c2->top->SameAs( $frame, wxTop );
  $c2->right->SameAs( $frame, wxRight );
  $c2->height->PercentOf( $frame, wxHeight, 50 );
  $frame->canvas->SetConstraints( $c2 );

  my( $c3 ) = Wx::LayoutConstraints->new();
  $c3->left->SameAs( $frame, wxLeft );
  $c3->top->Below( $frame->panel );
  $c3->right->SameAs( $frame, wxRight );
  $c3->bottom->SameAs( $frame, wxBottom );
  $frame->text_window->SetConstraints( $c3 );

  $frame->Show( 1 );
  $frame->SetStatusText( 'wxPerl layout demo' );

  $this->SetTopWindow( $frame );

  1;
}

package MyFrame;

use vars qw(@ISA);

@ISA = qw(Wx::Frame);

use Wx::Event qw(EVT_MENU);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( $_[0], -1, $_[1], [ @_[2, 3] ],
                                    [ @_[4, 5] ] );

  EVT_MENU( $this, $main::layout_load_file, \&LoadFile );
  EVT_MENU( $this, $main::layout_quit, \&Quit );
  EVT_MENU( $this, $main::layout_test_sizer, \&TestSizers );
  EVT_MENU( $this, $main::layout_test_nb, \&TestNotebookSizers );
  EVT_MENU( $this, $main::layout_about, \&About );

  return $this;
}

sub LoadFile {
  my( $str ) = Wx::FileSelector( 'Load text file', undef, undef, undef, '*.txt' );

  $main::frame->text_window->LoadFile( $str ) if( length $str );
}

sub Quit {
  $_[0]->Close( 1 );
}

use Wx qw(wxOK wxCENTRE);

sub About {
  Wx::MessageBox( 'wxPerl layout demo', 'wxPerl Layout demo', wxOK|wxCENTRE );
}

sub TestSizers {
  my( $frame ) = MySizerFrame->new( undef, 'Sizer test frame', 50, 50 );
  $frame->Show( 1 );
}

use Wx qw(wxID_OK wxDefaultPosition wxDefaultSize wxTE_MULTILINE);
use Wx qw(:sizer);

sub TestNotebookSizers {
  my( $this, $event ) = @_;
  my( $dialog ) = Wx::Dialog->new( $this, -1, 'Notebook sizer test dialog' );
  my( $topsizer ) = Wx::BoxSizer->new( wxVERTICAL );
  my( $notebook ) = Wx::Notebook->new( $dialog, -1 );
  my( $nbs ) = Wx::NotebookSizer->new( $notebook );

  $topsizer->Add( $nbs, wxGROW );
  my( $button ) = Wx::Button->new( $dialog, wxID_OK, 'OK' );
  $topsizer->Add( $button, 0, wxALIGN_RIGHT|wxALL, 10 );
  my( $multi ) = Wx::TextCtrl->new( $notebook, -1, 'TextCtrl', wxDefaultPosition,
                                    wxDefaultSize, wxTE_MULTILINE );
  $notebook->AddPage( $multi, 'Page One' );

  my( $panel ) = Wx::Panel->new( $notebook, -1 );
  $notebook->AddPage( $panel, 'Page Two' );
  my( $panelsizer ) = Wx::BoxSizer->new( wxVERTICAL );
  my( $text ) = Wx::TextCtrl->new( $panel, -1, 'Textline 1', wxDefaultPosition,
                                   [250, -1] );
  $panelsizer->Add( $text, 0, wxGROW|wxALL, 30 );
  $text = Wx::TextCtrl->new( $panel, -1, 'Textline 2', wxDefaultPosition,
                             [250, -1] );
  $panelsizer->Add( $text, 0, wxGROW|wxALL, 30 );
  my( $button2 ) = Wx::Button->new( $panel, -1, 'Hello' );
  $panelsizer->Add( $button2, 0, wxALIGN_RIGHT|wxLEFT|wxRIGHT|wxBOTTOM, 30 );

  $panel->SetAutoLayout( 1 );
  $panel->SetSizer( $panelsizer );

  $dialog->SetAutoLayout( 1 );
  $dialog->SetSizer( $topsizer );
  $topsizer->Fit( $dialog );
  $topsizer->SetSizeHints( $dialog );

  $dialog->ShowModal();
  $dialog->Destroy();
}

use Wx qw(wxGREEN_PEN wxCYAN_BRUSH wxRED_PEN wxBLACK_PEN);
use Wx qw(wxPOINT);
sub Draw {
  my( $this, $dc ) = @_;

  $dc->SetPen( wxGREEN_PEN );
  $dc->DrawLine( 0, 0, 200, 200 );
  $dc->DrawLine( 200, 0, 0, 200 );

  $dc->SetBrush( wxCYAN_BRUSH );
  $dc->SetPen( wxRED_PEN );

  $dc->DrawRectangle( 100, 100, 100, 50 );
  $dc->DrawRoundedRectangle( 150, 150, 100, 50, 20 );

  $dc->DrawEllipse( 250, 250, 100, 50 );
  $dc->DrawSpline( [ wxPOINT(50, 200 ), [ 50, 100 ],
                   wxPOINT( 200, 10 ) ] );

  $dc->DrawLine( 50, 230, 200, 230 );
  $dc->SetPen( wxBLACK_PEN );
  $dc->DrawArc( 50, 300, 100, 250, 100, 300 );
}

sub panel {
  $_[0]->{PANEL};
}

sub canvas {
  $_[0]->{CANVAS};
}

sub text_window {
  $_[0]->{TEXT_WINDOW};
}

package MyWindow;

use vars qw(@ISA);

@ISA = qw(Wx::Window);

use Wx::Event qw(EVT_PAINT);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( $_[0], -1, [ @_[1, 2] ],
                                    [ @_[3, 4] ], $_[5] );

  EVT_PAINT( $this, \&OnPaint );

  return $this;
}

sub OnPaint {
  my( $this, $event ) = @_;
  my( $dc ) = Wx::PaintDC->new( $this );

  $main::frame->Draw( $dc, 1 );
}

package MyTextWindow;

use vars qw(@ISA);

@ISA = qw(Wx::TextCtrl);

use Wx qw(wxTE_MULTILINE);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( $_[0], -1, '', [ @_[1, 2] ],
                                    [ @_[3, 4] ], $_[5]|wxTE_MULTILINE );
  return $this;
}

package MySizerFrame;

use vars qw(@ISA);

@ISA = qw(Wx::Frame);

use Wx qw(:sizer wxTE_MULTILINE wxDefaultPosition);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( $_[0], -1, $_[1], [ @_[2, 3] ] );

  my( $topsizer ) = Wx::BoxSizer->new( wxVERTICAL );

  $topsizer->Add( Wx::StaticText->new( $this, -1, 'An explanation (wxALIGN_RIGHT)' ),
                  0, wxALIGN_RIGHT|wxTOP|wxLEFT|wxRIGHT, 5 );
  $topsizer->Add( Wx::TextCtrl->new( $this, -1, 'My text (wxEXPAND)', wxDefaultPosition,
                                [ 100, 60 ], wxTE_MULTILINE ),
                  1, wxEXPAND|wxALL, 5 );

  my( $statsizer ) = Wx::StaticBoxSizer->new( Wx::StaticBox->new( $this, -1,
                                                                  'A wxStaticBoxSizer' ),
                                              wxVERTICAL );
  $statsizer->Add( Wx::StaticText->new( $this, -1, 'And some TEXT inside it' ),
                   0, wxCENTER|wxALL, 30 );
  $topsizer->Add( $statsizer, 1, wxEXPAND|wxALL, 10 );

  use Wx qw(wxGROW wxALIGN_CENTER_VERTICAL);

  my( $gridsizer ) = Wx::GridSizer->new( 0, 2, 5, 5 );
  $gridsizer->Add( Wx::StaticText->new( $this, -1, 'Label' ), 0,
                   wxALIGN_RIGHT|wxALIGN_CENTER_VERTICAL );
  $gridsizer->Add( Wx::TextCtrl->new( $this, -1, 'Grid sizer demo' ), 1,
                   wxGROW|wxALIGN_CENTER_VERTICAL );
  $gridsizer->Add( Wx::StaticText->new( $this, -1, 'Another label' ), 0,
                   wxALIGN_RIGHT|wxALIGN_CENTER_VERTICAL );
  $gridsizer->Add( Wx::TextCtrl->new( $this, -1, 'More text' ), 0,
                   wxGROW|wxALIGN_CENTER_VERTICAL );
  $gridsizer->Add( Wx::StaticText->new( $this, -1, 'Final label' ), 0,
                   wxALIGN_RIGHT|wxALIGN_CENTER_VERTICAL );
  $gridsizer->Add( Wx::TextCtrl->new( $this, -1, 'And yet more text' ), 0,
                   wxGROW|wxALIGN_CENTER_VERTICAL );
  $topsizer->Add( $gridsizer, 1, wxGROW|wxALL, 10 );

  use Wx qw(wxHORIZONTAL);

  $topsizer->Add( Wx::StaticLine->new( $this, -1, wxDefaultPosition, [ 3, 3 ],
                                       wxHORIZONTAL ),
                  0, wxEXPAND|wxALL, 5 );

  my( $button_box ) = Wx::BoxSizer->new( wxHORIZONTAL );
  $button_box->Add( Wx::Button->new( $this, -1, 'Two buttons in a box' ),
                    0, wxALL, 7 );
  $button_box->Add( Wx::Button->new( $this, -1, '(wxCENTER)' ),
                    0, wxALL, 7 );
  $topsizer->Add( $button_box, 0, wxCENTER );

  $this->SetAutoLayout( 1 );
  $topsizer->Fit( $this );
  $topsizer->SetSizeHints( $this );
  $this->SetSizer( $topsizer );

  return $this;
}

package main;

my( $app ) = MyApp->new();
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
