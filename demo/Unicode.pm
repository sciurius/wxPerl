#############################################################################
## Name:        demo/Unicode.pm
## Purpose:     Unicode support demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/09/2001
## RCS-ID:      $Id: Unicode.pm,v 1.2 2004/02/28 22:59:06 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package UnicodeDemo;

use Wx qw(:textctrl wxDefaultPosition wxDefaultSize);

sub window {
  shift;

  my $parent = shift;
  my $t = Wx::TextCtrl->new( $parent, -1, '', wxDefaultPosition,
                             wxDefaultSize, wxTE_MULTILINE );

  $t->SetValue( <<EOT );
This line contains only ASCII chars.

The following line contains a literal a-grave-accent ( Latin 1 ),
you should see some other letter if you use another code page; "à"

Here is another a-grave-accent, but in Unicode, so it should
look right with any encoding "\x{00c0}".

EOT

  $t->AppendText( "More ASCII\n" );
  $t->AppendText( "More Latin-1 \"è\" \"ç\"\n" );
  $t->AppendText( "More Unicode \"\x{0110}\" \"\x{01ff}\"\n" );

  return $t;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Unicode</title>
</head>
<body>
<h3>Unicode</h3>

<p>
  Unicode is a standard for written text encdfing, much like ASCII, or
  the various Copepage systems ( Latin-x, and such ); the main difference
  is taht it uses 16 ( or even 32 ) bits to encode each character, so it
  permits to use 65536 ( or 4294967296 ) characters at once.
  More informations are available on
  <a href="http://www.unicode.org">http://www.unicode.org/</a>.
</p>

<p>
  On the platforms where Unicode is supported ( cuttently only
  Windows NT/2000 ) with Perl 5.6.0 or higher, wxPerl can be compiled
  against an Unicode-enabled wxWidgets.
</p>

</body>
</html>
EOT
}

1;

# Local variables: #
# mode: cperl #
# End: #

