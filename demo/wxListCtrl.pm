#############################################################################
## Name:        demo/wxListCtrl.pm
## Purpose:     wxerl demo helper
## Author:      Mattia Barbon
## Modified by:
## Created:     12/09/2001
## RCS-ID:      $Id: wxListCtrl.pm,v 1.7 2004/12/21 21:12:46 mbarbon Exp $
## Copyright:   (c) 2001, 2003-2004 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package ListCtrlDemo;

sub window {
  shift;
  my $parent = shift;

  my $window = ListCtrlDemoWin->new( $parent );

  return $window;
}

sub description {
  return <<EOT;
<html>
<head>
  <title>Wx::ListCtrl</title>
</head>
<body>
<h3>Wx::ListCtrl</h3>

<p>
  Wx::ListCtrl has a variety of uses.
</p>

<ul>
  <li>Report mode: display data in a grid-like way</li>
  <li>Icon mode: show icons with or without a abel</li>
</ul>

</body>
</html>
EOT
}

package ListCtrlDemoWin;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::Panel);
use Wx qw(:sizer :listctrl :icon wxTheApp);
use Wx::Event qw)EVT_BUTTON);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( $_[0], -1 );

  my $top_s = $this->{SIZER} = Wx::BoxSizer->new( wxVERTICAL );

  my $but_s = Wx::BoxSizer->new( wxHORIZONTAL );
  my $report = Wx::Button->new( $this, -1, 'Report' );
  my $icon = Wx::Button->new( $this, -1, 'Icon' );

  #
  # virtual list controls only supported under wxWidgets 2.3.2
  #
  my $virtual;
  $virtual = Wx::Button->new( $this, -1, 'Virtual' );

  $but_s->Add( $report, 0, wxALL, 5 );
  $but_s->Add( $icon, 0, wxALL, 5 );
  $but_s->Add( $virtual, 0, wxALL, 5 ) if $virtual;

  EVT_BUTTON( $this, $report, MakeEvtHandler( \&CreateReportControl ) );
  EVT_BUTTON( $this, $icon, MakeEvtHandler( \&CreateIconControl ) );
  EVT_BUTTON( $this, $virtual, MakeEvtHandler( \&CreateVirtualControl ) )
    if $virtual;

  $top_s->Add( $but_s, 0, wxALL, 5 );

  # image lists need to be kept somewhere, otherwise
  # refcount drops to zero -> imagelist is destroyed...
  my $images_sm = Wx::ImageList->new( 16, 16, 1 );
  my $images_no = Wx::ImageList->new( 32, 32, 1 );

  $images_sm->Add( Wx::GetWxPerlIcon( 1 ) );

  $images_no->Add( Wx::GetWxPerlIcon() );
  $images_no->Add( wxTheApp->GetStdIcon( wxICON_HAND ) );
  $images_no->Add( wxTheApp->GetStdIcon( wxICON_EXCLAMATION ) );
  $images_no->Add( wxTheApp->GetStdIcon( wxICON_ERROR ) );
  $images_no->Add( wxTheApp->GetStdIcon( wxICON_QUESTION ) );

  $this->{SMALLIMAGES} = $images_sm;
  $this->{NORMALIMAGES} = $images_no;

  $this->CreateReportControl();

  $this->SetSizer( $top_s );
  $this->SetAutoLayout( 1 );

  return $this;
}

sub MakeEvtHandler {
  my $createfun = shift;

  return sub {
    my( $this, $event ) = @_;

    $this->sizer->Remove( 0 );
    $this->list->Destroy();
    $this->$createfun();
    $this->Layout();
  }
}

sub list { $_[0]->{LIST} }
sub sizer { $_[0]->{SIZER} }

use Wx qw(wxDefaultPosition wxDefaultSize);

sub CreateReportControl {
  my $this = shift;
  my $list = Wx::ListCtrl->new( $this, -1, wxDefaultPosition, wxDefaultSize,
                                wxLC_REPORT );
  my $sizer = $this->sizer;

  my @names = ( "Cheese", "Apples", "Oranges" );

  $list->SetImageList( $this->{SMALLIMAGES}, wxIMAGE_LIST_SMALL );
  $list->SetImageList( $this->{NORMALIMAGES}, wxIMAGE_LIST_NORMAL );

  $list->InsertColumn( 1, "Type" );
  $list->InsertColumn( 2, "Amount" );
  $list->InsertColumn( 3, "Price" );

  foreach my $i ( 0 .. 50 ) {
    my $t = ( rand() * 100 ) % 3;
    my $q = int( rand() * 100 );
    my $idx = $list->InsertImageStringItem( $i, $names[$t], 0 );
    $list->SetItem( $idx, 1, $q );
    $list->SetItem( $idx, 2, $q * ( $t + 1 ) );
  }

  $sizer->Prepend( $list, 1, wxGROW|wxALL, 5 );
  $this->{LIST} = $list;
}

sub CreateIconControl {
  my $this = shift;
  my $list = Wx::ListCtrl->new( $this, -1, wxDefaultPosition, wxDefaultSize,
                                wxLC_ICON );
  my $sizer = $this->sizer;

  $list->SetImageList( $this->{SMALLIMAGES}, wxIMAGE_LIST_SMALL );
  $list->SetImageList( $this->{NORMALIMAGES}, wxIMAGE_LIST_NORMAL );

  foreach my $i ( 0 .. 7 ) {
    my $idx = $list->InsertStringImageItem( $i, "Item $i", $i % 5 );
  }

  $sizer->Prepend( $list, 1, wxGROW|wxALL, 5 );
  $this->{LIST} = $list;
}

sub CreateVirtualControl {
  my $this = shift;
  my $list = MyListCtrl->new( $this, -1 );
  my $sizer = $this->sizer;

  $sizer->Prepend( $list, 1, wxGROW|wxALL, 5 );
  $this->{LIST} = $list;
}

#
# this is used only if compiled with wxWidgets 2.3.2
#

package MyListCtrl;

use strict;
use vars qw(@ISA); @ISA = qw(Wx::ListCtrl);
use Wx qw(wxDefaultPosition wxDefaultSize);
use Wx qw(:listctrl wxRED wxBLUE wxITALIC_FONT);

sub new {
  my $class = shift;
  my $this = $class->SUPER::new( @_, wxDefaultPosition, wxDefaultSize,
                                 wxLC_REPORT|wxLC_VIRTUAL );

  $this->InsertColumn( 1, "Column 1" );
  $this->InsertColumn( 2, "Column 2" );
  $this->InsertColumn( 3, "Column 3" );
  $this->InsertColumn( 4, "Column 4" );
  $this->InsertColumn( 5, "Column 5" );
  $this->SetItemCount( 100000 );

  return $this;
}

sub OnGetItemText {
  my( $this, $item, $column ) = @_;

  return "( $item, $column )";
}

sub OnGetItemAttr {
  my( $this, $item ) = @_;

  my $attr = Wx::ListItemAttr->new;

  if( $item % 2 == 0 ) { $attr->SetTextColour( wxRED ) }
  if( $item % 3 == 0 ) { $attr->SetBackgroundColour( wxBLUE ) }
  if( $item % 5 == 0 ) { $attr->SetFont( wxITALIC_FONT ) }

  return $attr;
}

sub OnGetItemImage {
  return 0;
}

1;

# Local variables: #
# mode: cperl #
# End: #

