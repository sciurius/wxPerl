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

require Exporter;
require DynaLoader;

use vars qw(@ISA $VERSION $AUTOLOAD @EXPORT_OK %EXPORT_TAGS
  $_platform $_msw $_gtk $_motif);

$_msw = 1; $_gtk = 2; $_motif = 3;

@ISA = qw(Exporter DynaLoader);
$VERSION = '0.03';

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

bootstrap Wx $VERSION;

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
require Wx::Colour;
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
