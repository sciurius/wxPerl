#!/usr/bin/perl
#############################################################################
## Name:        samples/dialogs/dialogs.pl
## Purpose:     Common dialogs wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     11/02/2001
## RCS-ID:      $Id: dialogs.pl,v 1.6 2004/10/19 20:28:13 mbarbon Exp $
## Copyright:   (c) 2001, 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

# sub Wx::Window::DESTROY { Wx::LogMessage"Destroying %s\n", ref( $_[0] ) }

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::Frame);

use Wx::Event qw(EVT_CLOSE EVT_MENU);

my( $ID_ABOUT, $ID_EXIT, $ID_FILEDIALOG, $ID_DIRDIALOG, $ID_SCHOICE,
    $ID_MCHOICE, $ID_COLOURDIALOG, $ID_TEXTDIALOG, $ID_FONTDIALOG,
    $ID_MCHOICE_FN )
  = ( 1 .. 100 );

use Wx qw(:textctrl wxDefaultPosition wxDefaultSize);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( undef, -1, $_[0], $_[1], $_[2] );

  my $t = Wx::TextCtrl->new( $this, -1, "Log Window\n", wxDefaultPosition,
                             wxDefaultSize, wxTE_MULTILINE);

  $this->SetIcon( Wx::GetWxPerlIcon() );

  $this->{OLDLOG} = Wx::Log::SetActiveTarget
    ( Wx::LogTextCtrl->new( $t ) );

  my $file  = Wx::Menu->new;
  $file->Append( $ID_ABOUT, '&About', '&About' );
  $file->AppendSeparator;
  $file->Append( $ID_EXIT, 'E&xit', "Exit" );

  my $dialogs = Wx::Menu->new;
  $dialogs->Append( $ID_FILEDIALOG, "Wx::&FileDialog\tF1" );
  $dialogs->Append( $ID_DIRDIALOG, "Wx::&DirDialog\tF2" );
  $dialogs->Append( $ID_SCHOICE, "Wx::&SingleChoiceSialog\tF3" );
  $dialogs->Append( $ID_MCHOICE, "Wx::&MultiChoiceDialog\tF4" );
  $dialogs->Append( $ID_COLOURDIALOG, "Wx::&ColourDialog\tF5" );
  $dialogs->Append( $ID_TEXTDIALOG, "Wx::&TextEntryDialog\tF6" );
  $dialogs->Append( $ID_FONTDIALOG, "Wx::F&ontDialog\tF7" );

  $dialogs->Enable( $ID_MCHOICE, 1 );

  my $functions = Wx::Menu->new;
  $functions->Append( $ID_MCHOICE_FN, "Wx::Get&MultipleChoice" );

  $functions->Enable( $ID_MCHOICE_FN, 1 );

  my $menu = Wx::MenuBar->new;
  $menu->Append( $file, "&File" );
  $menu->Append( $dialogs, "&Dialogs" );
  $menu->Append( $functions, "F&unctions" );

  $this->SetMenuBar( $menu );

  EVT_MENU( $this, $ID_ABOUT, \&OnAbout );
  EVT_MENU( $this, $ID_EXIT, \&OnExit );
  EVT_MENU( $this, $ID_FILEDIALOG, \&OnFileDialog );
  EVT_MENU( $this, $ID_DIRDIALOG, \&OnDirDialog );
  EVT_MENU( $this, $ID_SCHOICE, \&OnSingleChoiceDialog );
  EVT_MENU( $this, $ID_MCHOICE, \&OnMultiChoiceDialog );
  EVT_MENU( $this, $ID_COLOURDIALOG, \&OnColourDialog );
  EVT_MENU( $this, $ID_TEXTDIALOG, \&OnTextEntryDialog );
  EVT_MENU( $this, $ID_FONTDIALOG, \&OnFontDialog );

  EVT_MENU( $this, $ID_MCHOICE_FN, \&OnGetMultipleChoice );

  EVT_CLOSE( $this, \&OnCloseWindow );

  $this;
}

use Wx qw(:filedialog wxID_CANCEL);

{
  my $prevdir;
  my $prevfile;

  sub OnFileDialog {
    my( $this, $event ) = @_;
    my $dialog = Wx::FileDialog->new
      ( $this, "Select a file", $prevfile, $prevdir,
        "BMP files (*.bmp)|*.bmp|Text files (*.txt)|*.txt|Foo files (*.foo)|*.foo|All files (*.*)|*.*",
        wxOPEN|wxMULTIPLE );

    if( $dialog->ShowModal == wxID_CANCEL ) {
      Wx::LogMessage( "User cancelled the dialog" );
    } else {
      Wx::LogMessage( "Wildcard: %s", $dialog->GetWildcard);
      my @paths = $dialog->GetPaths;

      if( @paths > 0 ) {
        foreach ( @paths ) {
          Wx::LogMessage( "File: $_" );
        }
      } else {
        Wx::LogMessage( "No files" );
      }
    }

    $dialog->Destroy;
  }
}

sub OnDirDialog {
  my( $this, $event ) = @_;

  my $dialog = Wx::DirDialog->new( $this );

  if( $dialog->ShowModal == wxID_CANCEL ) {
    Wx::LogMessage( "User cancelled the dialog" );
  } else {
    Wx::LogMessage( "Directory: %s", $dialog->GetPath );
  }

  $dialog->Destroy;
}

use Wx qw(wxOK);

sub OnSingleChoiceDialog {
  my( $this, $event ) = @_;
  my $dialog = Wx::SingleChoiceDialog->new
    ( $this, "Make a choice", "Choose",
      [ 'Apple', 'Orange', 'Banana', 'Pear', 'Cranberry' ],
      [ '1 - apple', '2 - orange', '3 - banana', '4 - pear', '5 - cranberry' ],
      );

  if( $dialog->ShowModal == wxID_CANCEL ) {
    Wx::LogMessage( "User cancelled the dialog" );
  } else {
    Wx::LogMessage( "Selection: %d", $dialog->GetSelection );
    Wx::LogMessage( "String: %s", $dialog->GetStringSelection );
    Wx::LogMessage( "Client data: %s", $dialog->GetSelectionClientData );
  }

  $dialog->Destroy;
}

sub OnMultiChoiceDialog {
  my( $this, $event ) = @_;
  my $dialog = Wx::MultiChoiceDialog->new
    ( $this, "Make some choices", "Choose",
      [ 'Apple', 'Orange', 'Banana', 'Pear', 'Cranberry' ] );

  if( $dialog->ShowModal == wxID_CANCEL ) {
    Wx::LogMessage( "User cancelled the dialog" );
  } else {
    Wx::LogMessage( "Selections: " . join ', ', $dialog->GetSelections );
  }

  $dialog->Destroy;
}

sub OnGetMultipleChoice {
  my( $this, $event ) = @_;
  my @selections = Wx::GetMultipleChoices
    ( "Make some choices", "Choose",
      [ 'Apple', 'Orange', 'Banana', 'Pear', 'Cranberry' ], $this );

  Wx::LogMessage( "Selections: " . join ', ', @selections );
}

sub OnTextEntryDialog {
  my( $this, $event ) = @_;
  my $dialog = Wx::TextEntryDialog->new
    ( $this, "Enter som text", "Wx::TextEntryDialog sample",
      "I am a default value" );

  if( $dialog->ShowModal == wxID_CANCEL ) {
    Wx::LogMessage( "User cancelled the dialog" );
  } else {
    Wx::LogMessage( "Text: %s", $dialog->GetValue );
  }

  $dialog->Destroy;
}

sub OnColourDialog {
  my( $this, $event ) = @_;

  my $data = Wx::ColourData->new;
  $data->SetChooseFull( 1 );

  my $dialog = Wx::ColourDialog->new( $this, $data );

  if( $dialog->ShowModal == wxID_CANCEL ) {
    Wx::LogMessage( "User cancelled the dialog" );
  } else {
    my $data = $dialog->GetColourData;
    my $colour = $data->GetColour;

    Wx::LogMessage( "Colour: ( %d, %d, %d )", $colour->Red,
                    $colour->Green, $colour->Blue );
  }

  $dialog->Destroy;
}

sub OnFontDialog {
  my( $this, $event ) = @_;
  my $dialog = Wx::FontDialog->new( $this, Wx::FontData->new );

  if( $dialog->ShowModal == wxID_CANCEL ) {
    Wx::LogMessage( "User cancelled the dialog" );
  } else {
    my $data = $dialog->GetFontData;
    my $font = $data->GetChosenFont;

    if( $font ) {
      Wx::LogMessage( "Font: %s", $font->GetFaceName );
      Wx::LogMessage( "Wx::NativeFontInfo: %s",
                      $data->GetChosenFont->GetNativeFontInfo->ToString );
    }

    my $colour = $data->GetColour;

    Wx::LogMessage( "Colour: ( %d, %d, %d )",
                    $colour->Red, $colour->Green, $colour->Blue );
  }

  $dialog->Destroy;
}

use Wx qw(wxOK wxCENTRE);

sub OnAbout {
  my( $this, $event ) = @_;

  Wx::MessageBox( "wxPerl Dialogs sample", "About Dialogs sample",
                  wxOK|wxCENTRE, $this );
}

sub OnExit {
  my( $this, $event ) = @_;

  $this->Close( 1 );
}

sub OnCloseWindow {
  my $this = shift;

  Wx::Log::SetActiveTarget( $this->{OLDLOG} )->Destroy;
  $this->Destroy;
}

package MyApp;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::App);

use Wx qw(wxDefaultPosition wxDefaultSize);

sub OnInit {
  my $this = shift;

  my $frame = MyFrame->new( "wxPerl common dialogs sample",
                            wxDefaultPosition, wxDefaultSize );

  $frame->Show( 1 );

  1;
}

sub OnExit {
#  Wx::LogMessage( "Exiting" );
}

package main;

my( $app ) = MyApp->new;
$app->MainLoop;

# Local variables: #
# mode: cperl #
# End: #

