#############################################################################
## Name:        wxCheckListBox.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     13/ 3/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package CheckListBoxDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = CheckListBoxDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
EOT
}

package CheckListBoxDemoWin;

use base qw(Wx::CheckListBox);

use Wx qw(wxDefaultPosition wxDefaultSize);
use Wx::Event qw(EVT_CHECKLISTBOX);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1, wxDefaultPosition,
                                 wxDefaultSize,
                                 [ qw(one two three four five size seven
                                      eight nine ten) ] );

  foreach my $i ( 0 .. 9 ) { $this->Check( $i, $i & 1 ) }

  EVT_CHECKLISTBOX( $this, $this, \&OnCheck );

  return $this;
}

sub OnCheck {
  my( $this, $event ) = @_;

  Wx::LogMessage( "Element %d toggled to %s", $event->GetInt(),
                  ( $this->IsChecked( $event->GetInt() ) ? 'checked' : 'unchecked' ) );
}

1;

# Local variables: #
# mode: cperl #
# End: #
