#############################################################################
## Name:        demo/wxDatePickerCtrl.pm
## Purpose:     wxPerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     18/03/2005
## RCS-ID:      $Id: wxDatePickerCtrl.pm,v 1.3 2005/06/11 06:43:57 mbarbon Exp $
## Copyright:   (c) 2005 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package DatePickerCtrlDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = DatePickerCtrlDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::DatePickerCtrl</title>
</head>
<body>
<h3>Wx::DatePickerCtrl</h3>

</body>
</html>
EOT
}

package DatePickerCtrlDemoWin;

use base 'Wx::Panel';
use Wx::Calendar;

use Wx qw(:sizer :datepicker);
use Wx::Event qw(EVT_DATE_CHANGED);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $sizer = Wx::BoxSizer->new( wxVERTICAL );

  #                                    8 Jan 1979
  my $date = Wx::DateTime->newFromDMY( 8, 0, 1979, 1, 1, 1, 1 );

  my $calendar = Wx::DatePickerCtrl->new( $this, -1, $date );
  $calendar->SetRange( $date, Wx::DateTime->new );

  my $textctrl = Wx::TextCtrl->new( $this, -1, $date->FormatDate );

  $sizer->Add( $calendar, 0, wxALL, 10 );
  $sizer->Add( $textctrl, 0, wxGROW|wxALL, 10 );

  EVT_DATE_CHANGED( $this, $calendar,
                    sub {
                        $textctrl->SetValue
                          ( $_[1]->GetDate->FormatDate );
                    } );

  $this->SetSizer( $sizer );

  return $this;
}

1;

# local variables:
# mode: cperl
# end:
