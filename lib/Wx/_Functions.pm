#############################################################################
## Name:        Functions.pm
## Purpose:     non-memeber functions
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: _Functions.pm,v 1.9 2003/05/26 20:35:28 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::_Functions; # for RPM

package Wx;

use strict;

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

# Local variables: #
# mode: cperl #
# End: #
