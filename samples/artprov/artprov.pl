#!/usr/bin/perl
#############################################################################
## Name:        samples/artprov/artprov.pl
## Purpose:     Wx::ArtProvider sample, based on samples/artprov from wx
## Author:      Mattia Barbon, Matthew "Cheetah" Gabeler-Lee
## Modified by:
## Created:     11/01/2005
## RCS-ID:      $Id: artprov.pl,v 1.1 2005/01/22 13:16:16 mbarbon Exp $
## Copyright:   (c) 2000 Mattia Barbon, 2005 Matthew "Cheetah" Gabeler-Lee
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

# every program must have a Wx::App-derive class
package MyApp;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::App);

# this is called automatically on object creation
sub OnInit {
  my( $this ) = @_;

  # create new MyFrame
  my( $frame ) = MyFrame->new( "Wx::ArtProv test",
             Wx::Point->new( 50, 50 ),
             Wx::Size->new( 450, 350 )
                             );

  # set it as top window (so the app will automatically close when
  # the last top window is closed)
  $this->SetTopWindow( $frame );
  # show the frame
  $frame->Show( 1 );

  1;
}

package MyArtProvider;

use strict;
use vars qw(@ISA);

use Wx qw/:bitmap/;
use Wx::ArtProvider qw/:artid :clientid/;

@ISA = qw(Wx::PlArtProvider);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new;
  return bless $this, $class;
}

sub CreateBitmap {
  my $this = shift;
  my ($id, $client, $size) = @_;

  if ($client eq wxART_MESSAGE_BOX) {
    if ($id eq wxART_INFORMATION) {
      return Wx::Bitmap->new('info.xpm', wxBITMAP_TYPE_XPM);
    } elsif ($id eq wxART_ERROR) {
      return Wx::Bitmap->new('error.xpm', wxBITMAP_TYPE_XPM);
    } elsif ($id eq wxART_WARNING) {
      return Wx::Bitmap->new('warning.xpm', wxBITMAP_TYPE_XPM);
    } elsif ($id eq wxART_QUESTION) {
      return Wx::Bitmap->new('question.xpm', wxBITMAP_TYPE_XPM);
    }
  }
  return wxNullBitmap;
}

package MyBrowser;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::Dialog);

use Wx qw/:dialog :sizer :listctrl :bitmap :misc :id :window/;
use Wx::Event qw(EVT_LIST_ITEM_SELECTED EVT_CHOICE);
use Wx::ArtProvider qw/:artid :clientid/;

my @artids = (
  wxART_ERROR, wxART_QUESTION, wxART_WARNING, wxART_INFORMATION,
  wxART_ADD_BOOKMARK, wxART_DEL_BOOKMARK, wxART_HELP_SIDE_PANEL,
  wxART_HELP_SETTINGS, wxART_HELP_BOOK, wxART_HELP_FOLDER, wxART_HELP_PAGE,
  wxART_GO_BACK, wxART_GO_FORWARD, wxART_GO_UP, wxART_GO_DOWN,
  wxART_GO_TO_PARENT, wxART_GO_HOME, wxART_FILE_OPEN, wxART_PRINT,
  wxART_HELP, wxART_TIP, wxART_REPORT_VIEW, wxART_LIST_VIEW, wxART_NEW_DIR,
  wxART_FOLDER, wxART_GO_DIR_UP, wxART_EXECUTABLE_FILE, wxART_NORMAL_FILE,
  wxART_TICK_MARK, wxART_CROSS_MARK, wxART_MISSING_IMAGE,
);

my @clientids = (
  wxART_OTHER, wxART_TOOLBAR, wxART_MENU, wxART_FRAME_ICON,
  wxART_CMN_DIALOG, wxART_HELP_BROWSER, wxART_MESSAGE_BOX, wxART_BUTTON,
);

sub new {
  my ( $class, $parent ) = @_;

  my $this = $class->SUPER::new( $parent, -1, "Art resources browser",
    wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER);
  bless $this, $class;

  # create sizers and widgets
  my $sizer = Wx::BoxSizer->new(wxVERTICAL);
  my $subsizer1 = Wx::BoxSizer->new(wxHORIZONTAL);
  my $subsizer2 = Wx::BoxSizer->new(wxHORIZONTAL);
  my $subsub = Wx::BoxSizer->new(wxVERTICAL);

  my $choice = Wx::Choice->new($this, -1);
  for my $index (0 .. $#clientids) {
    $choice->Append($clientids[$index], $index);
  }

  $this->{list} = Wx::ListCtrl->new($this, -1, wxDefaultPosition, [250, 300],
    wxLC_REPORT | wxSUNKEN_BORDER);
  $this->{list}->InsertColumn(0, 'wxArtID');

  $this->{canvas} = Wx::StaticBitmap->new($this, -1,
    Wx::Bitmap->new('null.xpm', wxBITMAP_TYPE_XPM));

  my $ok = Wx::Button->new($this, wxID_OK, "Close");
  $ok->SetDefault;

  # layout widgets in sizers
  $subsizer1->Add(Wx::StaticText->new($this, -1, "Client:"), 0,
    wxALIGN_CENTER_VERTICAL);
  $subsizer1->Add($choice, 1, wxLEFT, 5);
  $sizer->Add($subsizer1, 0, wxALL | wxEXPAND, 10);
  $subsizer2->Add($this->{list}, 1, wxEXPAND | wxRIGHT, 10);
  $subsub->Add($this->{canvas});
  $subsub->Add(100, 100);
  $subsizer2->Add($subsub);
  $sizer->Add($subsizer2, 1, wxEXPAND | wxLEFT | wxRIGHT, 10);
  $sizer->Add($ok, 0, wxALIGN_RIGHT | wxALL, 10);

  $this->SetSizer($sizer);
  $sizer->Fit($this);

  $choice->SetSelection(6); # wxART_MESSAGE_BOX
  $this->SetArtClient(wxART_MESSAGE_BOX);

  EVT_LIST_ITEM_SELECTED($this, $this->{list}, \&OnSelectItem);
  EVT_CHOICE($this, $choice, \&OnChooseClient);

  return $this;
}

sub SetArtClient {
  my $this = shift;
  my ($client) = @_;

  my $bcur = Wx::BusyCursor->new;

  # funky jazz with image list to get memory management to function
  # correctly
  my $img = Wx::ImageList->new(16, 16);
  $img->Add(Wx::Bitmap->new('null.xpm', wxBITMAP_TYPE_XPM));

  $this->{list}->DeleteAllItems;

  for my $index (0 .. $#artids) {
    my $icon = Wx::ArtProvider::GetIcon($artids[$index], $client, [16, 16]);
    my $ind = 0;
    if ($icon->Ok) {
      $ind = $img->Add($icon);
    }
    $this->{list}->InsertImageStringItem($index, $artids[$index], $ind);
    $this->{list}->SetItemData($index, $index);
  }
  $this->{list}->SetImageList($img, wxIMAGE_LIST_SMALL);
  $this->{listimg} = $img; # preserve image list in memory
  $this->{list}->SetColumnWidth(0, wxLIST_AUTOSIZE);

  $this->{client} = $client;
}

sub OnSelectItem {
  my ($this, $event) = @_;
  my $data = $event->GetData;
  my $bmp = Wx::ArtProvider::GetBitmap($artids[$data], $this->{client});
  $this->{canvas}->SetBitmap($bmp);
  $this->{canvas}->SetSize($bmp->GetWidth, $bmp->GetHeight);
}

sub OnChooseClient {
  my ($this, $event) = @_;
  my $data = $event->GetClientData;
  $this->SetArtClient($clientids[$data]);
}

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA=qw(Wx::Frame);

use Wx::Event qw(EVT_MENU);
use Wx qw(wxMENU_TEAROFF);

# Parameters: title, position, size
sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );

  # load an icon and set it as frame icon
  $this->SetIcon( Wx::GetWxPerlIcon() );

  # create the menus
  my( $mfile ) = Wx::Menu->new( undef, wxMENU_TEAROFF );
  my( $mhelp ) = Wx::Menu->new();

  my( $ID_ABOUT, $ID_PLUGPROVIDER, $ID_BROWSER, $ID_EXIT ) = ( 1 .. 4 );
  $mhelp->Append( $ID_ABOUT, "&About...\tCtrl-A", "Show about dialog" );
  $mfile->AppendCheckItem( $ID_PLUGPROVIDER, "&Plug-in art provider",
    "Enable custom art provider" );
  $mfile->Append( $ID_BROWSER, "&Resources browser",
    "Browse all available icons" );
  $mfile->Append( $ID_EXIT, "E&xit\tAlt-X", "Quit this program" );

  use Wx::Event qw(EVT_UPDATE_UI EVT_RIGHT_UP);
  my $i = 0;
  EVT_UPDATE_UI( $mfile, $ID_EXIT, sub { warn; $_[1]->Enable( (++$i)&1 ) } );
  EVT_RIGHT_UP( $this, sub { $this->PopupMenu( $mfile, 100, 100 ) } );

  my( $mbar ) = Wx::MenuBar->new();

  $mbar->Append( $mfile, "&File" );
  $mbar->Append( $mhelp, "&Help" );

  $this->SetMenuBar( $mbar );

  # declare that events coming from menu items with the given
  # id will be handled by these routines
  EVT_MENU( $this, $ID_PLUGPROVIDER, \&OnPlugProvider );
  EVT_MENU( $this, $ID_BROWSER, \&OnBrowser );
  EVT_MENU( $this, $ID_EXIT, \&OnQuit );
  EVT_MENU( $this, $ID_ABOUT, \&OnAbout );

  # create a status bar (note that the status bar that gets created
  # has three panes, see the OnCreateStatusBar callback below
  $this->CreateStatusBar( 1 );
  # and show a message
  $this->SetStatusText( "Welcome to wxPerl!", 1 );

  $this;
}

# this is an addition to demonstrate virtual callbacks...
# it ignores all parameters and creates a status bar with three fields
sub OnCreateStatusBar {
  my( $this ) = shift;
  my( $status ) = Wx::StatusBar->new( $this, -1 );

  $status->SetFieldsCount( 2 );

  $status;
}

# called when the user toggles the 'Plug-in art provider' menu item
sub OnPlugProvider {
  my( $this, $event ) = @_;

  if ($event->IsChecked) {
    Wx::ArtProvider::PushProvider(MyArtProvider->new);
  } else {
    Wx::ArtProvider::PopProvider;
  }
}

# called when the user selects the 'Resources browser' menu item
sub OnBrowser {
  my( $this, $event ) = @_;

  my $dlg = MyBrowser->new($this);
  $dlg->ShowModal;
}

# called when the user selects the 'Exit' menu item
sub OnQuit {
  my( $this, $event ) = @_;

  # closes the frame
  $this->Close( 1 );
}

use Wx qw(wxOK wxICON_INFORMATION wxVERSION_STRING);

# called when the user selects the 'About' menu item
sub OnAbout {
  my( $this, $event ) = @_;

  # display a simple about box
  Wx::MessageBox( "This is the about dialog of artprov sample.\n" .
      "Welcome to wxPerl " . $Wx::VERSION . "\n" .
      wxVERSION_STRING,
      "About artprov", wxOK | wxICON_INFORMATION,
      $this );
}

package main;

# create an instance of the Wx::App-derived class
my( $app ) = MyApp->new();
# start processing events
$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
