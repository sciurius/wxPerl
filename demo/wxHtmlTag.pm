#############################################################################
## Name:        demo/wxHtmlTag.pm
## Purpose:     wxHtmlWindow custom tags demo
## Author:      Mattia Barbon
## Modified by:
## Created:     20/12/2003
## RCS-ID:      $Id: wxHtmlTag.pm,v 1.2 2004/12/21 21:12:46 mbarbon Exp $
## Copyright:   (c) 2003-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package HtmlTagDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = HtmlTagDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::HtmlTagHandler</title>
</head>
<body>
<h3>Wx::HtmlTagHandler</h3>

</body>
</html>
EOT
}

package MyHtmlTagHandler;

use base 'Wx::PlHtmlTagHandler';
use Wx::Calendar;

sub new {
  my $class = shift;
  my $this = $class->SUPER::new;

  return $this;
}

sub GetSupportedTags {
  return 'WXPERLCTRL';
}

sub HandleTag {
  my( $this, $htmltag ) = @_;
  my $parser = $this->GetParser;
  my $htmlwin = $parser->GetWindow;
  my $calendar = Wx::CalendarCtrl->new( $htmlwin, -1 );
  my $cell = Wx::HtmlWidgetCell->new( $calendar );
  my $cnt = $parser->GetContainer;
  $cnt->InsertCell( $cell );

  return 1;
}

package HtmlTagDemoWin;

use base 'Wx::HtmlWindow';

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  $this->GetParser->AddTagHandler( MyHtmlTagHandler->new );
  $this->SetPage( <<EOT );
<html>
<head><title>Title</title></head>
<body>
  <h1>Heading</h1>

  <wxperlctrl />

Some text
</body>
</html>
EOT

  return $this;
}

1;

# local variables:
# mode: cperl
# end:
