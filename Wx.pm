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
  $_platform $_msw $_gtk $_motif $_wx_version);

$_msw = 1; $_gtk = 2; $_motif = 3;

@ISA = qw(Exporter DynaLoader);
$VERSION = '0.05';

sub BEGIN{
  @EXPORT_OK = qw(wxPOINT wxSIZE);
  %EXPORT_TAGS = ( );
}

#
# utility functions
#
sub wxPOINT { Wx::Point->new( $_[0], $_[1] ) }
sub wxSIZE  { Wx::Size->new( $_[0], $_[1] )  }

sub AUTOLOAD {
  my( $constname );

  ($constname = $AUTOLOAD) =~ s{^.*::}{};

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

my( $wbmp, $wico, $wmen, $wmit, $wrec, $wreg, $wszr,
    $wtip, $wwin, $wcol, $wlci, $wsiz, $wpoi, $num, $str,
    $bool ) = ( 1 .. 26 );

my( @tnames ) =
  ( undef, 'Wx::Bitmap', 'Wx::Icon', 'Wx::Menu', 'Wx::MenuItem',
    'Wx::Rect', 'Wx::Region', 'Wx::Sizer', 'Wx::ToolTip',
    'Wx::Window', 'Wx::Colour', 'Wx::ListItem' );

$Wx::_b = [ $bool ];
$Wx::_n = [ $num ];
$Wx::_n_b = [ $num, $bool ];
$Wx::_n_n = [ $num, $num ];
$Wx::_n_n_n = [ $num, $num, $num ];
$Wx::_n_n_s_n = [ $num, $num, $str, $num ];
$Wx::_n_n_n_n = [ $num, $num, $num, $num ];
$Wx::_n_n_n_n_n = [ $num, $num, $num, $num, $num ];
$Wx::_n_n_n_n_n_n = [ $num, $num, $num, $num, $num, $num ];
$Wx::_n_s = [ $num, $str ];
$Wx::_n_s_n_n = [ $num, $str, $num, $num ];
$Wx::_n_s_wmen = [ $num, $str, $wmen ];
$Wx::_n_wbmp_s_s = [ $num, $wbmp, $str, $str ];
$Wx::_n_wbmp_wbmp = [ $num, $wbmp, $wbmp ];
$Wx::_n_wbmp_wbmp_b_s_s_s = [ $num, $wbmp, $wbmp, $bool, $str, $str, $str ];
$Wx::_n_wico = [ $num, $wico ];
$Wx::_n_wlci = [ $num, $wlci ];
$Wx::_n_wszr_n_n_n = [ $num, $wszr, $num, $num, $num ];
$Wx::_n_wwin_n_n_n = [ $num, $wwin, $num, $num, $num ];
$Wx::_s = [ $str ];
$Wx::_s_n = [ $str, $num ];
$Wx::_s_n_n = [ $str, $num, $num ];
$Wx::_s_n_n_n = [ $str, $num, $num, $num ];
$Wx::_s_s = [ $str, $str ];
$Wx::_s_s_s_b_b = [ $str, $str, $str, $bool, $bool ];
$Wx::_s_wwin_n_wbmp = [ $str, $wwin, $num, $wbmp ];
$Wx::_s_wwin_n_wico = [ $str, $wwin, $num, $wico ];
$Wx::_wbmp = [ $wbmp ];
$Wx::_wbmp_n = [ $wbmp, $num ];
$Wx::_wbmp_n = [ $wbmp, $num ];
$Wx::_wbmp_wbmp = [ $wbmp, $wbmp ];
$Wx::_wbmp_wcol = [ $wbmp, $wcol ];
$Wx::_wcol = [ $wcol ];
$Wx::_wcol_n = [ $wcol, $num ];
$Wx::_wico = [ $wico ];
$Wx::_wlci = [ $wlci ];
$Wx::_wmit = [ $wmit ];
$Wx::_wpoi = [ $wpoi ];
$Wx::_wpoi_wpoi = [ $wpoi, $wpoi ];
$Wx::_wpoi_wsiz = [ $wpoi, $wsiz ];
$Wx::_wrec = [ $wrec ];
$Wx::_wreg = [ $wreg ];
$Wx::_wsiz = [ $wsiz ];
$Wx::_wszr = [ $wszr ];
$Wx::_wszr_n_n = [ $wszr, $num, $num ];
$Wx::_wszr_n_n_n = [ $wszr, $num, $num, $num ];
$Wx::_wtip = [ $wtip ];
$Wx::_wwin = [ $wwin ];
$Wx::_wwin_n_n = [ $wwin, $num, $num ];
$Wx::_wwin_n_n_n = [ $wwin, $num, $num, $num ];
$Wx::_wwin_wsiz = [ $wwin, $wsiz ];

sub _match(\@$;$$) {
  my( $args, $sig, $required, $dots ) = @_;
  my( $argc ) = scalar( @$args );

  if( @_ > 2 ) {
    return if  $dots && $argc < $required;
    return if !$dots && $argc != $required;
  }

  my( $i, $a );

  foreach ( @$sig ) {
    last if $i >= $argc;
    next if $_ == $str;
    next if $_ == $bool;

    $a = ${$args}[$i];
    next if $_ == $num && ( ( $a + 0 ) || $a =~ /^\s*-?0+\.?0*\s*$/ );
    next if !defined( $a ) || isa( $a, $tnames[$_] );
    next if $_ == $wpoi || $_ == $wsiz && ref( $a ) eq 'ARRAY';

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

bootstrap Wx $VERSION;

_SetInstance( $DynaLoader::dl_librefs[ $#DynaLoader::dl_librefs ] );

{
  _boot_Constant( 'Wx', $VERSION );
  _boot_Functions( 'Wx', $VERSION );
  _boot_Events( 'Wx', $VERSION );
  _boot_Window( 'Wx', $VERSION );
  _boot_Controls( 'Wx', $VERSION );
  _boot_Frames( 'Wx', $VERSION );
  _boot_GDI( 'Wx', $VERSION );
}

require Wx::_Constants;

Load();

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
require Wx::ToolBar;
require Wx::Window;
require Wx::_Exp;
require Wx::_Functions;
require Wx::_Inheritance;

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
