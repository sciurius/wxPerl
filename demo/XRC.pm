#############################################################################
## Name:        demo/XRC.pm
## Purpose:     wxWidgets' XML Resources demo
## Author:      Mattia Barbon
## Modified by: Scott Lanning, 11/09/2002
## Created:     12/09/2001
## RCS-ID:      $Id: XRC.pm,v 1.4 2004/02/28 22:59:06 mbarbon Exp $
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx::XRC;

package XRC;

use strict;

sub window {
  shift;
  my $parent = shift;

  my $frame = XRCDemoWin->new($parent);
  $frame->Show(1);

  return;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::XmlResource</title>
</head>
<body>
<h3>Wx::XmlResource</h3>

<p>
The XML-based resource system, known as XRC, allows user interface
elements such as dialogs, menu bars and toolbars, to be stored in
text files and loaded into the application at run-time.
</p>

</body>
</html>
EOT
}

1;


package XRCDemoWin;

use strict;
use base qw(Wx::Frame);
use Wx qw(wxDefaultPosition wxDefaultSize wxVERSION_STRING
          wxOK wxICON_INFORMATION wxPOINT wxSIZE);
use Wx::Event qw(EVT_MENU);

sub new {
    my $class = shift;
    my ($self, $toolbar, $menubar);

    $self = $class->SUPER::new(
        undef, -1, 'XML resources demo', wxPOINT(50, 50), wxSIZE(450, 340)
    );
    $self->SetAutoLayout(1);

    Wx::Image::AddHandler(Wx::GIFHandler->new());

    $self->{'xr'} = Wx::XmlResource->new();
    $self->{'xr'}->InitAllHandlers();
    $self->{'xr'}->Load(main::filename('data/resource.xrc'));

    $menubar = $self->{'xr'}->LoadMenuBar('mainmenu');
    $self->SetMenuBar($menubar);

    $toolbar = $self->{'xr'}->LoadToolBar($self, 'toolbar');
    $self->SetToolBar($toolbar);

    EVT_MENU($self, Wx::XmlResource::GetXRCID('menu_quit'), \&OnQuit);
    EVT_MENU($self, Wx::XmlResource::GetXRCID('menu_about'), \&OnAbout);
    EVT_MENU($self, Wx::XmlResource::GetXRCID('menu_dlg1'), \&OnDlg1);
    EVT_MENU($self, Wx::XmlResource::GetXRCID('menu_dlg2'), \&OnDlg2);

    return $self;
}

sub OnAbout {
    my ($self, $event) = @_;
    my ($text, $title);

    $text = "This is the about dialog of the XML resources demo.\n"
        . "Welcome to wxPerl $Wx::VERSION (" . wxVERSION_STRING . ').';

    $title = 'About XML resources demo';

    Wx::MessageBox($text, $title, wxOK|wxICON_INFORMATION, $self);
}

sub OnQuit {
    my ($self, $event) = @_;
    $self->Close(1);
}

sub OnDlg1 {
    my ($self, $event) = @_;
    my $dialog = $self->{'xr'}->LoadDialog($self, 'dlg1');
    $dialog->ShowModal();
}

sub OnDlg2 {
    my ($self, $event) = @_;
    my $dialog = $self->{'xr'}->LoadDialog($self, 'dlg2');
    $dialog->ShowModal();
}

1;

# Local variables: #
# mode: cperl #
# End: #
