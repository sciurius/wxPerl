#############################################################################
## Name:        Functions.pm
## Purpose:     non-object functions
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx;

use strict;

push @Wx::EXPORT_OK, qw(_);

*Wx::_ = \&GetTranslation;

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

sub LogStatus {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogStatus( $t );
}

sub LogSysError {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogSysError( $t ); 
}

sub LogDebug {
  my( $t ) = sprintf( shift, @_ ); $t =~ s/\%/\%\%/g; wxLogDebug( $t ); 
}

1;
