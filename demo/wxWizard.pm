#############################################################################
## Name:        wxWizard.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     28/ 8/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package WizardDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = WizardDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::Wizard</title>
</head>
<body>
<h3>Wx::Wizard</h3>

</body>
</html>
EOT
}

package WizardDemoWin;

use base qw(Wx::Panel);

use Wx qw(wxDefaultPosition wxDefaultSize);
use Wx::Event qw(EVT_WIZARD_PAGE_CHANGED EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $button = Wx::Button->new( $this, -1, "Start wizard" );
  my $wizard = Wx::Wizard->new( $this, -1, "Wizard test" );

  # first page
  my $page1 = Wx::WizardPageSimple->new( $wizard );
  Wx::TextCtrl->new( $page1, -1, "First page" );

  # second page
  my $page2 = Wx::WizardPageSimple->new( $wizard );
  Wx::TextCtrl->new( $page2, -1, "Second page" );

  Wx::WizardPageSimple::Chain( $page1, $page2 );

  EVT_WIZARD_PAGE_CHANGED( $this, $wizard, sub {
                             Wx::LogMessage( "Wizard page changed" );
                           } );

  EVT_BUTTON( $this, $button, sub {
                $wizard->RunWizard( $page1 );
              } );

  return $this;
}

sub OnCheck {
  my( $this, $event ) = @_;

  Wx::LogMessage( "Element %d toggled to %s", $event->GetInt(),
                  ( $this->IsChecked( $event->GetInt() ) ? 'checked' : 'unchecked' ) );
}

1;

# local variables:
# mode: cperl
# end:
