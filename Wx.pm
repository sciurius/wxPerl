#############################################################################
## Name:        Wx.pm
## Purpose:     main wxPerl module
## Author:      Mattia Barbon
## Modified by:
## Created:      1/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx;
#use Carp;
#BEGIN {
#  *CORE::GLOBAL::require =
#    sub {
#      if( $_[0] =~ m/^[\d\.]+$/ ) { return 1; }
#      if( $_[0] =~ m/Heavy/ ) {
#        Carp::die;
#        Carp::cluck;
#        foreach ( 0 .. 10 ) {
#          print STDERR join "\t", caller($_),"\n";
#        }
#      }
#      CORE::require $_[0];
#    }
#  }

use strict;

require Exporter;

use vars qw(@ISA $VERSION $AUTOLOAD @EXPORT_OK %EXPORT_TAGS
  $_platform $_universal $_msw $_gtk $_motif $_wx_version $_static);

$_msw = 1; $_gtk = 2; $_motif = 3;

@ISA = qw(Exporter);
$VERSION = '0.12';

sub BEGIN{
  @EXPORT_OK = qw(wxPOINT wxSIZE wxUNIVERSAL);
  %EXPORT_TAGS = ( );
}

#
# utility functions
#
sub wxPOINT { Wx::Point->new( $_[0], $_[1] ) }
sub wxSIZE  { Wx::Size->new( $_[0], $_[1] )  }

sub AUTOLOAD {
  my( $constname );

  ($constname = $AUTOLOAD) =~ s<^.*::>{};

  my( $val ) = constant($constname, 0 );

  if ($! != 0) {
# re-add this if need support for autosplitted subroutines
#    $AutoLoader::AUTOLOAD = $AUTOLOAD;
#    goto &AutoLoader::AUTOLOAD;
    Wx::_croak( "Error while autoloading '$AUTOLOAD'" );
  }

  eval "sub $AUTOLOAD { $val }";
  goto &$AUTOLOAD;
}

sub END {
  UnLoad();
}

#use Wx::_Ovl;

sub _match(\@$;$$) { &_xsmatch( [@{shift()}],@_ ) }
#*_match = \&_xsmatch;

=for comment

sub _match(\@$;$$) {
  my( $args, $sig, $required, $dots ) = @_;
  my( $argc ) = scalar( @$args );

  if( @_ > 2 ) {
    return if  $dots && $argc < $required;
    return if !$dots && $argc != $required;
  }

  my( $i, $t ) = ( 0 );

  foreach ( @$sig ) {
    last if $i >= $argc;
    next if $_ == $str;
    next if $_ == $bool;

    $t = ${$args}[$i];
    if( $_ == $num ) {
      if( looks_like_number( $t ) ) { next } else { return 0 } }
    next if !defined( $t ) ||
      ( defined( $tnames[$_] ) && UNIVERSAL::isa( $t, $tnames[$_] ) );
    next if ( $_ == $arr ) && ref( $t ) eq 'ARRAY';
    next if ( $_ == $wpoi || $_ == $wsiz ) && ref( $t ) eq 'ARRAY';
    next if ( $_ == $wist || $_ == $wost ) &&
      ( ref( $t ) || ( \$t ) =~ m/^GLOB/ );

    # type clash: return false
    return;
  } continue {
    ++$i;
  }

  return 1;
}

=cut

sub _ovl_error {
  ( 'unable to resolve overloaded method for ', $_[0] || (caller(1))[3] );
}

sub _croak {
  require Carp;
  goto &Carp::croak;
}

sub wxPL_STATIC();
sub wx_boot($$) {
  if( $_[0] eq 'Wx' || !wxPL_STATIC ) {
    if( $] < 5.006 ) {
      require DynaLoader;
      no strict 'refs';
      push @{"$_[0]::ISA"}, 'DynaLoader';
      $_[0]->bootstrap( $_[1] );
    } else {
      require XSLoader;
      XSLoader::load( $_[0], $_[1] );
    }
  } else {
    no strict 'refs';
    my $t = $_[0]; $t =~ tr/:/_/;
    &{"_boot_$t"}( $_[0], $_[1] );
  }
}

wx_boot( 'Wx', $VERSION );

{
  _boot_Constant( 'Wx', $VERSION );
  _boot_Events( 'Wx', $VERSION );
  _boot_Window( 'Wx', $VERSION );
  _boot_Controls( 'Wx', $VERSION );
  _boot_Frames( 'Wx', $VERSION );
  _boot_GDI( 'Wx', $VERSION );
}

*Wx::SystemSettings::GetColour = \&Wx::SystemSettings::GetSystemColour;
*Wx::SystemSettings::GetFont   = \&Wx::SystemSettings::GetSystemFont;
*Wx::SystemSettings::GetMetric = \&Wx::SystemSettings::GetSystemMetric;

require Wx::_Constants;

Load();
SetConstants();
SetOvlConstants();
SetEvents();

# set up wxUNIVERSAL, wxGTK, wxMSW, etc
eval( "sub wxUNIVERSAL() { $_universal }" );
eval( "sub wxPL_STATIC() { $_static }" );
eval( "sub wxMOTIF() { $_platform == $_motif }" );
eval( "sub wxMSW() { $_platform == $_msw }" );

require Wx::App;
require Wx::ComboBox;
require Wx::ControlWithItems;
require Wx::Cursor;
require Wx::DC;
require Wx::Event;
require Wx::Icon;
require Wx::Image;
require Wx::ImageList;
require Wx::ListCtrl;
require Wx::Locale;
require Wx::Menu;
require Wx::Pen;
require Wx::RadioBox;
require Wx::Rect;
require Wx::Region;
require Wx::ScreenDC;
require Wx::Sizer;
require Wx::StaticBitmap;
require Wx::Timer;
require Wx::ToolBar;
require Wx::TreeCtrl;
require Wx::Window;
require Wx::_Exp;
require Wx::_Functions;
require Wx::_Inheritance;

require Wx::SplashScreen;

use strict;

1;

__END__

=head1 NAME

Wx - interface to the wxWindows GUI toolkit

=head1 SYNOPSIS

    use Wx;

=head1 DESCRIPTION

The Wx module is a wrapper for the wxWindows GUI toolkit.

This module comes with extensive documentation in HTML format; you
can download it at http://wxperl.sourceforge.net/

=head1 AUTHOR

Mattia Barbon <mbarbon@dsi.unive.it>

=cut

# Local variables: #
# mode: cperl #
# End: #
