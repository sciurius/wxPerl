#############################################################################
## Name:        t/Tests_Helper.pm
## Purpose:     some test helper functions
## Author:      Mattia Barbon
## Modified by:
## Created:     02/06/2001
## RCS-ID:      $Id$
## Copyright:   (c) 2001-2003, 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Tests_Helper;

use strict;
use Wx;
require Exporter;

use Test::More ();
*ok = \&Test::More::ok;
*is = \&Test::More::is;
*diag = \&Test::More::diag;

use vars qw(@ISA %EXPORT_TAGS @EXPORT_OK);

@ISA = qw(Exporter);

%EXPORT_TAGS =
  ( inheritance => [ qw(test_inheritance test_inheritance_all
                        test_inheritance_start test_inheritance_end) ],
    overload    => [ qw(hijack test_override) ],
  );

@EXPORT_OK = ( qw(test_app app_timeout test_frame in_frame),
               @{$EXPORT_TAGS{inheritance}}, @{$EXPORT_TAGS{overload}} );

sub in_frame($) {
  my $callback = shift;
  my $sub = sub {
    my $frame = Tests_Helper_Frame->new( $callback );

    $frame->Show( 1 );
  };

  test_app( $sub );

  Wx::wxTheApp->MainLoop;
}

sub app_timeout($) {
  test_app( sub {
              my $frame = Wx::Frame->new( undef, -1, 'test' );
              my $timer = Wx::Timer->new( $frame );

              Wx::Event::EVT_TIMER( $frame, -1, sub {
                                      Wx::wxTheApp()->ExitMainLoop;
                                      $frame->Destroy;
                                    } );

              $timer->Start( 500, 1 );
              Wx::WakeUpIdle();
              $frame->Show( 1 );
            } );
}

sub test_app {
  my $function = shift;

  return Tests_Helper_App->new( $function );
}

sub test_frame {
  my( $class, $delete_after ) = @_;
  my @params = @_;

  my $function = sub {
    my $frame = $class->new( @params );

    if( $delete_after ) {
        Wx::Event::EVT_IDLE( $frame,
                             sub { $frame->Destroy } );
        # force idle event delivery
        Wx::Timer->new->Start( 100 );
    }
  };

  my $app = Tests_Helper_App->new( $function );

  return $app;
}

sub test_inheritance {
  my( %perl_inheritance, %cpp_inheritance );

 LOOP: foreach my $i ( @_ ) {
    my $key = $i;
    my $cn = "wx${key}";
    my $ci = Wx::ClassInfo::FindClass( $cn ) or next LOOP;

    while ( 1 ) {
      push @{$cpp_inheritance{$key}}, cpp_2_perl( $cn );

      last unless $ci;
      $cn = $ci->GetBaseClassName1();
      last unless $cn;
      $ci = Wx::ClassInfo::FindClass( $cn );
    }

    my $class = $key;

    while ( $class ) {
      push @{$perl_inheritance{$key}}, "Wx::$class";

      last unless exists $Wx::{"${class}::"}{ISA} && 
        @{ $Wx::{"${class}::"}{ISA} };
      die $class unless defined @{ $Wx::{"${class}::"}{ISA} }[0];
      $class = substr @{ $Wx::{"${class}::"}{ISA} }[0], 4;
    }
  }

 CLASSES: foreach my $i ( keys %perl_inheritance ) {
    my $pi = $perl_inheritance{$i};
    my $ci = $cpp_inheritance{$i};
    my @pi = @$pi;
    my @ci =  @$ci;

  COMPARE: while ( @ci ) {
      my( $c_class ) = shift @ci;
      next if $c_class =~ m/Wx::Generic(?:ListCtrl|ImageList|AnimationCtrl)/;
      next if $c_class =~ m/(?:Base|GTK|X11)$/;
      next if $c_class =~ m/StatusBar/; #FIXME// ad hoc
      next if $c_class eq 'Wx::Object';
      my( $p_class );

      while ( @pi ) {
        $p_class = shift @pi;
        next COMPARE if $c_class eq $p_class;
      }

      ok( 0, $pi->[0] . ' inheritance chain' );
      diag( "C++ : @{$ci}" );
      diag( "Perl: @{$pi}" );

      next CLASSES;
    }

    ok( 1,  $pi->[0] . ' inheritance chain' );
  }
}

{
  my %classes_skip;

  sub test_inheritance_start {
    foreach my $i ( keys %Wx:: ) {
      next unless $i =~ m/^([^_].*)::$/;
      $classes_skip{$1} = 1;
    }
  }

  sub test_inheritance_end {
    my @classes;

    foreach my $i ( keys %Wx:: ) {
      next unless $i =~ m/^([^_].*)::$/;
      next if exists $classes_skip{$1};
      push @classes, $1;
    }

    test_inheritance( @classes );
  }
}

sub test_inheritance_all {
  my @classes;

  foreach my $i ( keys %Wx:: ) {
    next unless $i =~ m/^([^_].*)::$/;
    push @classes, $1;
  }

  test_inheritance( @classes );
}

# utility

sub perl_2_cpp {
  my( $v ) = $_[0];

  $v =~ s/^Wx::/wx/;

  $v;
}

sub cpp_2_perl {
  my( $v ) = $_[0];

  $v =~ s/^wx/Wx::/;

  $v;
}

sub hijack {
  while( @_ ) {
    my( $name, $code ) = ( shift, shift );
    no strict 'refs';
    die "Unknown method name '$name'" unless defined &{$name};
    my $old = \&{$name};
    undef *{$name};
    *{$name} = sub { &$code; goto &$old };
  }
}

sub test_override(&$) {
  my( $code, $method ) = @_;
  my $called = 0;

  local $Test::Builder::Level = $Test::Builder::Level + 1;
  hijack( $method => sub { $called = 1 } );
  $code->();
  ok( $called, $method );
}

package Tests_Helper_App;

use base 'Wx::App';

my $on_init;

sub new {
  my $class = shift;
  my $function = shift;
  $on_init = $function;
  my $this = $class->SUPER::new( @_ );
  $this->SetExitOnFrameDelete(1);
  return $this;
}

sub OnInit {
  &$on_init;

  return 1;
}

package Tests_Helper_Frame;

use base 'Wx::Frame';

sub new {
  my $ref = shift;
  my $callback = shift;
  my $self = $ref->SUPER::new( undef, -1, "Test Frame" );
  my $timer = Wx::Timer->new( $self );

  Wx::Event::EVT_TIMER( $self, -1, sub {
                            &$callback( $self, $_[1] );
                            $self->Destroy;
                        } );

  $timer->Start( 500, 1 );
  Wx::WakeUpIdle();

  return $self;
}

sub Destroy {
    my $self = shift;

    $self->SUPER::Destroy;
    Wx::wxTheApp()->ExitMainLoop;
    Wx::WakeUpIdle();
}

1;

# Local variables: #
# mode: cperl #
# End: #
