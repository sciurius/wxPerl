#############################################################################
## Name:        XRC.pm
## Purpose:     wxWindows' XML Resources demo
## Author:      Mattia Barbon
## Created:     25/08/2003
## RCS-ID:      $Id: XRCCustom.pm,v 1.1 2003/07/25 20:36:10 mbarbon Exp $
## Copyright:   (c) 2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::XRC;
use Wx::FS;

package XRCCustom;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $panel = XRCCustomDemoWin->new($parent);

  return $panel;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::PlXmlResourceHandler</title>
</head>
<body>
<h3>Wx::PlXmlResourceHandler</h3>

<p>
Wx::PlXmlResourceHandler allows using custom controls inside XRC.
For example, Wx::Perl::TreeChecker and Wx::ActiveX are not understood
out-of-the-box by wxXRC. Using Wx::PlXmlResourceHandler they can be used
as any other wxWindows control.
</p>

</body>
</html>
EOT
}

1;

# since this is just a simple example, we use a trivial
# control derived from Wx::Statictext; more complex controls
# are of course possible
package HelloWorldCtrl;

use strict;
use base 'Wx::StaticText';

sub new {
  my $class = shift;
  my( $parent, $id, $colour, $pos, $size, $style, $name ) = @_;

  $colour ||= $parent->GetBackgroundColour;

  my $self = $class->SUPER::new( $parent, $id, 'Hello, world!', $pos, $size,
                                 $style, $name );

  $self->SetBackgroundColour( $colour );

  return $self;
}

package CustomXmlHandler;

use strict;
use base 'Wx::PlXmlResourceHandler';

# this methods must return TRUE if the handler can handle
# the given XML node
sub CanHandle {
    my( $self, $xmlnode ) = @_;
    return $self->IsOfClass( $xmlnode, 'HelloWorld' );
}

# this method is where the actual creation takes place
sub DoCreateResource {
    my( $self ) = shift;

    # this is the case when the user called LoadOnXXX, to load
    # an already created object. We could handle this case as well,
    # (just calling ->Create instead of ->new), but that would
    # just complicate the code
    die 'LoadOnXXX not supported by this handler' if $self->GetInstance;

    my $ctrl = HelloWorldCtrl->new( $self->GetParentAsWindow,
                                    $self->GetID,
                                    $self->GetColour( 'colour' ),
                                    $self->GetPosition,
                                    $self->GetSize,
                                    $self->GetStyle( "style", 0 ),
                                    $self->GetName );

    $self->SetupWindow( $ctrl );
    $self->CreateChildren( $ctrl );

    return $ctrl;
}

package XRCCustomDemoWin;

use strict;
use base qw(Wx::Panel);
use Wx qw(wxDefaultPosition wxDefaultSize wxVERSION_STRING
          wxOK wxICON_INFORMATION wxPOINT wxSIZE);

sub new {
  my $class = shift;
  my $self = $class->SUPER::new( $_[0] );

  Wx::MemoryFSHandler::AddTextFile( 'sample.xrc', <<EOT );
<?xml version="1.0" encoding="utf-8"?>
<resource>
  <object class="wxPanel" name="MyPanel">
    <object class="HelloWorld">
      <colour>#ffffff</colour>
      <pos>20, 20</pos>
      <size>100, 20</size>
    </object>
    <object class="HelloWorld">
      <colour>#ff0000</colour>
      <pos>20, 60</pos>
      <size>200, 50</size>
    </object>
    <size>300, 300</size>
  </object>
</resource>
EOT

  my $res = Wx::XmlResource->new;
  Wx::FileSystem::AddHandler( Wx::MemoryFSHandler->new );

  $res->InitAllHandlers();
  $res->AddHandler( CustomXmlHandler->new );
  $res->Load( 'memory:sample.xrc' );

  my $panel = $res->LoadPanel( $self, 'MyPanel' );

  return $self;
}

1;

# Local variables: #
# mode: cperl #
# End: #
