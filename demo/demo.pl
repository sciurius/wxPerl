#!/usr/bin/perl -w
#############################################################################
## Name:        demo.pl
## Purpose:     wxPerl demo ( tries to be as cool as the wxPython one )
## Author:      Mattia Barbon
## Modified by:
## Created:      1/ 5/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

BEGIN {
  eval {
    require blib;
    'blib'->import;
  }
}

use Wx;
use Wx::Html;
use Wx::Help;

use FindBin;
use lib $FindBin::RealBin;

sub filename { "$FindBin::RealBin/" . $_[0] }

# some IDs
use vars qw($ID_QUIT $ID_TASKBAR_DUMMY);
( $ID_QUIT, $ID_TASKBAR_DUMMY ) = ( 10000 .. 10020 );

package Demo;

sub new {
  my $ref = shift;
  my $class = ref( $ref ) || $ref;
  my $this = {};

  bless $this, $class;
  $this->init( @_ );

  return $this;
}

package Demo::Sample;

use vars qw(@ISA); @ISA = qw(Demo);

sub init {
  my $this = shift;
  $this->{NAME} = $_[0];
}

sub name { $_[0]->{NAME} }

sub run {
  my $this = shift;

  chdir main::filename( "../samples/${$this}{NAME}/" );
#  open IN, "perl -Mblib ${$this}{NAME}.pl |";

#  Wx::Shell( 'perl -Mblib ' . $this->filename );
}

sub load {}

sub description {
  my $this = shift;
  my $name = $this->name;
  my $Name = ucfirst( $name );

  return <<EOT;
<html>
<head>
  <title>'$Name' sample</title>
</head>
<body>
<h3>$Name sample</h3>

<p>
  Sorry, the <b>$name</b> sample comes with no
  documentation.
</p>
</body>
</html>
EOT
}

sub filename {
  my $this = shift;

  return '../samples/' . $this->name . '/' . $this->name . '.pl';
}

package Demo::Demo;

use vars qw(@ISA); @ISA = qw(Demo);

sub init {}
sub load {}
sub description { return main::description() }
sub filename { return 'demo.pl' }
sub run {}

package Demo::Standard;

use vars qw(@ISA); @ISA = qw(Demo);

sub init {
  my $this = shift;

  $this->{NAME} = $_[0];
  if( $_[1] ) { $this->{PACKAGE} = $_[1] }
  else {
    ( $this->{PACKAGE} = $_[0] ) =~ s/^wx(.*)/$1Demo/;
  }
}

sub name { $_[0]->{NAME} }
sub package { $_[0]->{PACKAGE} }

sub load {
  my $this = shift;

  require $this->filename;
}

sub filename {
  my $this = shift;

  return $this->name . '.pm';
}

sub description {
  my $this = shift;

  return $this->package->description;
}

sub run {
  my( $this, $frame ) = @_;

  return $this->package->window( $frame->notebook );
}

package DemoFrame;

use base qw(Wx::Frame);
use Wx qw(:textctrl :sizer :window);
use Wx qw(wxDefaultPosition wxDefaultSize);

sub sample { return Demo::Sample->new( $_[0] ) }
sub the_demo { return Demo::Demo->new }
sub demo { return Demo::Standard->new( $_[0], $_[1] ) }

my @demos =
  ( [ 'wxPerl demo', the_demo ],
    [ 'Non-managed windows',
      [
       [ 'HtmlWindow', demo( 'wxHtmlWindow' ) ],
       [ 'Grid', demo( 'wxGrid' ) ],
       [ 'SplashScreen', demo( 'wxSplashScreen' ) ],
      ],
    ],
    [ 'Controls',
      [
       [ 'ListCtrl', demo( 'wxListCtrl' ) ],
      ],
    ],
    [ 'Miscellaneous',
      [
       [ 'FileSystem', demo( 'wxFileSystem' ) ],
       [ 'Locale', demo( 'wxLocale' ) ],
       [ 'MDI', demo( 'MDI', 'MDIDemo' ) ],
       [ 'Printing', demo( 'Printing' ) ],
       [ 'Unicode', demo( 'Unicode', 'UnicodeDemo' ), 3.0 ],
       [ 'XRC', demo( 'XRC' ), 2.003001 ],
       [ 'Clipboard', demo( 'wxClipboard' ) ],
       [ 'Drag&Drop', demo( 'DragDrop', 'DNDDemo' ) ],
       [ 'Process', demo( 'wxProcess' ) ],
      ],
    ],
#    [ 'Old samples',
#      [
#       [ 'Minimal', sample( 'minimal' ) ],
#       [ 'Controls', sample( 'controls' ) ],
#      ]
#    ],
  );

use Wx::Event qw(EVT_TREE_SEL_CHANGED EVT_CLOSE EVT_IDLE EVT_MENU);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, "wxPerl Demo", wxDefaultPosition,
                                 [ 600, 500 ] );

  my $border_mask = ~( wxSTATIC_BORDER|wxSIMPLE_BORDER|wxDOUBLE_BORDER|
                       wxSUNKEN_BORDER|wxRAISED_BORDER);

  $this->SetIcon( Wx::GetWxPerlIcon() );

  # create splitters
  my $split1 = Wx::SplitterWindow->new( $this, -1 );
  my $split2 = Wx::SplitterWindow->new( $split1, -1 );
  my $tree = Wx::TreeCtrl->new( $split1, -1 );
  my $text = Wx::TextCtrl->new( $split2, -1, "Welcome to wxPerl\n",
                                wxDefaultPosition, wxDefaultSize,
                                wxTE_READONLY|wxTE_MULTILINE );
  $this->{OLDLOG} = Wx::Log::SetActiveTarget( Wx::LogTextCtrl->new( $text ) );

  # create main notebook
  my $nb = Wx::Notebook->new( $split2, -1 );
  my $html = Wx::HtmlWindow->new( $nb, -1 );
  my $code = Wx::TextCtrl->new( $nb, -1, '', wxDefaultPosition,
                                wxDefaultSize, wxTE_READONLY|wxTE_MULTILINE );

  $nb->AddPage( $code, "Source", 0 );
  $nb->AddPage( $html, "Description", 0 );

  # populate TreeCtrl
  populate_demo_list( $tree, @demos );

  EVT_TREE_SEL_CHANGED( $this, $tree, \&OnSelChanged );
  EVT_CLOSE( $this, \&OnClose );

  $split1->SplitVertically( $tree, $split2, 150 );
  $split2->SplitHorizontally( $nb, $text, 300 );

  $this->{TREE} = $tree;
  $this->{SOURCE} = $code;
  $this->{DESCRIPTION} = $html;
  $this->{NOTEBOOK} = $nb;

  $this->load_demo( $demos[0][1] );

  # on MSW only, create task bar icon
  if( $Wx::_platform == $Wx::_msw ) {
    my $tmp = Wx::TaskBarIcon->new();
    $tmp->SetIcon( Wx::GetWxPerlIcon( 1 ), "Click on me!" );
    $this->{TASKBARICON} = $tmp;

    use Wx::Event qw(EVT_TASKBAR_LEFT_DOWN EVT_TASKBAR_RIGHT_DOWN);

    EVT_TASKBAR_LEFT_DOWN( $tmp, sub {
                     my( $this, $event ) = @_;

                     Wx::LogMessage( "Left click on task bar icon" );
                   } );
    EVT_TASKBAR_RIGHT_DOWN( $tmp, sub {
                     my( $this, $event ) = @_;

                     my $menu = Wx::Menu->new( "TaskBar Menu" );
                     $menu->Append( $main::ID_TASKBAR_DUMMY, "Click on me!" );
                     $menu->AppendSeparator();
                     $menu->Append( $main::ID_QUIT, "Quit demo" );
                     $this->PopupMenu( $menu );
                   } );
    EVT_MENU( $tmp, $main::ID_QUIT, sub {
                $this->Close();
              } );
    EVT_MENU( $tmp, $main::ID_TASKBAR_DUMMY, sub {
                Wx::LogMessage( "Selected taskbar icon menu" );
              } );
  }

  return $this;
}

sub tree { $_[0]->{TREE} }
sub source { $_[0]->{SOURCE} }
sub description { $_[0]->{DESCRIPTION} }
sub notebook { $_[0]->{NOTEBOOK} }

sub d { Wx::TreeItemData->new( $_[0] ) }

sub populate_demo_list {
  my $tree = shift;
  my $root = shift;

  my $root_id = $tree->AddRoot( $root->[0], -1, -1, d( $root->[1] ) );

  populate_demo_list_helper( $tree, $root_id, \@_ );

  $tree->Expand( $root_id );
}

sub populate_demo_list_helper {
  my $tree = shift;
  my $parent_id = shift;
  my $id;

  foreach my $i ( @{$_[0]} ) {
    next if( defined $i->[2] && $i->[2] >= $Wx::_wx_version );
    if( ref( $i->[1] ) eq 'ARRAY' ) {
      $id = $tree->AppendItem( $parent_id, $i->[0], -1, -1, d( undef ) );
      populate_demo_list_helper( $tree, $id, $i->[1] );
    } else {
      $tree->AppendItem( $parent_id, $i->[0], -1, -1, d( $i->[1] ) );
    }
  }
}

sub OnClose {
  my $this = shift;

  Wx::Log::SetActiveTarget( $this->{OLDLOG} );
  $this->{TASKBARICON}->Destroy
    if defined $this->{TASKBARICON};
  $this->notebook->DeletePage( 2 )
    if $this->notebook->GetPageCount() == 3;

  # not the most elegant way to do it
  # it would be better to pass the sizes back to the Wx::App
  # and let it save them
  my $config = Wx::ConfigBase::Get;
  my( $x, $y, $w, $h ) = ( $this->GetPositionXY, $this->GetSizeWH );

  $config->WriteInt( "X", $x );
  $config->WriteInt( "Y", $y );
  $config->WriteInt( "Width", $w );
  $config->WriteInt( "Height", $h );

  $this->Destroy;
}

sub load_demo {
  my( $this, $obj ) = @_;

  $obj->load;
  # Wx::TextCtrl::LoadFile tries to load
  # unicode in Unicode mode...
  {
    local( $_ );
    local( *SOURCE );

    my $file = main::filename( $obj->filename );

    die "File not found: '$file'" unless -f $file;
    open SOURCE, "< $file";
    my( $source, $initial_blurb ) = ( '', 1 );
    while( <SOURCE> ) {
      $initial_blurb &&= m/^#(?:#|!)/;
      next if $initial_blurb;
      $source .= $_;
    }

    $this->source->SetValue( $source );
    close SOURCE;
  }

  $this->description->SetPage( $obj->description );

  my $window = $obj->run( $this );
  my $nb = $this->notebook;
  my $sel = $nb->GetSelection;

  if( $nb->GetPageCount == 3 ) {
    $nb->SetSelection( 0 ) if $sel == 2;
    $nb->DeletePage( 2 );
  }
  if( ref( $window ) ) {
    $this->notebook->AddPage( $window, 'Demo' );
    $nb->SetSelection( $sel ) if $sel == 2;
  }
}

sub OnSelChanged {
  my( $this, $event ) = @_;
  my $id = $event->GetItem;
  my $obj = $this->tree->GetPlData( $id );

  return unless ref( $obj );

  $this->load_demo( $obj );
}

package DemoApp;

use base qw(Wx::App);

sub OnInit {
  my $this = shift;

  $this->SetAppName( "Demo" );
  $this->SetVendorName( "wxPerl" );

  my $frame = DemoFrame->new;
  my $config = Wx::ConfigBase::Get;

  my $x = $config->ReadInt( "X", 50 );
  my $y = $config->ReadInt( "Y", 50 );
  my $w = $config->ReadInt( "Width", 500 );
  my $h = $config->ReadInt( "height", 400 );

  $frame->SetSize( $x, $y, $w, $h );
  $frame->Show( 1 );

  return 1;
}

package main;

my $app = DemoApp->new;
$app->MainLoop();

sub description {
  return <<EOT;
<html>
<head>
  <title>wxPerl demo</title>
</head>
<body>
<h1>wxPerl</h1>

<p>
  This is the wxPerl demo.
</p>

<p>
  The idea for this demo was taken from the wxPython one.
</p>

</body>
</html>
EOT
}

# Local variables: #
# mode: cperl #
# End: #
