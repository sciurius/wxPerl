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

use Wx qw(:sizer wxDefaultPosition wxDefaultSize);
use Wx::Event qw(EVT_CALENDAR_SEL_CHANGED);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );
  #                                    8 Jan 1979

  my $sizer = Wx::BoxSizer->new( wxVERTICAL );

  my $date = Wx::DateTime->newFromDMY( 8, 0, 1979 );

  my $calendar = Wx::CalendarCtrl->new( $this, -1, $date );

  my $textctrl = Wx::TextCtrl->new( $this, -1, $date->FormatDate );

  $sizer->Add( $calendar, 0, wxALL, 10 );
  $sizer->Add( $textctrl, 0, wxGROW|wxALL, 10 );

  $calendar->EnableYearChange;
  $calendar->EnableMonthChange;

  EVT_CALENDAR_SEL_CHANGED( $this, $calendar,
                            sub {
                              my( $self, $event ) = @_;

                              $textctrl->SetValue
                                ( $event->GetDate->FormatDate );
                            } );

  $this->SetSizer( $sizer );

  return $this;
}

1;

# local variables:
# mode: cperl
# end:
