#############################################################################
## Name:        wxSTC.pm
## Purpose:     wxPerl demo helper
## Author:      Marcus Friedlaender and Mattia Barbon
## Created:     23/ 5/2002
## RCS-ID:
## Copyright:   (c) 2002 Marcus Friedlaender and Mattia Barbon
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
<html>
<head>
  <title>Wx::StyledTextCtrl</title>
</head>
<body>
<h3>Wx::StyledTextCtrl</h3>

<p>
  Wx::StyledTextCtrl is based upon the scintilla text editor. It provides
  a text editor with syntax highlighting, and the ability to syntax jighlight
  various programming languages.
</p>

</body>
</html>
EOT
}

package STCDemoWin;

use base qw(Wx::Panel);
use Wx::STC;
use Wx qw(:stc);

use Wx qw(wxDefaultPosition wxDefaultSize wxDEFAULT wxNORMAL);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $s1 = Wx::StyledTextCtrl->new( $this, -1, [0, 0], [300, 150] );
  my $s2 = Wx::StyledTextCtrl->new( $this, -1, [0, 170], [300, 150] );

  my $font = Wx::Font->new( 12, wxDEFAULT, wxNORMAL, wxNORMAL,0, "Arial");

  $s1->StyleSetFont(wxSTC_STYLE_DEFAULT, $font);
  $s1->StyleClearAll();

  $s2->StyleSetFont(wxSTC_STYLE_DEFAULT, $font);
  $s2->StyleClearAll();

  $s1->StyleSetForeground(0, Wx::Colour->new(0x00, 0x00, 0x7f));
  $s1->StyleSetForeground(1,  Wx::Colour->new(0xff, 0x00, 0x00));

  # 2 Comment line green
  $s1->StyleSetForeground(2,  Wx::Colour->new(0x00, 0x7f, 0x00));
  $s1->StyleSetForeground(3,  Wx::Colour->new(0x7f, 0x7f, 0x7f));

  # 4 numbers
  $s1->StyleSetForeground(4,  Wx::Colour->new(0x00, 0x7f, 0x7f));
  $s1->StyleSetForeground(5,  Wx::Colour->new(0x00, 0x00, 0x7f));

  # 6 string orange
  $s1->StyleSetForeground(6,  Wx::Colour->new(0xff, 0x7f, 0x00));

  $s1->StyleSetForeground(7,  Wx::Colour->new(0x7f, 0x00, 0x7f));

  $s1->StyleSetForeground(8,  Wx::Colour->new(0x00, 0x00, 0x00));

  $s1->StyleSetForeground(9,  Wx::Colour->new(0x7f, 0x7f, 0x7f));

  # 10 operators dark blue
  $s1->StyleSetForeground(10, Wx::Colour->new(0x00, 0x00, 0x7f));

  # 11 identifiers bright blue
  $s1->StyleSetForeground(11, Wx::Colour->new(0x00, 0x00, 0xff));

  # 12 scalars purple
  $s1->StyleSetForeground(12, Wx::Colour->new(0x7f, 0x00, 0x7f));

  # 13 array light blue
  $s1->StyleSetForeground(13, Wx::Colour->new(0x40, 0x80, 0xff));

  # 17 matching regex red
  $s1->StyleSetForeground(17, Wx::Colour->new(0xff, 0x00, 0x7f));

  # 18 substitution regex light olive
  $s1->StyleSetForeground(18, Wx::Colour->new(0x7f, 0x7f, 0x00));

  #Set a style 12 bold
  $s1->StyleSetBold(12,  1);

  # Add new keyword. Not sure about applying style yet. This is currently dark blue, style 10?
  $s1->SetKeyWords(0,"wxPerl_rocks");

  # Apply tag style for selected lexer (blue)
  $s1->StyleSetSpec( wxSTC_H_TAG, "fore:#0000ff" );
  $s2->StyleSetSpec( wxSTC_H_TAG, "fore:#0000ff" );

  # Set Lexers to use
  $s1->SetLexer( wxSTC_LEX_PERL );
  $s2->SetLexer( wxSTC_LEX_XML );

  $s1->AddText( <<'EOT' );
# Comment
package Foo;

sub bar {
  my $x = 1;
  my $y = 2;
  my @arr = (3,4,5);
}
print 12, "\n";

my $match =~ m/^bla/;

my $subst =~ s/bla/foo/gi;

wxPerl_rocks is a custom keyword.

bar();
EOT

  $s2->AddText( <<'EOT' );
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional">
<HTML><HEAD><TITLE>Prima</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</HEAD>
<BODY BGCOLOR="#FFFF99">

<!-- Start table -->
<P>Bla</P><BR><A HREF="http://wordit.com">wordit</A>
</BODY>
</HTML>
EOT


  # $s3->AddText( <<'EOT' );
  # <?xml version="1.0" ?>
  # <aaa lang="mine">
  #   <xxx>Foo Bar</xxx>
  # </aaa>
  # EOT

  # my $lexer = $s2->GetLexer();
  # print "lexer:$lexer\n";

  return $this;
}

1;

# Local variables: #
# mode: cperl #
# End: #
