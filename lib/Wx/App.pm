#############################################################################
## Name:        App.pm
## Purpose:     Wx::App class
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000-2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::App;

use strict;
use vars qw(@ISA $theapp);

@ISA = qw(Wx::_App);

# this allows multiple ->new calls and it is an horrible kludge to allow
# Wx::Perl::SplashFast to work "better"; see also App.xs:Start
sub new {
  my $this;

  if( ref $theapp ) {
    my $class = ref( $_[0] ) || $_[0];
    bless $theapp, $class;
    $this = $theapp;
  } else {
    #Wx::_croak( "Only one 'Wx::App' instance allowed" ) if $theapp;
    $this = $_[0]->SUPER::new();
    $theapp = $this;
  }

  $this->SetAppName($_[0]); # reasonable default for Wx::ConfigBase::Get

  Wx::_App::Start($this,$this->can('OnInit')) ||
      Wx::_croak( 'OnInit must return a true return value' );

  $this;
}

sub OnInit {
  0;
}

1;

# Local variables: #
# mode: cperl #
# End: #
