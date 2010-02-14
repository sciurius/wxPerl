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
use Test::More 'tests' => 8;

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

  # Mac doesn't like drawing text in this situation
  # it fails before we get to threads at all.
  # But, we can create the objects to test at least

  my $usegcdc = (Wx::wxVERSION > 2.0080075) ? 1 : 0;
  $clientdc = Wx::ClientDC->new($self);
  $context = Wx::GraphicsContext::Create( $clientdc );
  $contextdc = Wx::GCDC->new($clientdc) if $usegcdc;
  
  $context->SetFont( Wx::SystemSettings::GetFont( wxSYS_SYSTEM_FONT ), wxBLACK );
  $context->DrawText('Test',20,20) if !Wx::wxMAC();
  if($usegcdc) {
    $contextdc->SetFont( Wx::SystemSettings::GetFont( wxSYS_SYSTEM_FONT ) );
    $contextdc->DrawText('Test',20,50) if !Wx::wxMAC();
  }
  
  ok($eventpaintcalled, 'event paint called before on_draw'); # ensure we fail if EVT_PAINT was not called

  TODO: {
        local $TODO = "No CLONE or DESTROY for GraphicsContext ?";
    can_ok('Wx::GraphicsContext', (qw( CLONE DESTROY) ));  
  }
  
  SKIP: {
        skip "No wxGCDC", 1 if !$usegcdc;
    can_ok('Wx::GCDC', (qw( CLONE DESTROY) ));
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
  my $ctx = Wx::GraphicsContext::Create( $dc );
  my $gcdc = Wx::GCDC->new($dc) if $usegcdc;
  
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

