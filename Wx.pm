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

use strict;

use Carp;
use UNIVERSAL qw(isa);

require Exporter;
require DynaLoader;

use vars qw(@ISA $VERSION $AUTOLOAD @EXPORT_OK %EXPORT_TAGS
  $_platform $_universal $_msw $_gtk $_motif $_wx_version $_static);

$_msw = 1; $_gtk = 2; $_motif = 3;

@ISA = qw(Exporter DynaLoader);
$VERSION = '0.11';

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
    croak "Error while autoloading '$AUTOLOAD'";
  }

  eval "sub $AUTOLOAD { $val }";
  goto &$AUTOLOAD;
}

sub END {
  UnLoad();
}

use Wx::_Ovl;

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
    next if $_ == $num && looks_like_number( $t );
    next if !defined( $t ) ||
      ( defined( $tnames[$_] ) && isa( $t, $tnames[$_] ) );
    next if ( $_ == $arr ) && ref( $t ) eq 'ARRAY';
    next if ( $_ == $wpoi || $_ == $wsiz ) && ref( $t ) eq 'ARRAY';
    next if ( $_ == $wist || $_ == $wost ) && ref( $t );

    # type clash: return false
    return;
  } continue {
    ++$i;
  }

  return 1;
}

sub _ovl_error {
  ( 'unable to resolve overloaded method for ', $_[0] || (caller(1))[3] );
}

sub wxPL_STATIC();
sub wx_boot($$) {
  if( $_[0] eq 'Wx' || !wxPL_STATIC ) {
    $_[0]->bootstrap( $_[1] );
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

require Wx::_Constants;

Load();
SetConstants();

# set up wxUNIVERSAL, wxGTK, wxMSW, etc
eval( "sub wxUNIVERSAL() { $_universal }" );
eval( "sub wxPL_STATIC() { $_static }" );

require Wx::App;
require Wx::Bitmap;
require Wx::Brush;
require Wx::Caret;
require Wx::Colour;
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

Wx - interface to wxWindows GUI toolkit

=head1 SYNOPSIS

	use Wx;

=head1 DESCRIPTION

The Wx module is a wrapper for the wxWindows GUI toolkit

=head1 AUTHOR

Mattia Barbon <mbarbon@dsi.unive.it>

=cut

# Local variables: #
# mode: cperl #
# End: #
