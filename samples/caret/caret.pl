#!/usr/bin/perl -w
#############################################################################
## Name:        samples/caret/caret.pl
## Purpose:     Caret wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     12/01/2001
## RCS-ID:      $Id: caret.pl,v 1.5 2006/11/26 17:05:43 mbarbon Exp $
## Copyright:   (c) 2001, 2004, 2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;
use Wx;

package MyFrame;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::Frame);

my( $id_blinktime, $id_about, $id_quit ) = ( 1 .. 3 );

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( undef, -1, @_ );

  my( $file ) = Wx::Menu->new;
  $file->Append( $id_blinktime, "&Blink time...\tCtrl-B" );
  $file->AppendSeparator;
  $file->Append( $id_about, "&About...\tCtrl-A" );
  $file->AppendSeparator;
  $file->Append( $id_quit, "E&xit\tAlt-X" );

  my( $bar ) = Wx::MenuBar->new;
  $bar->Append( $file, "&File" );

  $this->SetMenuBar( $bar );

  $this->{CANVAS} = MyCanvas->new( $this );

  $this->CreateStatusBar( 2 );
  $this->SetStatusText( 'Welcome to wxPerl!' );

  $this->SetIcon( Wx::GetWxPerlIcon() );

  use Wx::Event qw(EVT_MENU);

  EVT_MENU( $this, $id_quit, \&OnQuit );
  EVT_MENU( $this, $id_about, \&OnAbout );
  EVT_MENU( $this, $id_blinktime, \&OnSetBlinkTime );

  $this;
}

sub OnQuit {
  my( $this, $event ) = @_;

  $this->Close( 1 );
}

sub OnAbout {
  my( $this, $event ) = @_;

  use Wx qw(wxOK wxICON_INFORMATION);

  Wx::MessageBox( "Caret wxPerl Sample", "About Caret",
                  wxOK | wxICON_INFORMATION, $this );
}

sub OnSetBlinkTime {
  my( $this, $event );
  my( $blinktime ) = Wx::GetNumberFromUser
    ( 'The caret blink time is the time between two blinks',
      'Time in milliseconds', 'Caret Sample', Wx::Caret::GetBlinkTime,
      0, 10000, $this );

  if( $blinktime != -1 ) {
    Wx::Caret::SetBlinkTime( $blinktime );
    Wx::LogStatus( $this, 'Blink time set to %d milliseconds', $blinktime );
  }
}

package MyCanvas;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::ScrolledWindow);

sub CharAt {
  my( $this, $x, $y, $char ) = @_;
  my( $pos ) = $x + $y * $this->{XCHARS};

  if( @_ == 4 ) { substr( $this->{TEXT}, $pos, 1 ) = $char }
  substr( $this->{TEXT}, $pos, 1 );
}

sub Home { $_[0]->{XCARET} = 0 }
sub End { $_[0]->{XCARET} = $_[0]->{XCHARS} - 1 }
sub FirstLine { $_[0]->{YCARET} = 0 }
sub LastLine { $_[0]->{YCARET} = $_[0]->{YCHARS} - 1 }
sub PrevChar { if( ! $_[0]->{XCARET} -- ) { $_[0]->End; $_[0]->PrevLine } }
sub NextChar { if( ++ $_[0]->{XCARET} == $_[0]->{XCHARS} ) {
  $_[0]->Home; $_[0]->NextLine } }
sub PrevLine { if( ! $_[0]->{YCARET} -- ) { $_[0]->LastLine } }
sub NextLine { if( ( ++ $_[0]->{YCARET} ) == $_[0]->{YCHARS} ) { $_[0]->FirstLine } }

use Wx qw(wxDefaultPosition wxDefaultSize wxSUNKEN_BORDER);
use Wx qw(:font wxWHITE wxNORMAL_FONT);
use Wx::Event qw(EVT_SIZE EVT_PAINT EVT_CHAR);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( $_[0], -1, wxDefaultPosition,
                                    wxDefaultSize, wxSUNKEN_BORDER );

  $this->{TEXT} = undef;
  $this->SetBackgroundColour( wxWHITE );
  $this->{FONT} = Wx::Font->new( 14, wxMODERN, wxNORMAL, wxNORMAL );

  my( $dc ) = Wx::ClientDC->new( $this );
  $dc->SetFont( $this->{FONT} );
  @{$this}{'HEIGHTCHAR','WIDTHCHAR'} =
    ( $dc->GetCharHeight, $dc->GetCharWidth );

  my( $caret ) = Wx::Caret->new( $this, @{$this}{'WIDTHCHAR','HEIGHTCHAR'} );
  $this->SetCaret( $caret );

  @{$this}{'XMARGIN','YMARGIN'} = ( 5, 5 );
  @{$this}{'XCARET','YCARET'} = ( 0, 0 );
  $caret->Move( @{$this}{'XMARGIN','YMARGIN'} );
  $caret->Show();

  EVT_SIZE( $this, \&OnSize );
  EVT_PAINT( $this, \&OnPaint );
  EVT_CHAR( $this, \&OnChar );
}

use Wx qw(:keycode wxSOLID);

sub OnChar {
  my( $this, $event ) = @_;

  {
    my( $t ) = $event->GetKeyCode;

    $t == WXK_LEFT && do { $this->PrevChar, last };
    $t == WXK_RIGHT && do { $this->NextChar, last };
    $t == WXK_UP && do { $this->PrevLine, last };
    $t == WXK_DOWN && do { $this->NextLine, last };
    $t == WXK_HOME && do { $this->Home, last };
    $t == WXK_END && do { $this->End, last };
    $t == WXK_RETURN && do { $this->Home, $this->NextLine, last };

    if( !$event->AltDown && 1 #FIXME// wxIsPrint
      ) {
      my $ch = chr $event->GetKeyCode;
      $this->CharAt( $this->{XCARET}, $this->{YCARET}, $ch );

      #FIXME// wxCaretSuspend
      my $dc = Wx::ClientDC->new( $this );
      $dc->SetFont( $this->{FONT} );
      $dc->SetBackgroundMode( wxSOLID );
      $dc->DrawText( $ch, $this->{XMARGIN} + $this->{XCARET} * $this->{WIDTHCHAR},
                     $this->{YMARGIN} + $this->{YCARET} * $this->{HEIGHTCHAR} );

      $this->NextChar;
    } else {
      $event->Skip
    }
  }

  $this->DoMoveCaret;
  $this->Refresh;
}

sub OnSize {
  my( $this, $event ) = @_;

  $this->{XCHARS} = int( ( $event->GetSize->x - 2 * $this->{XMARGIN} ) /
    $this->{WIDTHCHAR} ) || 1;
  $this->{YCHARS} = int( ( $event->GetSize->y - 2 * $this->{YMARGIN} ) /
    $this->{HEIGHTCHAR} ) || 1;

  $this->{TEXT} = ' ' x ( $this->{XCHARS} * $this->{YCHARS} );

  my( $frame ) = $this->GetParent();

  $frame->SetStatusText( sprintf( 'Panel size is ( %d, %d)',
                                  $this->{XCHARS}, $this->{YCHARS} ), 1 );

  $event->Skip;
}

sub OnPaint {
  my( $this, $event ) = @_;

  #FIXME// wxCaretSuspend
  my( $dc ) = Wx::PaintDC->new( $this );
  $this->PrepareDC( $dc );
  $dc->Clear();
  $dc->SetFont( $this->{FONT} );

  foreach my $y ( 0 .. ( $this->{YCHARS} - 1 ) ) {
    $dc->DrawText( substr( $this->{TEXT}, $y * $this->{XCHARS},
                           $this->{XCHARS} ),
                   $this->{XMARGIN},
                   $this->{YMARGIN} + $y * $this->{HEIGHTCHAR} );
  }
}

sub DoMoveCaret {
  my( $this ) = @_;

  Wx::LogStatus( 'Caret is at ( %d, %d )', $this->{XCARET}, $this->{YCARET} );

  $this->GetCaret->Move( $this->{XMARGIN} + $this->{XCARET} * $this->{WIDTHCHAR},
                         $this->{YMARGIN} + $this->{YCARET} * $this->{HEIGHTCHAR} );
}

package MyApp;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::App);

sub OnInit {
  my( $this ) = shift;
  my( $frame ) = MyFrame->new( "Caret wxPerl sample", [50, 50], [ 450, 400 ] );

  $frame->Show( 1 );
  $this->SetTopWindow( $frame );

  1;
}

package main;

my( $app ) = MyApp->new();

$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #

