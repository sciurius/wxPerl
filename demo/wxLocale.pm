#############################################################################
## Name:        wxLocale.pm
## Purpose:     wxLocale demo
## Author:      Mattia Barbon
## Modified by:
## Created:     12/ 9/2001
## RCS-ID:      
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package LocaleDemo;

use strict;
use Wx qw(wxID_OK);
use Wx::Locale qw(:default);

my $locale;

my( @locales ) =
  ( [ gettext_noop( "English" ), 'en', 'en' ],
    [ gettext_noop( "French" ), 'fr', 'fr' ],
    [ gettext_noop( "Italian" ), 'it', 'it' ],
  );

sub init_locale {
  # Wx::Locale needs to be deleted, first
  undef $locale;

  $locale = new Wx::Locale( @_ );
  $locale->AddCatalogLookupPathPrefix( main::filename( 'data/locale' ) );
  $locale->AddCatalog( 'wxperl_demo' );
}

sub choose_locale {
  my $dialog = new Wx::SingleChoiceDialog
    ( undef, gettext( "Choose a language" ), gettext( "Choose a language" ),
      [ map { Wx::GetTranslation( ${$_}[0] ) } @locales ] );

  if( $dialog->ShowModal() == wxID_OK ) {
    init_locale( @{$locales[ $dialog->GetSelection ]} );
  }

  $dialog->Destroy;
}

sub window {
  shift;
  my $parent = shift;

  my $panel = new MyPanel( $parent, -1 );

  return $panel;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::Locale</title>
</head>
<body>
<h3>Wx::Locale</h3>

<p>
  The first step in internationalization is message translation.
  wxWindows, and hence wxPerl uses the GNU gettext approach, and message
  catalogs are compatible with the gettext ones.
</p>

</body>
</html>
EOT
}

package MyPanel;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Panel);

use Wx qw(wxDefaultPosition wxDefaultSize wxBLACK);
use Wx::Locale gettext => 'gettext',
               gettext_noop => 'gettext_noop';

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_, [0,0] );

  $this->SetBackgroundColour( wxBLACK );
  my $subpanel = $this->{CHILD} = new Wx::Panel( $this, -1, [0,0], [600,500] );
  _create_windows( $this, $subpanel );

  return $this;
}

sub OnChangeLanguage {
  my $this = shift;

  LocaleDemo::choose_locale( );

  $this->{CHILD}->Destroy;
  my $subpanel = $this->{CHILD} = new Wx::Panel( $this, -1, [0,0], [500,500] );
  _create_windows( $this, $subpanel );

  return $this;
}

use Wx::Event qw(EVT_BUTTON);

sub _create_windows {
  my( $this, $panel ) = @_;

  my $label = new Wx::StaticText( $panel, -1, gettext( "Some text" ),
                                  [ 20, 20 ], [ 150, 30 ] );
  my $button1 = new Wx::Button( $panel, -1, gettext( "A button" ),
                               [ 20, 60 ], [ 150, 30 ] );
  my $button2 = new Wx::Button( $panel, -1, gettext( "Change the language" ),
                                [ 180, 60 ], [ 150, 30 ] );
  my $text = gettext( "The message catalogs for this\nexample were translated\nusing poEdit ( http://www.volny.cz/vaclav.slavik/ )" );
  my $text2 = gettext( "When dealing with internationalization/localization,\nwhich involves variable width text,\nthe best choice is to use Sizers ( see documentation );\nthis example does not use them to\nkeep it as simple as possible" );
  my $description = new Wx::StaticText( $panel, -1, $text . "\n\n" . $text2,
                                        [ 20, 120 ], [ 400, 200 ] );

  EVT_BUTTON( $this, $button2, \&OnChangeLanguage );
}

1;

# Local variables: #
# mode: cperl #
# End: #

