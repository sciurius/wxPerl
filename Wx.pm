#############################################################################
## Name:        Wx.pm
## Purpose:     main wxPerl module
## Author:      Mattia Barbon
## Modified by:
## Created:      1/10/2000
## RCS-ID:      $Id: Wx.pm,v 1.60 2003/05/28 20:45:35 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx;

use strict;
require Exporter;

use vars qw(@ISA $VERSION $AUTOLOAD @EXPORT_OK %EXPORT_TAGS
  $_platform $_universal $_msw $_gtk $_motif $_mac $_x11 $_static);

$_msw = 1; $_gtk = 2; $_motif = 3; $_mac = 4; $_x11 = 5;

@ISA = qw(Exporter);
$VERSION = '0.16';

sub BEGIN{
  @EXPORT_OK = qw(wxPOINT wxSIZE wxTheApp);
  %EXPORT_TAGS = ( );
}

#
# utility functions
#
sub wxPOINT  { Wx::Point->new( $_[0], $_[1] ) }
sub wxSIZE   { Wx::Size->new( $_[0], $_[1] )  }
sub wxTheApp { $Wx::wxTheApp }

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

# handle :allclasses specially
sub import {
  my $package = shift;
  my $count = 0;
  foreach ( @_ ) {
    m/^:/ or last;
    m/^:allclasses$/ and do {
      eval _get_packages();

      die $@ if $@;

      splice @_, $count, 1;
    };

    ++$count;
  }

  $package->export_to_level( 1, $package, @_ );
}

sub END {
  UnLoad();
}

sub _match(\@$;$$) { &_xsmatch( [@{shift()}],@_ ) }

sub _ovl_error {
  ( 'unable to resolve overloaded method for ', $_[0] || (caller(1))[3] );
}

sub _croak {
  require Carp;
  goto &Carp::croak;
}

#
# XSLoader/DynaLoader wrapper
#
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

#
# British vs. American spelling aliases
#
*Wx::SystemSettings::GetColour = \&Wx::SystemSettings::GetSystemColour;
*Wx::SystemSettings::GetFont   = \&Wx::SystemSettings::GetSystemFont;
*Wx::SystemSettings::GetMetric = \&Wx::SystemSettings::GetSystemMetric;
*Wx::Window::Center = \&Wx::Window::Centre;
*Wx::Window::CenterOnParent = \&Wx::Window::CentreOnParent;
*Wx::Window::CenterOnScreen = \&Wx::Window::CentreOnScreen;
*Wx::ListCtrl::InsertStringImageItem = \&Wx::ListCtrl::InsertImageStringItem;
no strict 'refs';
*{"Wx::Size::y"} = \&Wx::Size::height; # work around syntax highlighting
use strict 'refs';
*Wx::Size::x = \&Wx::Size::width;

require Wx::_Constants;

Load();
SetConstants();
SetConstantsOnce();
SetOvlConstants();
SetEvents();
SetInheritance();

#
# set up wxUNIVERSAL, wxGTK, wxMSW, etc
#
eval( "sub wxUNIVERSAL() { $_universal }" );
eval( "sub wxPL_STATIC() { $_static }" );
eval( "sub wxMOTIF() { $_platform == $_motif }" );
eval( "sub wxMSW() { $_platform == $_msw }" );
eval( "sub wxGTK() { $_platform == $_gtk }" );
eval( "sub wxMAC() { $_platform == $_mac }" );
eval( "sub wxX11() { $_platform == $_x11 }" );

require Wx::App;
require Wx::Event;
require Wx::Locale;
require Wx::Menu;
require Wx::RadioBox;
require Wx::Region;
require Wx::Sizer;
require Wx::Timer;
require Wx::Wx_Exp;
# for Wx::Stream & co.
if( $] >= 5.005 ) { require Tie::Handle; }

package Wx::GDIObject; # warning for non-existent package

#
# overloading for Wx::TreeItemId
#
package Wx::TreeItemId;

use overload '<=>'      => \&tiid_spaceship,
             'bool'     => sub { $_[0]->IsOk },
             'fallback' => 1;

#
# Various functions
#

# easier to implement than to wrap
sub GetMultipleChoices {
  my( $message, $caption, $choices, $parent, $x, $y, $centre,
      $width, $height ) = @_;

  my( $dialog ) = Wx::MultiChoiceDialog->new
    ( $parent, $message, $caption, $choices );

  if( $dialog->ShowModal() == &Wx::wxID_OK ) {
    my( @s ) = $dialog->GetSelections();
    $dialog->Destroy();
    return @s;
  }

  return;
}

sub LogTrace {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogTrace( $t );
}

sub LogTraceMask {
  my( $m ) = shift;
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogTraceMask( $m, $t );
}

sub LogStatus {
  my( $t );

  if( ref( $_[0] ) && $_[0]->isa( 'Wx::Frame' ) ) {
    my( $f ) = shift;

    $t = sprintf( shift, @_ );
    $t =~ s/\%/\%\%/g; wxLogStatusFrame( $f, $t );
  } else {
    $t = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogStatus( $t );
  }
}

sub LogError {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogError( $t );
}

sub LogFatalError {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogFatalError( $t );
}

sub LogWarning {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogWarning( $t );
}

sub LogMessage {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogMessage( $t );
}

sub LogVerbose {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogVerbose( $t );
}

sub LogSysError {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogSysError( $t ); 
}

sub LogDebug {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogDebug( $t ); 
}

1;

__END__

=head1 NAME

Wx - interface to the wxWindows GUI toolkit

=head1 SYNOPSIS

    use Wx;

=head1 DESCRIPTION

The Wx module is a wrapper for the wxWindows GUI toolkit.

This module comes with extensive documentation in HTML format; you
can download it from http://wxperl.sourceforge.net/

=head1 AUTHOR

Mattia Barbon <mbarbon@dsi.unive.it>

=cut

# Local variables: #
# mode: cperl #
# End: #
