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
  $_platform $_msw $_gtk $_motif);

$_msw = 1; $_gtk = 2; $_motif = 3;

@ISA = qw(Exporter DynaLoader);
$VERSION = '0.04';

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

  ($constname = $AUTOLOAD) =~ s/.*:://;

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

no strict;

$_n = [ qw(INTEGER) ];
$_n_n = [ qw(INTEGER INTEGER) ];
$_n_n_n = [ qw(INTEGER INTEGER INTEGER) ];
$_n_n_n_n = [ qw(INTEGER INTEGER INTEGER INTEGER) ];
$_n_n_n_n_n = [ qw(INTEGER INTEGER INTEGER INTEGER INTEGER) ];
$_n_n_n_n_n_n = [ qw(INTEGER INTEGER INTEGER INTEGER INTEGER INTEGER) ];
$_n_s = [ qw(INTEGER ?) ];
$_n_s_wmen = [ qw(INTEGER ? Wx::Menu) ];
$_n_wbmp_s_s = [ qw(INTEGER Wx::Bitmap ? ?) ];
$_n_wbmp_wbmp = [ qw(INTEGER Wx::Bitmap Wx::Bitmap) ];
$_n_wbmp_wbmp_n_s_s_s = [ qw(INTEGER Wx::Bitmap Wx::Bitmap INTEGER ? ? ?) ];
$_n_wico = [ qw(INTEGER Wx::Icon) ];
$_n_wszr_n_n_n = [ qw(INTEGER Wx::Sizer INTEGER INTEGER INTEGER) ];
$_n_wwin_n_n_n = [ qw(INTEGER Wx::Window INTEGER INTEGER INTEGER) ];
$_s = [ qw(?) ];
$_s_n = [ qw(? INTEGER) ];
$_s_n_n_n = [ qw(? INTEGER INTEGER INTEGER) ];
$_s_s = [ qw(? ?) ];
$_s_wwin_n_wbmp = [ qw(? Wx::Window INTEGER Wx::Bitmap) ];
$_s_wwin_n_wico = [ qw(? Wx::Window INTEGER Wx::Icon) ];
$_wbmp = [ qw(Wx::Bitmap) ];
$_wbmp_n = [ qw(Wx::Bitmap INTEGER) ];
$_wbmp_wbmp = [ qw(Wx::Bitmap Wx::Bitmap) ];
$_wbmp_wcol = [ qw(Wx::Bitmap Wx::Colour) ];
$_wcol = [ qw(Wx::Colour) ];
$_wcol_n = [ qw(Wx::Colour INTEGER) ];
$_wico = [ qw(Wx::Icon) ];
$_wmit = [ qw(Wx::MenuItem) ];
$_wpoi = [ qw(Wx::Point) ];
$_wpoi_wpoi = [ qw(Wx::Point Wx::Point) ];
$_wpoi_wsiz = [ qw(Wx::Point Wx::Size) ];
$_wrec = [ qw(Wx::Rect) ];
$_wreg = [ qw(Wx::Region) ];
$_wsiz = [ qw(Wx::Size) ];
$_wszr = [ qw(Wx::Sizer) ];
$_wszr_n_n = [ qw(Wx::Sizer INTEGER INTEGER) ];
$_wszr_n_n_n = [ qw(Wx::Sizer INTEGER INTEGER INTEGER) ];
$_wtip = [ qw(Wx::ToolTip) ];
$_wwin = [ qw(Wx::Window) ];
$_wwin_n_n = [ qw(Wx::Window INTEGER INTEGER) ];
$_wwin_n_n_n = [ qw(Wx::Window INTEGER INTEGER INTEGER) ];
$_wwin_wsiz = [ qw(Wx::Window Wx::Size) ];
$s_n_n = [ qw(? INTEGER INTEGER) ];
$wbmp_n = [ qw(Wx::Bitmap INTEGER) ];
$wcol_n_n = [ qw(Wx::Colour INTEGER INTEGER) ];

use strict;

sub _match(\@$;$$) {
  my( $args, $sig, $required, $dots ) = @_;
  my( $argc ) = scalar( @$args );

  if( defined( $required ) ) {
    return if  $dots && $argc < $required;
    return if !$dots && $argc != $required;
  }

  my( $i, $a );

  foreach ( @$sig ) {
    last if $i >= $argc;
    next if $_ eq '?';
    $a = ${$args}[$i];
    next if $_ eq 'INTEGER' && ( ( $a + 0 ) || $a =~ /^\s*-?0+\.?0*\s*$/ );
    next if !defined( $a ) || isa( $a, $_ );
    next if $_ eq 'Wx::Point' || $_ eq 'Wx::Size' &&
      ref( $a ) eq 'ARRAY';
    return;
  } continue {
    ++$i;
  }

  return 1;
}

sub _ovl_error {
  ( 'unable to resolve overloaded method for ', $_[0] );
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
