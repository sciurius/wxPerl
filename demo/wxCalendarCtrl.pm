#############################################################################
## Name:        wxCalendarCtrl.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     11/10/2002
## RCS-ID:      
## Copyright:   (c) 2002 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package CalendarCtrlDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = CalendarCtrlDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::CalendarCtrl</title>
</head>
<body>
<h3>Wx::CalendarCtrl</h3>

</body>
</html>
EOT
}

package CalendarCtrlDemoWin;

use base 'Wx::Panel';
use Wx::Calendar;

use Wx qw(wxDefaultPosition wxDefaultSize);
#use Wx::Event qw(EVT_WIZARD_PAGE_CHANGED EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );
  #                                    8 Jan 1979
  my $date = Wx::DateTime->newFromDMY( 8, 0, 1979 );

  my $calendar = Wx::CalendarCtrl->new( $this, -1, $date, [ 50, 50 ] );
  $calendar->EnableYearChange;
  $calendar->EnableMonthChange;

  return $this;
}

1;

# local variables:
# mode: cperl
# end:
