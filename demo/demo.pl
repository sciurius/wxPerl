#!/usr/bin/perl -w
#############################################################################
## Name:        demo/demo.pl
## Purpose:     wxPerl demo ( tries to be as cool as the wxPython one )
## Author:      Mattia Barbon
## Modified by:
## Created:     01/05/2001
## RCS-ID:      $Id: demo.pl,v 1.21 2005/03/27 16:25:06 mbarbon Exp $
## Copyright:   (c) 2001-2003 Mattia Barbon
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

sub is_absolute {
  if( $] < 5.005 ) {
    return $_[0] =~ m{^/};
  } else {
    require File::Spec;
    return File::Spec->file_name_is_absolute( $_[0] );
  }
}

sub filename { is_absolute( $_[0] ) ? $_[0] : "$FindBin::RealBin/" . $_[0] }

# some IDs
use vars qw($ID_QUIT $ID_TASKBAR_DUMMY $ID_ABOUT);
( $ID_QUIT, $ID_TASKBAR_DUMMY, $ID_ABOUT ) = ( 10000 .. 10020 );

package Demo;

sub new {
  my $ref = shift;
  my $class = ref( $ref ) || $ref;
  my $this = {};

  bless $this, $class;
  $this->init( @_ );

  return $this;
}

sub menu { }

package Demo::External;

use vars qw(@ISA); @ISA = qw(Demo);

sub init {
  my $this = shift;
  $this->{NAME} = $_[0];
  $this->{DIRECTORY} = $_[1] ? main::filename( $_[1] ) :
    main::filename( "../samples/${$this}{NAME}/" );
}

sub name { $_[0]->{NAME} }

sub run {
  my $this = shift;

  chdir $this->{DIRECTORY};
  Wx::ExecuteCommand( "perl ${$this}{NAME}.pl", 0 );
}

sub load {}

sub description {
  my $this = shift;
  my $file = $this->filename;
  local( *IN, $_ );
  my $description = '';

  eval {
    open IN, "< $file" or die;
    while( <IN> ) {
      if( m/^=for description$/ ) {
        while( <IN> ) {
          return if m/^=back$/;
          $description .= $_;
        }
      }
    }
    close IN or die;
  };
  return $this->no_description() unless length $description;
  return $description
}

sub no_description {
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

  return $this->{DIRECTORY} . '/' . $this->{NAME} . '.pl';
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

sub menu {
  my $this = shift;
  no strict;

  if( defined &{$this->package . '::menu'} ) {
    return $this->package->menu;
  }

  return;
}

package DemoFrame;

use base qw(Wx::Frame);
use Wx qw(:textctrl :sizer :window);
use Wx qw(wxDefaultPosition wxDefaultSize 
          wxDEFAULT_FRAME_STYLE wxNO_FULL_REPAINT_ON_RESIZE wxCLIP_CHILDREN);

sub sample { return Demo::Sample->new( $_[0] ) }
sub external { return Demo::External->new( $_[0], $_[1] ) }
sub the_demo { return Demo::Demo->new }
sub demo { return Demo::Standard->new( $_[0], $_[1] ) }

my @demos =
  ( [ 'wxPerl demo', the_demo ],
    [ 'Non-managed windows',
      [
       [ 'HtmlWindow',
         [
          [ 'Simple HtmlWindow', demo( 'wxHtmlWindow' ) ],
          [ 'Dynamic HTML', demo( 'wxHtmlDynamic' ) ],
          ( Wx::wxVERSION >= 2.005 ?
            [ 'Custom Tags', demo( 'wxHtmlTag' ) ] :
            () ),
         ],
       ],
       [ 'Grid',
         [
          [ 'Simple Grid', demo( 'wxGrid' ) ],
          [ 'Editors/Renderers', demo( 'wxGridER' ) ],
          [ 'Custom Editors/Renderers', demo( 'wxGridCER' ) ],
          [ 'Custom GridTable', demo( 'wxGridTable' ) ],
         ],
       ],
       [ 'ScrolledWindow', demo( 'wxScrolledWindow' ) ],
      ],
    ],
    [ 'Managed windows',
      [
       [ 'Wizard', demo( 'wxWizard' ) ],
       [ 'SplashScreen', external( 'splash', '.' ) ],
      ],
    ],
    [ 'Controls',
      [
       [ 'CalendarCtrl', demo( 'wxCalendarCtrl' ) ],
       [ 'CheckListBox', demo( 'wxCheckListBox' ) ],
       ( Wx::wxVERSION >= 2.005 ?
         [ 'DatePickerCtrl', demo( 'wxDatePickerCtrl' ) ] :
         () ),
       [ 'ListCtrl', demo( 'wxListCtrl' ) ],
       [ 'ScrollBar', demo( 'wxScrollBar' ) ],
      ],
    ],
    [ 'Sizers',
      [
       [ 'BoxSizer', demo( 'wxBoxSizer' ) ],
       [ 'GridSizer', demo( 'wxGridSizer' ) ],
       [ 'FrexGridSizer', demo( 'wxFlexGridSizer' ) ],
       [ 'NotebookSizer', demo( 'wxNotebookSizer' ) ],
      ],
    ],
    [ 'Contrib',
      [
       [ 'XRC', demo( 'XRC' ) ],
       [ 'XRC custom controls', demo( 'XRCCustom' ) ],
       [ 'STC', demo( 'wxSTC' ) ],
      ],
    ],
    [ 'Miscellaneous',
      [
       [ 'FileSystem', demo( 'wxFileSystem' ) ],
       [ 'Locale', demo( 'wxLocale' ) ],
       [ 'MDI', demo( 'MDI', 'MDIDemo' ) ],
       [ 'Printing', demo( 'Printing' ) ],
       [ 'Unicode', demo( 'Unicode', 'UnicodeDemo' ), 3.0 ],
       [ 'Clipboard', demo( 'wxClipboard' ) ],
       [ 'Drag&Drop', demo( 'DragDrop', 'DNDDemo' ) ],
       [ 'Process', demo( 'wxProcess' ) ],
       ( $] >= 5.007003 ?
         [ 'Threads', demo( 'wxThread' ) ] :
         () ),
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
                                 [ 600, 500 ], wxDEFAULT_FRAME_STYLE
                                 | wxNO_FULL_REPAINT_ON_RESIZE|wxCLIP_CHILDREN
                                );

  my $border_mask = ~( wxSTATIC_BORDER|wxSIMPLE_BORDER|wxDOUBLE_BORDER|
                       wxSUNKEN_BORDER|wxRAISED_BORDER);

  $this->SetIcon( Wx::GetWxPerlIcon() );

  # create menu
  my $bar = Wx::MenuBar->new;

  my $file = Wx::Menu->new;
  $file->Append( $main::ID_QUIT, "E&xit" );

  my $help = Wx::Menu->new;
  $help->Append( $main::ID_ABOUT, "&About..." );

  $bar->Append( $file, "&File" );
  $bar->Append( $help, "&Help" );

  $this->SetMenuBar( $bar );

  # create splitters
  my $split1 = Wx::SplitterWindow->new( $this, -1, wxDefaultPosition,
                                        wxDefaultSize,
                                        wxNO_FULL_REPAINT_ON_RESIZE
                                       |wxCLIP_CHILDREN);
  my $split2 = Wx::SplitterWindow->new( $split1, -1, wxDefaultPosition,
                                        wxDefaultSize,
                                        wxNO_FULL_REPAINT_ON_RESIZE
                                       |wxCLIP_CHILDREN );
  my $tree = Wx::TreeCtrl->new( $split1, -1 );
  my $text = Wx::TextCtrl->new( $split2, -1, "Welcome to wxPerl\n",
                                wxDefaultPosition, wxDefaultSize,
                                wxTE_READONLY|wxTE_MULTILINE
                               |wxNO_FULL_REPAINT_ON_RESIZE );
  $this->{OLDLOG} = Wx::Log::SetActiveTarget( Wx::LogTextCtrl->new( $text ) );

  # create main notebook
  my $nb = Wx::Notebook->new( $split2, -1, wxDefaultPosition, wxDefaultSize,
                              wxNO_FULL_REPAINT_ON_RESIZE|wxCLIP_CHILDREN );
  my $html = Wx::HtmlWindow->new( $nb, -1, wxDefaultPosition, wxDefaultSize,
                                  wxNO_FULL_REPAINT_ON_RESIZE
                                 |wxCLIP_CHILDREN );
  my $code = Wx::TextCtrl->new( $nb, -1, '', wxDefaultPosition,
                                wxDefaultSize, wxTE_READONLY|wxTE_MULTILINE
                                |wxNO_FULL_REPAINT_ON_RESIZE );

  $nb->AddPage( $code, "Source", 0 );
  $nb->AddPage( $html, "Description", 0 );

  # populate TreeCtrl
  populate_demo_list( $tree, @demos );

  EVT_TREE_SEL_CHANGED( $this, $tree, \&OnSelChanged );
  EVT_CLOSE( $this, \&OnClose );

  EVT_MENU( $this, $main::ID_QUIT, sub { $this->Close; } );
  EVT_MENU( $this, $main::ID_ABOUT, \&OnAbout );

  $split1->SplitVertically( $tree, $split2, 150 );
  $split2->SplitHorizontally( $nb, $text, 300 );

  $this->{TREE} = $tree;
  $this->{SOURCE} = $code;
  $this->{DESCRIPTION} = $html;
  $this->{NOTEBOOK} = $nb;

  $this->load_demo( $demos[0][1] );

  # on MSW only, create task bar icon
  if( Wx::wxMSW() ) {
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
    next if( defined $i->[2] && $i->[2] >= Wx::wxVERSION() );
    if( ref( $i->[1] ) eq 'ARRAY' ) {
      $id = $tree->AppendItem( $parent_id, $i->[0], -1, -1, d( undef ) );
      populate_demo_list_helper( $tree, $id, $i->[1] );
    } else {
      $tree->AppendItem( $parent_id, $i->[0], -1, -1, d( $i->[1] ) );
    }
  }
}

sub OnAbout {
  use Wx qw(wxOK wxCENTRE wxVERSION_STRING);
  my $this = shift;

  Wx::MessageBox( "wxPerl demo, (c) 2001-2002 Mattia Barbon\n" .
                  "wxPerl $Wx::VERSION, " . wxVERSION_STRING,
                  "About wxPerl demo", wxOK|wxCENTRE, $this );
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

sub add_menu {
  my $this = shift;
  my $bar = $this->GetMenuBar;
  my @menus;

  while( @_ ) {
    my( $menu, $title ) = ( pop @_, pop @_ );
    $bar->Insert( 1, $menu, $title );
  }
}

sub remove_menu {
  my $this = shift;
  my $bar = $this->GetMenuBar;

  while( $bar->GetMenuCount > 2 ) {
    $bar->Remove( 1 )->Destroy;
  }
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
    $this->remove_menu;
  }
  if( ref( $window ) ) {
    $this->notebook->AddPage( $window, 'Demo' );
    $nb->SetSelection( $sel ) if $sel == 2;
    $this->add_menu( $obj->menu );
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
