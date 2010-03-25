#!/usr/bin/perl -w

# Create a frame
# Create and use some locally scoped contexts and GCDC's in the EVT_PAINT handler
# After this, create and use some some globally scoped contexts and GCDCs using
# the ClientDC base.
# create and join thread;

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;
use Wx qw(:everything);
use if !Wx::wxTHREADS(), 'Test::More' => skip_all => 'No thread support';
use if !defined(&Wx::GraphicsContext::Create) => 'Test::More' => skip_all => 'no GraphicsContext';
use lib './t';
use Test::More 'tests' => 9;

package MyFrame;
use Test::More;
use Wx qw( :everything );
use base 'Wx::Frame';
use Wx::Event qw(EVT_PAINT);

my ( $context, $contextdc, $clientdc );

our $eventpaintcalled;

sub new {
  my $class = shift;
  my $self = $class->SUPER::new( undef, -1, 'Test' );
  $eventpaintcalled = 0;
  EVT_PAINT($self, \&on_paint);
  return $self;
}

sub on_draw {
  my $self = shift;

  ok(1, 'on draw called');
  
  # persistent items
  
  my $usegcdc = (Wx::wxVERSION > 2.0080075) ? 1 : 0;
  
  # Cannot CREATE graphics context from a DC outside paint event on wxMAC
  # but we can 'Create' from a Window OR from GCDC (which creates from a window)  
  
  $clientdc = Wx::ClientDC->new($self);
    
  # check out default renderer redisp
 
  $context = Wx::GraphicsRenderer::GetDefaultRenderer()->CreateContext( $self );
  # we should not really use a Wx::GCDC AND create a GraphicsContext
  $contextdc = Wx::GCDC->new($clientdc) if $usegcdc;
    
  $context->SetFont( Wx::SystemSettings::GetFont( wxSYS_SYSTEM_FONT ), wxBLACK );
  $context->DrawText('Test',20,20)  if Wx::wxMAC();

  if($usegcdc) {
      $contextdc->SetFont( Wx::SystemSettings::GetFont( wxSYS_SYSTEM_FONT ) );
      $contextdc->DrawText('Test',20,50) if !Wx::wxMAC();
  }
  
  ok($eventpaintcalled, 'event paint called before on_draw'); # ensure we fail if EVT_PAINT was not called

  can_ok('Wx::GraphicsContext', (qw( CLONE DESTROY ) ));  
    
  SKIP: {
    skip "No wxGCDC", 1 if !$usegcdc;
    can_ok('Wx::GCDC', (qw( CLONE DESTROY GetGraphicsContext) ));
  }

  SKIP: {
    skip "No SetGraphicsContext on wxMAC or No wxGCDC", 1 if( Wx::wxMAC() || (!$usegcdc));
    can_ok('Wx::GCDC', (qw( SetGraphicsContext) ));
  }

  my $t = threads->create
       ( sub {
             ok( 1, 'In thread' );
             } );
  ok( 1, 'Before join' );
  $t->join;
  ok( 1, 'After join' );
}

sub on_paint {
  my($self, $event) = @_;
  # some items to drop out of scope
  my $usegcdc = (Wx::wxVERSION > 2.0080075) ? 1 : 0;
  my $dc = Wx::PaintDC->new($self);
  
  my $gcdc = Wx::GCDC->new($dc) if $usegcdc;
  
  # if we use a Wx::GCDC - NEVER create a Graphics Context in OnPaint
  my $ctx = ( $usegcdc ) ? $gcdc->GetGraphicsContext : Wx::GraphicsContext::Create( $dc );
  
  $ctx->SetFont( Wx::SystemSettings::GetFont( wxSYS_SYSTEM_FONT ), wxBLACK );
  $ctx->DrawText('Test',20,20);
  if($usegcdc) {
    $gcdc->SetFont( Wx::SystemSettings::GetFont( wxSYS_SYSTEM_FONT ) );
    $gcdc->DrawText('Test',20,50);
  }
  $eventpaintcalled = 1;
}


package MyApp;
use Wx qw( :everything );
use base qw(Wx::App);


sub OnInit {
  my $self = shift;
  my $mwin = MyFrame->new(undef, -1);
  $self->SetTopWindow($mwin);
  $mwin->Show(1);
  return 1;
}


package main;
use Wx qw ( :everything );

my $app = MyApp->new;
my $win = $app->GetTopWindow;

my $timer = Wx::Timer->new( $win );

Wx::Event::EVT_TIMER( $win, -1, sub { $win->on_draw; wxTheApp->ExitMainLoop } );

$timer->Start( 500, 1 );

$app->MainLoop;

$win->Destroy;

END { ok(1, 'Global destruction OK'); }

