#############################################################################
## Name:        wxSTC.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     23/ 5/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package STCDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = STCDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
EOT
}

package STCDemoWin;

use base qw(Wx::Panel);
use Wx::STC;
use Wx qw(:stc);

use Wx qw(wxDefaultPosition wxDefaultSize);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $s1 = Wx::StyledTextCtrl->new( $this, -1, [0, 0], [200, 100] );
  my $s2 = Wx::StyledTextCtrl->new( $this, -1, [0, 120], [200, 100] );

  $s1->SetLexer( wxSTC_LEX_PERL );
  $s2->SetLexer( wxSTC_LEX_XML );

  $s2->StyleSetSpec( wxSTC_H_TAG, "fore:#0000ff" );

  $s1->AddText( <<'EOT' );
package Foo;

sub bar {
  my $x = 1;
  my $y = 2;
}

print 12, "\n";
bar();
EOT

  $s2->AddText( <<'EOT' );
<?xml version="1.0" ?>
<aaa lang="mine">
  <xxx>Foo Bar</xxx>
</aaa>
EOT

  return $this;
}

1;

# Local variables: #
# mode: cperl #
# End: #
