#############################################################################
## Name:        wxProcess.pm
## Purpose:     wxProcess demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 2/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package ProcessDemo;

use strict;

sub window {
  shift;
  my $parent = shift;

  return ProcessDemoWindow->new( $parent );
}

sub description {
  return <<EOT;
EOT
}

package ProcessDemoWindow;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Panel);

use Wx::Event qw(EVT_BUTTON EVT_TEXT_ENTER EVT_IDLE EVT_END_PROCESS);
use Wx qw(:textctrl);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $async1 = Wx::Button->new( $this, -1, 'Asyncronous non-interactive process',
                                [10, 10] );
  my $async2 = Wx::Button->new( $this, -1, 'Asyncronous GUI process', [10, 40] );
  my $sync1 = Wx::Button->new( $this, -1, 'I/O redirection', [10, 70] );

  EVT_BUTTON( $this, $async2, \&OnGuiProcess );
  EVT_BUTTON( $this, $async1, \&OnNonGuiProcess );
  EVT_BUTTON( $this, $sync1, \&OnIORedir );

  $this->{INPUT} = Wx::TextCtrl->new( $this, -1, '', [10, 100], [200, 25],
                                      wxTE_PROCESS_ENTER );
  $this->{OUTPUT} = Wx::TextCtrl->new( $this, -1, '', [10, 130], [350, 200],
                                       wxTE_MULTILINE|wxTE_READONLY );
  $this->{EOF} = Wx::Button->new( $this, -1, 'Send EOF', [240, 100] );

  EVT_TEXT_ENTER( $this, $this->input, \&OnEnter );
  EVT_END_PROCESS( $this, -1, \&OnEndProcess );
  EVT_IDLE( $this, \&OnIdle );
  EVT_BUTTON( $this, $this->eof, \&OnCloseStream );

  $this->EnableControls( 0 );

  return $this;
}

sub input { $_[0]->{INPUT} }
sub output { $_[0]->{OUTPUT} }
sub process { $_[0]->{PROCESS} }
sub eof { $_[0]->{EOF} }

sub OnGuiProcess {
  my $prog = main::filename( '../samples/minimal/minimal.pl' );

  # execute asyncronously, we don't care about termination
  my $pid = Wx::ExecuteCommand( "$^X $prog", 0, undef );

  Wx::LogStatus( "Process started with pid $pid" );
}

sub OnNonGuiProcess {
  # data/dummy.pl x : waits 10 secs, then exists with code x
  my $prog = main::filename( 'data/dummy.pl' );

  # execute asyncronously
  my $pid = Wx::ExecuteArgs( [$^X, $prog, 37], 0, MyProcess->new );

  Wx::LogStatus( "Process started with pid $pid" );
}

sub OnEndProcess {
  my( $this ) = @_;

  $this->EnableControls( 0 );
  $this->output->AppendText( "Process terminated\n" );
  Wx::LogMessage( "Process terminated" );
  $this->{PROCESS}->Destroy;
  undef $this->{PROCESS};
}

sub OnIORedir {
  my $this = shift;

  $this->EnableControls( 1 );
  my $process = Wx::Process->new( $this );
  $this->{PROCESS} = $process;
  $process->Redirect;

  Wx::ExecuteArgs( [$^X, main::filename( 'data/cat.pl' )], 0, $process );
#  Wx::ExecuteArgs( ['date'], 0, $process );
}

sub OnEnter {
  my $this = shift;

  print { $this->process->GetOutputStream } $this->input->GetValue, "\n";
  $this->input->SetValue( '' );
}

sub OnIdle {
  my $this = shift;
  my $process = $this->process;

  if( defined $process ) {
    my $stream = $process->GetInputStream;
#    Wx::LogMessage( "Null stream!" ) unless defined $stream;
#    Wx::LogMessage( "Stream: '%s'", tied( $$stream ) );
    my $value = <$stream>;
    $this->output->AppendText( $value ) if defined $value;
  }
}

sub OnCloseStream {
  my $this = shift;

  $this->process->CloseOutput;
}

# enables controls for interactive I/O
sub EnableControls {
  my( $this, $flag ) = @_;

  $this->input->Enable( $flag );
  $this->output->Enable( $flag );
  $this->eof->Enable( $flag );
}

package MyProcess;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Process);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new();

  return $this;
}

sub OnTerminate {
  my( $this, $pid, $status ) = @_;

  Wx::LogMessage( "Process '$pid' terminated with status $status" );
}

1;

# Local variables: #
# mode: cperl #
# End: #
