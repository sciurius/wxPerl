#!/usr/bin/perl
#############################################################################
## Name:        controls.pl
## Purpose:     Controls wxPerl sample
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use Wx;

# hack for wxMotif compatibility
if( $Wx::_platform == $Wx::_motif ) { 
  eval 'sub Wx::Window::SetToolTip {}';
  eval 'sub Wx::ToolTip::new {}';
};

package MyApp;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::App);

use Wx qw(wxMENU_TEAROFF);

sub OnInit {
    my( $this ) = @_;

    my( $frame ) = MyFrame->new( undef, "Controls wxPerl app",
                                 50, 50, 540, 430 );

    my( $file_menu ) = Wx::Menu->new( '', wxMENU_TEAROFF );

    $file_menu->Append( 2, "&Clear log\tCtrl-L" );
    $file_menu->AppendSeparator();
    $file_menu->Append( 3, "&About\tF1" );
    $file_menu->AppendSeparator();
    $file_menu->Append( 4, "E&xit\tAlt-X", 'Quit controls sample' );

    my( $menu_bar ) = Wx::MenuBar->new();
    $menu_bar->Append( $file_menu, '&File' );

    my( $tooltip_menu ) = Wx::Menu->new();
    $tooltip_menu->Append( 5, "Set &delay\tCtrl-D" );
    $tooltip_menu->AppendSeparator();
    $tooltip_menu->Append( 6, "&Toggle tooltips\tCtrl-T",
                         'enable/disable tooltips', 1 );
    $tooltip_menu->Check( 6, 1 );
    $menu_bar->Append( $tooltip_menu, '&Tooltips' );

    my( $panel_menu ) = Wx::Menu->new();
    $panel_menu->Append( 7, "&Disable all\tCtrl-E",
                         'enable/disable all panel controls', 1 );
    $menu_bar->Append( $panel_menu, '&Panel' );

    $frame->SetMenuBar( $menu_bar );

    $frame->SetSizeHints( 500, 425 );

    $frame->Show( 1 );
    $this->SetTopWindow( $frame );

    1;
}

package MyPanel;

use strict;
use vars qw(@ISA);
use Wx qw(wxTE_MULTILINE wxLB_SORT wxLB_ALWAYS_SB wxCB_SORT
 wxBLUE wxCROSS_CURSOR wxCURSOR_HAND wxPROCESS_ENTER wxTE_PROCESS_ENTER
 wxBITMAP_TYPE_XPM wxBITMAP_TYPE_BMP
 wxNOT_FOUND wxITALIC_FONT wxDefaultSize wxRA_SPECIFY_COLS wxRA_SPECIFY_ROWS
 wxRB_GROUP);
use Wx::Event qw(EVT_SIZE EVT_LISTBOX EVT_LISTBOX_DCLICK EVT_CHECKBOX
EVT_BUTTON EVT_NOTEBOOK_PAGE_CHANGING EVT_NOTEBOOK_PAGE_CHANGED
EVT_CHOICE EVT_COMBOBOX EVT_TEXT EVT_TEXT_ENTER EVT_RADIOBOX);

@ISA = qw(Wx::Panel);

use vars qw($ID_LISTBOX $ID_LISTBOX_SORTED $ID_CHANGE_COLOUR);
use vars qw($ID_CHOICE $ID_CHOICE_SORTED $ID_BUTTON_TEST1 $ID_BUTTON_TEST2);

( $ID_LISTBOX, $ID_LISTBOX_SORTED, $ID_CHANGE_COLOUR, $ID_CHOICE,
  $ID_CHOICE_SORTED, $ID_BUTTON_TEST1, $ID_BUTTON_TEST2 ) = ( 100 .. 120 );

sub BITMAP {
  if( $Wx::_platform == $Wx::_msw ) {
    Wx::Bitmap->new( "icons/$_[0].bmp", wxBITMAP_TYPE_BMP );
  } else {
    Wx::Bitmap->new( "icons/$_[0].xpm", wxBITMAP_TYPE_XPM );
  }
}

sub SetControlClientData {
  my( $name, $ctrl ) = @_;
  my( $text );

  foreach my $i ( 1 .. $ctrl->GetCount() ) {
    $text = $ctrl->GetString( $i-1 );

    $ctrl->SetClientData( $i-1,
                          my( $a ) = "$name client data for $text"
                        );
  }
}

#sub DESTROY {
#  my( $this ) = shift;
#
#  Wx::Log::SetActiveTarget( delete $this->{OLDLOG} );
#}

sub new {
    my( $class, $frame, $x, $y, $w, $h ) = @_;
    my( $this ) = $class->SUPER::new( $frame, -1, [$x, $y], [$w, $h] );
    $this->{TEXT} = Wx::TextCtrl->new( $this, -1, "This is the log Window.\n",
                                       [0, 250], [100, 50], wxTE_MULTILINE );
    $this->{TEXT}->SetBackgroundColour( Wx::Colour->new( "wheat" ) );
    $this->{OLDLOG} =
      Wx::Log::SetActiveTarget( Wx::LogTextCtrl->new( $this->{TEXT} ) );

    $this->{NOTEBOOK} = Wx::Notebook->new( $this , -1 );

    #
    # ImageList
    #
    my( $imagelist ) = $this->{IMAGELIST} = Wx::ImageList->new( 16, 16, 0 );

    foreach ( qw(list choice combo radio gauge text) ) {
      $imagelist->Add( BITMAP( $_ ) );
    }

    $this->{NOTEBOOK}->SetImageList( $imagelist );

    my( $choices ) = [ 'This', 'is one of my',
                       'really', 'wonderful', 'examples', ];
    #
    # Wx::ListBox
    #
    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );

    $this->{NOTEBOOK}->AddPage( $panel, "Wx::ListBox", 1, 0 );
    $panel->SetCursor( Wx::Cursor->new( wxCURSOR_HAND ) );

    $this->{LISTBOX} = Wx::ListBox->new( $panel, $ID_LISTBOX, [10, 10],
                                         [120, 70], $choices, wxLB_ALWAYS_SB );
    $this->{LISTBOXSORTED} = Wx::ListBox->new( $panel, $ID_LISTBOX_SORTED,
                                               [10, 90], [120, 70],
                                               $choices, wxLB_SORT );
    $this->{LISTBOX}->SetCursor( wxCROSS_CURSOR );
    $this->{LISTBOX}->SetToolTip( "This is a list box" );

    SetControlClientData( 'listbox', $this->{LISTBOX} );
    SetControlClientData( 'listbox', $this->{LISTBOXSORTED} );

    $this->{LBSELECTNUM} = Wx::Button->new( $panel, -1, 'Select #&2',
                                            [180, 30], [140, 30] );
    $this->{LBSELECTTHIS} = Wx::Button->new( $panel, -1, '&Select \'This\'',
                                             [340, 30], [140, 30] );
    my( $b1 ) = Wx::Button->new( $panel, -1, '&Clear', [180, 80], [140, 30] );
    my( $b2) = MyButton->new( $panel, -1, '&Append \'Hi!\'', [340, 80 ], [140, 30] );
    my( $b3 ) = Wx::Button->new( $panel, -1, 'D&elete selected item',
                                 [180, 130], [140, 30] );
    my( $button ) = MyButton->new( $panel, -1, 'Set &Italic font',
                                   [340, 130], [140, 30] );
    $button->SetDefault();
    $button->SetForegroundColour( wxBLUE );
    $button->SetToolTip( "Press here to set Italic font" );

    $this->{CHECKBOX} = Wx::CheckBox->new( $panel, -1, '&Disable', [20, 170] );
    $this->{CHECKBOX}->SetValue( 0 );
    $this->{CHECKBOX}->SetToolTip( "Click here to disable the listbox" );

    my( $cb ) = Wx::CheckBox->new( $panel, $ID_CHANGE_COLOUR, '&Toggle colour',
                                   [100, 170] );
    EVT_LISTBOX( $this, $this->{LISTBOX}, \&OnListBox );
    EVT_LISTBOX( $this, $this->{LISTBOXSORTED}, \&OnListBox );
    EVT_LISTBOX_DCLICK( $this, $this->{LISTBOX}, \&OnListBoxDoubleClick );
    EVT_CHECKBOX( $this, $this->{CHECKBOX}, \&OnListBoxButtons_Enable );
    EVT_CHECKBOX( $this, $cb, \&OnChangeColour );
    EVT_BUTTON( $this, $this->{LBSELECTNUM}, \&OnListBoxButtons_SelNum );
    EVT_BUTTON( $this, $this->{LBSELECTTHIS}, \&OnListBoxButtons_SelStr );
    EVT_BUTTON( $this, $b1, \&OnListBoxButtons_Clear );
    EVT_BUTTON( $this, $b2, \&OnListBoxButtons_Append );
    EVT_BUTTON( $this, $b3, \&OnListBoxButtons_Delete );
    EVT_BUTTON( $this, $button, \&OnListBoxButtons_Font );

    #
    # Wx::Choice
    #
    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );

    $this->{NOTEBOOK}->AddPage( $panel, "Wx::Choice", 0, 1 );
    $this->{CHOICE} = Wx::Choice->new( $panel, $ID_CHOICE, [10, 10],
                                       [120, -1], $choices );
    $this->{CHOICESORTED} = Wx::Choice->new( $panel, $ID_CHOICE_SORTED,
                                             [10, 70], [120, -1], $choices,
                                             wxCB_SORT );
    $this->{CHOICE}->SetSelection( 2 );
    $this->{CHOICE}->SetBackgroundColour( Wx::Colour->new( "red" ) );

    my( $b1 ) = Wx::Button->new( $panel, -1, 'Select #&2', [180, 30], [140, 30] );
    my( $b2 ) = Wx::Button->new( $panel, -1, '&Select \'This\'',
                                 [340, 30], [140, 30] );
    my( $b3 ) = Wx::Button->new( $panel, -1, '&Clear', [180, 80], [140, 30] );
    my( $b4 ) = Wx::Button->new( $panel, -1, '&Append \'Hi!\'',
                                 [340, 80], [140, 30] );
    my( $b5 ) = Wx::Button->new( $panel, -1, 'D&elete selected item',
                                 [180, 130], [140, 30] );
    my( $b6 ) = Wx::Button->new( $panel, -1, 'Set &Italic font',
                                 [340, 130], [140, 30] );
    my( $c1 ) = Wx::CheckBox->new( $panel, -1, "&Disable",
                                   [20, 130], [140, 130] );

    EVT_BUTTON( $this, $b1, \&OnChoiceButtons_SelNum );
    EVT_BUTTON( $this, $b2, \&OnChoiceButtons_SelStr );
    EVT_BUTTON( $this, $b3, \&OnChoiceButtons_Clear );
    EVT_BUTTON( $this, $b4, \&OnChoiceButtons_Append );
    EVT_BUTTON( $this, $b5, \&OnChoiceButtons_Delete );
    EVT_BUTTON( $this, $b6, \&OnChoiceButtons_Font );
    EVT_CHECKBOX( $this, $c1, \&OnChoiceButtons_Enable );
    EVT_CHOICE( $this, $this->{CHOICE}, \&OnChoice );
    EVT_CHOICE( $this, $this->{CHOICESORTED}, \&OnChoice );

    #
    # Wx::ComboBox
    #
    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );

    $this->{NOTEBOOK}->AddPage( $panel, "Wx::ComboBox", 0, 2 );
    Wx::StaticBox->new( $panel, -1, "&Box around combobox", [5, 5], [150, 100] );
    $this->{COMBO} = MyComboBox->new( $panel, -1, "This", [20, 25], [120, -1],
                                      $choices, wxTE_PROCESS_ENTER );
    $this->{COMBO}->SetToolTip( Wx::ToolTip->new( "This is a natural combobox\ncan you believe me?" ) );

    my( $b1 ) = Wx::Button->new( $panel, -1, 'Select #&2', [180, 30], [140, 30] );
    my( $b2 ) = Wx::Button->new( $panel, -1, '&Select \'This\'',
                                 [340, 30], [140, 30] );
    my( $b3 ) = Wx::Button->new( $panel, -1, '&Clear', [180, 80], [140, 30] );
    my( $b4 ) = Wx::Button->new( $panel, -1, '&Append \'Hi!\'', 
                                 [340, 80], [140, 30] );
    my( $b5 ) = Wx::Button->new( $panel, -1, 'D&elete selected item',
                                 [180, 130], [140, 30] );
    my( $b6 ) = Wx::Button->new( $panel, -1, 'Set &Italic font',
                                 [340, 130], [140, 30] );
    my( $c1 ) = Wx::CheckBox->new( $panel, -1, "&Disable",
                                   [20, 130], [140, 130] );

    EVT_BUTTON( $this, $b1, \&OnComboButtons_SelNum );
    EVT_BUTTON( $this, $b2, \&OnComboButtons_SelStr );
    EVT_BUTTON( $this, $b3, \&OnComboButtons_Clear );
    EVT_BUTTON( $this, $b4, \&OnComboButtons_Append );
    EVT_BUTTON( $this, $b5, \&OnComboButtons_Delete );
    EVT_BUTTON( $this, $b6, \&OnComboButtons_Font );
    EVT_CHECKBOX( $this, $c1, \&OnComboButtons_Enable );
    EVT_COMBOBOX( $this, $this->{COMBO}, \&OnCombo );
    EVT_TEXT( $this, $this->{COMBO}, \&OnComboTextChanged );
    EVT_TEXT_ENTER( $this, $this->{COMBO}, \&OnComboTextEnter );

    #
    # Wx::RadioBox
    #
    my( $choices2 ) = [ "First", 'second' ];
    my( $choices10 ) = [ "First", "Second", "Third", "Fourth", "Fifth",
                         "Sixth", "Seventh", "Eighth", "Nineth", "Tenth" ];

    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );
    $this->{NOTEBOOK}->AddPage( $panel, "Wx::RadioBox", 0, 3 );

    $this->{RADIO} = Wx::RadioBox->new( $panel, -1, "T&his", [10, 10],
                                        wxDefaultSize, $choices, 1,
                                        wxRA_SPECIFY_COLS );
    my( $rb1 ) = MyRadioBox->new( $panel, -1, "&That", [10, 160],
                                 wxDefaultSize, $choices2, 1,
                                 wxRA_SPECIFY_ROWS );
    my( $rb2 ) = Wx::RadioBox->new( $panel, -1, 
                                    "And another one wiyh very long title", 
                                    [165, 115], 
                                    wxDefaultSize, $choices10, 3, 
                                    wxRA_SPECIFY_COLS );
    $rb2->SetToolTip( "Ever seen a radiobox?" );

    my( $b1 ) = Wx::Button->new( $panel, -1, "Select #&2", [180, 30], [140, 30] );
    my( $b2 ) = Wx::Button->new( $panel, -1, "&Select 'This'",
                                 [180, 80], [140, 30] );
    $this->{FONTBUTTON} = Wx::Button->new( $panel, -1, "Set &more Italic font",
                                           [340, 30], [140, 30] );
    my( $b3 ) = Wx::Button->new( $panel, -1, "Set &Italic font",
                                 [340, 80], [140, 30] );
    my( $cb ) = Wx::CheckBox->new( $panel, -1, "&Disable",
                                   [400, 130], wxDefaultSize );
    my( $rb1 ) = Wx::RadioButton->new( $panel, -1, "Radio&1",
                                      [400, 170], wxDefaultSize, wxRB_GROUP );
    $rb1->SetValue( 1 );
    my( $rb2 ) = Wx::RadioButton->new( $panel, -1, "Radio&2",
                                       [460, 170], wxDefaultSize );
    EVT_CHECKBOX( $this, $cb, \&OnRadioButtons_Enable );
    EVT_BUTTON( $this, $b1, \&OnRadioButtons_SelNum );
    EVT_BUTTON( $this, $b2, \&OnRadioButtons_SelStr );
    EVT_BUTTON( $this, $b3, \&OnRadioButtons_Font );
    EVT_RADIOBOX( $this, $this->{RADIO}, \&OnRadio );
    EVT_BUTTON( $this, $this->{FONTBUTTON}, \&OnSetFont );

    #
    # Gauge and slider
    #

    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );
    $this->{NOTEBOOK}->AddPage( $panel, "Wx::Gauge", 0, 4 );

    use Wx qw(wxGA_HORIZONTAL wxNO_BORDER wxGREEN wxRED wxSL_LABELS);

    Wx::StaticBox->new( $panel, -1, "&wxGauge and wxSlider", [10, 10],
                        [200, 130] );
    $this->{GAUGE} = Wx::Gauge->new( $panel, -1, 200, [18, 50],
                                     [155, 30], wxGA_HORIZONTAL|wxNO_BORDER );
    $this->{GAUGE}->SetBackgroundColour( wxGREEN );
    $this->{GAUGE}->SetForegroundColour( wxRED );
    $this->{SLIDER} = Wx::Slider->new( $panel, -1, 0, 0, 200,
                                       [18, 90], [155, -1],
                                       wxSL_LABELS );
    Wx::StaticBox->new( $panel, -1, "&Explanation", [220, 10], [270, 130] );
    Wx::StaticText->new( $panel, -1,
                         join( '',
                               "In order see the gauge (aka progress bar)\n",
                               "control do something you have to drag the\n",
                               "handle of the slider to the right.\n",
                               "\n",
                               "This is also supposed to demonstrate how\n",
                               "to use static controls.\n",
                             ),
                         [228, 25], [240, 110]
                       );
    $this->{SPINTEXT} = new Wx::TextCtrl( $panel, -1, "-5",
                                          [20, 160 ], [80, -1] );
    $this->{SPINBUTTON} = new Wx::SpinButton( $panel, -1, [103, 160],
                                              [80, -1] );
    $this->{SPINBUTTON}->SetRange( -10, 30 );
    $this->{SPINBUTTON}->SetValue( -5 );

    $this->{BTNPROGRESS} = Wx::Button->new( $panel, -1, 
                                            "&Show progress dialog",
                                            [300, 160] );

    $this->{SPINCTRL} = Wx::SpinCtrl->new( $panel, -1, '', [200, 160],
                                           [80, -1] );
    $this->{SPINCTRL}->SetRange( 10, 30 );
    $this->{SPINCTRL}->SetValue( 15 );

    use Wx::Event qw(EVT_SLIDER EVT_SPIN EVT_SPIN_UP EVT_SPIN_DOWN
       EVT_UPDATE_UI EVT_SPINCTRL);

    EVT_SLIDER( $this, $this->{SLIDER}, \&OnSliderUpdate );
    EVT_SPIN( $this, $this->{SPINBUTTON}, \&OnSpinUpdate );
    EVT_SPIN_UP( $this, $this->{SPINBUTTON}, \&OnSpinUp );
    EVT_SPIN_DOWN( $this, $this->{SPINBUTTON}, \&OnSpinDown );
    EVT_SPINCTRL( $this, $this->{SPINCTRL}, \&OnSpinCtrl );
    EVT_BUTTON( $this, $this->{BTNPROGRESS}, \&OnShowProgress );
    EVT_UPDATE_UI( $this, $this->{BTNPROGRESS}, \&OnUpdateShowProgress );

    #
    # BitmapXXX
    #
    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );
    $this->{NOTEBOOK}->AddPage( $panel, "Wx::BitmapXXX" );

    use Wx qw(wxTheApp wxICON_INFORMATION wxICON_QUESTION wxICON_WARNING wxNullIcon wxNullBitmap wxGREEN_PEN);
    my( $icon ) = wxTheApp->GetStdIcon( wxICON_INFORMATION );
    my( $st1 ) = Wx::StaticBitmap->new( $panel, -1, $icon, [10, 10] );
    my( $st2 ) = Wx::StaticBitmap->new( $panel, -1, wxNullIcon, [50, 10] );

    $st2->SetIcon( wxTheApp->GetStdIcon( wxICON_QUESTION ) );

    my( $bmp ) = Wx::Bitmap->new( 100, 100 );
    my( $dc ) = Wx::MemoryDC->new();

    $dc->SelectObject( $bmp );
    $dc->SetPen( wxGREEN_PEN );
    $dc->Clear();
    $dc->DrawEllipse( 5, 5, 90, 90 );
    $dc->DrawText( "Bitmap", 30, 40 );
    $dc->SelectObject( wxNullBitmap );

    my( $b1 ) = Wx::BitmapButton->new( $panel, -1, $bmp, [100, 20] );

    if( $Wx::_platform != $Wx::_motif ) {
      my( $bmp ) = Wx::Bitmap->new( "test2.bmp", wxBITMAP_TYPE_BMP );

      if( $bmp->Ok() ) {
        $bmp->SetMask( Wx::Mask->new( $bmp, wxBLUE ) );
        Wx::StaticBitmap->new( $panel, -1, $bmp, [300, 120] );
      }
    }

    my( $bmp1 ) = Wx::Bitmap->new( wxTheApp->GetStdIcon( wxICON_INFORMATION ) );
    my( $bmp2 ) = Wx::Bitmap->new( wxTheApp->GetStdIcon( wxICON_WARNING ) );
    my( $bmp3 ) = Wx::Bitmap->new( wxTheApp->GetStdIcon( wxICON_QUESTION ) );

    my( $b2 ) = Wx::BitmapButton->new( $panel, -1, $bmp1, [30, 50] );
    $b2->SetBitmapSelected( $bmp2 );
    $b2->SetBitmapFocus( $bmp3 );

    use Wx qw(wxALIGN_RIGHT);

    my( $b3 ) = Wx::Button->new( $panel, -1, "&Toggle label", [250, 20] );
    $this->{LABEL} = Wx::StaticText->new( $panel, -1,
                                          "Label with some long text",
                                          [250, 60], wxDefaultSize,
                                          wxALIGN_RIGHT );
    $this->{LABEL}->SetForegroundColour( wxBLUE );

    EVT_BUTTON( $this, $b3, \&OnUpdateLabel );
    EVT_BUTTON( $this, $b1, \&OnBmpButton );

    #
    # Constraints
    #
    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );
    $panel->SetAutoLayout( 1 );
    $this->{NOTEBOOK}->AddPage( $panel, "Wx::LayoutConstraints" );

    use Wx qw(wxTop wxLeft wxWidth wxBottom wxRight);

    my( $c ) = Wx::LayoutConstraints->new;
    $c->top->SameAs( $panel, wxTop, 10 );
    $c->height->AsIs();
    $c->left->SameAs( $panel, wxLeft, 10 );
    $c->width->PercentOf( $panel, wxWidth, 40 );

    my( $button ) = Wx::Button->new( $panel, $ID_BUTTON_TEST1, 'Test button &1' );
    $button->SetConstraints( $c );

    EVT_BUTTON( $this, $button, \&OnTestButton );

    $c = Wx::LayoutConstraints->new;
    $c->top->SameAs( $panel, wxTop, 10 );
    $c->bottom->SameAs( $panel, wxBottom, 10 );
    $c->right->SameAs( $panel, wxRight, 10 );
    $c->width->PercentOf( $panel, wxWidth, 40 );

    $button = Wx::Button->new( $panel, $ID_BUTTON_TEST2, 'Test button &2' );
    $button->SetConstraints( $c );

    EVT_BUTTON( $this, $button, \&OnTestButton );

    #
    # Sizers
    #
    my( $panel ) = Wx::Panel->new( $this->{NOTEBOOK}, -1 );
    $panel->SetAutoLayout( 1 );
    $this->{NOTEBOOK}->AddPage( $panel, 'Wx::Sizer' );

    use Wx qw(wxHORIZONTAL wxALL wxGROW);

    my( $sz ) = Wx::BoxSizer->new( wxHORIZONTAL );
    $sz->AddWindow( Wx::Button->new( $panel, -1, 'Test button &1' ), 3, wxALL, 10 );
    $sz->AddSpace( 20, 20, 1 );
    $sz->AddWindow( Wx::Button->new( $panel, -1, 'Test button &2' ), 3, wxGROW|wxALL, 10 );

    $panel->SetSizer( $sz );

    #
    # main
    #
    EVT_SIZE( $this, \&OnSize );
    EVT_NOTEBOOK_PAGE_CHANGING( $this, $this->{NOTEBOOK}, \&OnPageChanging );
    EVT_NOTEBOOK_PAGE_CHANGED( $this, $this->{NOTEBOOK}, \&OnPageChanged );

    $this;
}

sub OnSize {
    my( $this ) = @_;
    my( $x, $y ) = $this->GetClientSizeXY();

    $this->{NOTEBOOK}->SetSize( 2, 2, $x-4, $y*2/3-4 );
    $this->{TEXT}->SetSize( 2, $y*2/3+2, $x-4, $y/3-4 );
}

sub OnListBox {
  my( $this, $event ) = @_;

  if( $event->GetInt() == -1 ) {
    $this->{TEXT}->Append( "List box has no selections any more\n" );
    return;
  }

  my( $lb ) = $event->GetId() == $ID_LISTBOX ? $this->{LISTBOX} : $this->{LISTBOXSORTED} ;

  $this->{TEXT}->AppendText( join '',
                             "ListBox Event selection string is '",
                             $event->GetString(), "'\n",
                             "ListBox Control selection string is '",
                             $lb->GetStringSelection(), "'\n" );

  my( $t ) = $event->GetClientData();
  my( $t2 ) = $lb->GetClientData( $lb->GetSelection() );
  $this->{TEXT}->AppendText( join '',
                             "ListBox Event client data is '",
                             ( $t ? $t : 'none' ) , "'\n",
                             "ListBox Control client data is '",
                             ( $t2 ? $t2 : 'none' ), "'\n", );
}

sub OnListBoxDoubleClick {
  my( $this, $event ) = @_;

  $this->{TEXT}->AppendText( join '',
                             "ListBox double click string is '",
                             $event->GetString(), "'\n" ) ;
}

sub OnListBoxButtons_Enable {
  my( $this, $event ) = @_;

  $this->{TEXT}->AppendText( "CheckBox clicked.\n" );
  my( $e ) = $event->GetInt() == 0;
  $this->{LISTBOX}->Enable( $e );
  $this->{LBSELECTTHIS}->Enable( $e );
  $this->{LBSELECTNUM}->Enable( $e );
  $this->{LISTBOXSORTED}->Enable( $e );
  $this->FindWindow( $ID_CHANGE_COLOUR )->Enable( $e );
  my( $cb ) = $this->{CHECKBOX};#$event->GetEventObject();
  if( $e ) { $cb->SetToolTip( "Click to disable listbox" ) }
  else { $cb->SetToolTip( "Click to enable listbox" ) }
}

sub OnListBoxButtons_SelNum {
  my( $this, $event ) = @_;

  $this->{LISTBOX}->SetSelection( 2 );
  $this->{LISTBOXSORTED}->SetSelection( 2 );
  $this->{LBSELECTTHIS}->WarpPointer( 40, 14 );
}

sub OnListBoxButtons_SelStr {
  my( $this, $event ) = @_;

  $this->{LISTBOX}->SetStringSelection( "This" );
  $this->{LISTBOXSORTED}->SetStringSelection( "This" );
  $this->{LBSELECTNUM}->WarpPointer( 40, 14 );
}

sub OnListBoxButtons_Clear {
  my( $this ) = @_;

  $this->{LISTBOX}->Clear();
  $this->{LISTBOXSORTED}->Clear();
}

sub OnListBoxButtons_Append {
  my( $this ) = @_;

  $this->{LISTBOX}->Append( 'Hi!' );
  $this->{LISTBOXSORTED}->Append( 'Hi!' );
}

sub OnListBoxButtons_Delete {
  my( $this ) = @_;
  my( $idx );

  if( ( $idx = $this->{LISTBOX}->GetSelection() ) != wxNOT_FOUND ) {
    $this->{LISTBOX}->Delete( $idx );
  }
  if( ( $idx = $this->{LISTBOXSORTED}->GetSelection() ) != wxNOT_FOUND ) {
    $this->{LISTBOXSORTED}->Delete( $idx );
  }
}

sub OnListBoxButtons_Font {
  my( $this ) = @_;

  $this->{LISTBOX}->SetFont( wxITALIC_FONT );
  $this->{LISTBOXSORTED}->SetFont( wxITALIC_FONT );
  $this->{CHECKBOX}->SetFont( wxITALIC_FONT );
}

sub OnChoice {
  my( $this, $event ) = @_;
  my( $choice ) = $event->GetId() == $ID_CHOICE ? $this->{CHOICE}
                                                : $this->{CHOICESORTED};

  $this->{TEXT}->AppendText( join '', "Choice event selection string is: '",
                             $event->GetString(), "'\n",
                             "Choice control selection string is: '",
                             $choice->GetStringSelection(), "'\n" );
}

sub OnChoiceButtons_Enable {
  my( $this, $event ) = @_;

  my( $e ) = $event->GetInt() == 0;
  $this->{CHOICE}->Enable( $e );
  $this->{CHOICESORTED}->Enable( $e );
}

sub OnChoiceButtons_SelNum {
  my( $this, $event ) = @_;

  $this->{CHOICE}->SetSelection( 2 );
  $this->{CHOICESORTED}->SetSelection( 2 );
}

sub OnChoiceButtons_SelStr {
  my( $this, $event ) = @_;

  $this->{CHOICE}->SetStringSelection( "This" );
  $this->{CHOICESORTED}->SetStringSelection( "This" );
}

sub OnChoiceButtons_Clear {
  my( $this ) = @_;

  $this->{CHOICE}->Clear();
  $this->{CHOICESORTED}->Clear();
}

sub OnChoiceButtons_Append {
  my( $this ) = @_;

  $this->{CHOICE}->Append( 'Hi!' );
  $this->{CHOICESORTED}->Append( 'Hi!' );
}

sub OnChoiceButtons_Delete {
  my( $this ) = @_;
  my( $idx );

  if( ( $idx = $this->{CHOICE}->GetSelection() ) != wxNOT_FOUND ) {
    $this->{CHOICE}->Delete( $idx );
  }
  if( ( $idx = $this->{CHOICESORTED}->GetSelection() ) != wxNOT_FOUND ) {
    $this->{CHOICESORTED}->Delete( $idx );
  }
}

sub OnChoiceButtons_Font {
  my( $this ) = @_;

  $this->{CHOICE}->SetFont( wxITALIC_FONT );
  $this->{CHOICESORTED}->SetFont( wxITALIC_FONT );
}

sub OnCombo {
  my( $this, $event ) = @_;

  $this->{TEXT}->AppendText( join '', "ComboBox event selection string is: '",
                             $event->GetString(), "'\n",
                             "ComboBox control selection string is: '",
                             $this->{COMBO}->GetStringSelection(), "'\n" );
}

sub OnComboTextChanged {
  my( $this ) = @_;

  Wx::LogMessage( "Text in the combobox changed: now is '%s'.",
                  $this->{COMBO}->GetValue() );
}

sub OnComboTextEnter {
  my( $this ) = @_;

  Wx::LogMessage( "Enter pressed in the combobox changed: now is '%s'.",
                  $this->{COMBO}->GetValue() );
}

sub OnComboButtons_Enable {
  my( $this, $event ) = @_;

  my( $e ) = $event->GetInt() == 0;
  $this->{COMBO}->Enable( $e );
}

sub OnComboButtons_SelNum {
  my( $this, $event ) = @_;

  $this->{COMBO}->SetSelection( 2 );
}

sub OnComboButtons_SelStr {
  my( $this, $event ) = @_;

  $this->{COMBO}->SetStringSelection( "This" );
}

sub OnComboButtons_Clear {
  my( $this ) = @_;

  $this->{COMBO}->Clear();
}

sub OnComboButtons_Append {
  my( $this ) = @_;

  $this->{COMBO}->Append( 'Hi!' );
}

sub OnComboButtons_Delete {
  my( $this ) = @_;
  my( $idx );

  if( ( $idx = $this->{COMBO}->GetSelection() ) != wxNOT_FOUND ) {
    $this->{COMBO}->Delete( $idx );
  }
}

sub OnComboButtons_Font {
  my( $this ) = @_;

  $this->{COMBO}->SetFont( wxITALIC_FONT );
}

sub OnRadio {
  my( $this, $event ) = @_;

  $this->{TEXT}->AppendText( join '', "RadioBox selection string is: ",
                             $event->GetString(), "\n" );
}

sub OnRadioButtons_Enable {
  my( $this, $event ) = @_;

  $this->{RADIO}->Enable( $event->GetInt() == 0 );
}

sub OnRadioButtons_SelNum {
  my( $this ) = @_;

  $this->{RADIO}->SetSelection( 2 );
}

sub OnRadioButtons_SelStr {
  my( $this ) = @_;

  $this->{RADIO}->SetStringSelection( "This" );
}

sub OnRadioButtons_Font {
  my( $this ) = @_;

  $this->{RADIO}->SetFont( wxITALIC_FONT );
}

sub OnSetFont {
  my( $this ) = @_;

  $this->{FONTBUTTON}->SetFont( wxITALIC_FONT );
  $this->{TEXT}->SetFont( wxITALIC_FONT );
}

use Wx qw(:progressdialog);

sub OnUpdateShowProgress {
  my( $this, $event ) = @_;

  $event->Enable( $this->{SPINBUTTON}->GetValue > 0 );
}

sub OnShowProgress {
  my( $this, $event ) = @_;
  my( $max ) = $this->{SPINBUTTON}->GetValue();

  my $dialog = Wx::ProgressDialog->new( 'Progress dialog example',
                                        'An informative message',
                                        $max, $this,
                                        wxPD_CAN_ABORT|wxPD_AUTO_HIDE|
                                        wxPD_APP_MODAL|wxPD_ELAPSED_TIME|
                                        wxPD_ESTIMATED_TIME|
                                        wxPD_REMAINING_TIME );

  my( $cont ) = 1;

  foreach ( 1 .. $max ) {
    sleep 1;
    if( $_ == $max ) { $cont = $dialog->Update( $_, "That's all, folks!" ) }
    elsif( $_ == int( $max / 2 ) ) {
      $cont = $dialog->Update( $_, "Only a half left (very long message)" )
    } else { $cont = $dialog->Update( $_ ) }
    last unless $cont;
  }

  $this->{TEXT}->AppendText( $cont ?
                             "Countdown from $max finished.\n" :
                             "Progress dialog aborted" );

  $dialog->Destroy;
}

use Wx qw(wxNullColour);

{
  my( $old_c );

  sub OnChangeColour {
    my( $this ) = @_;

    if( $old_c && $old_c->Ok() ) {
      $this->SetBackgroundColour( $old_c );
      $old_c = wxNullColour;

      $this->{LBSELECTTHIS}->SetForegroundColour( Wx::Colour->new( "red" ) );
      $this->{LBSELECTTHIS}->SetBackgroundColour( Wx::Colour->new( "white" ) );
    }
    else {
      $old_c = Wx::Colour->new( "red" );
      $this->SetBackgroundColour( Wx::Colour->new( "white" ) );

      $this->{LBSELECTTHIS}->SetForegroundColour( Wx::Colour->new( "white" ) );
      $this->{LBSELECTTHIS}->SetBackgroundColour( Wx::Colour->new( "red" ) );
    }

    $this->{LBSELECTTHIS}->Refresh();
    $this->Refresh();
  }
}

sub OnPageChanged {
  my( $this, $event ) = @_;

  $this->{TEXT}->AppendText( join '', "Notebook selection is ",
                             $event->GetSelection(), "\n" );
}

{
  my( $long ) = 1;

  sub OnUpdateLabel {
    my( $this ) = @_;

    $long = !$long;
    $this->{LABEL}->SetLabel( $long ? "Very very very very very long text." :
                              "Shorter text" );
  }
}

sub OnSliderUpdate {
  my( $this ) = @_;

  $this->{GAUGE}->SetValue( $this->{SLIDER}->GetValue() );
}

sub OnSpinCtrl {
  my( $this, $event ) = @_;

  $this->{TEXT}->AppendText( sprintf
                             "Spin ctrl changed: now %d (from event %d)\n",
                             $this->{SPINCTRL}->GetValue(),
                             $event->GetInt() );
}

sub OnSpinUp {
  my( $this, $event ) = @_;

  my( $value ) = sprintf "Spin control up: current = %d\n",
    $this->{SPINBUTTON}->GetValue();

  if( $this->{SPINBUTTON}->GetValue() > 17 ) {
    $value .= "Preventing the spin button from going above 17\n";
    $event->Veto();
  }

  $this->{TEXT}->AppendText( $value );
}

sub OnSpinDown {
  my( $this, $event ) = @_;

  my( $value ) = sprintf "Spin control down: current = %d\n",
    $this->{SPINBUTTON}->GetValue();

  if( $this->{SPINBUTTON}->GetValue() < -17 ) {
    $value .= "Preventing the spin button from going below -17\n";
    $event->Veto();
  }

  $this->{TEXT}->AppendText( $value );
}

sub OnSpinUpdate {
  my( $this, $event ) = @_;

  $this->{SPINTEXT}->SetValue( $event->GetPosition() );
  $this->{TEXT}->AppendText( sprintf "Spin control range: ( %d, %d ) current = %d\n",
                             $this->{SPINBUTTON}->GetMin(),
                             $this->{SPINBUTTON}->GetMax(),
                             $this->{SPINBUTTON}->GetValue() );
}

sub OnBmpButton {
  Wx::LogMessage( "Bitmap button clicked." );
}

sub OnTestButton {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'Button ' . ( $event->GetId() == $ID_BUTTON_TEST1 ?
                  1 : 2 ) . ' clicked.' );
}

use Wx qw(wxICON_QUESTION wxYES_NO wxYES);

sub OnPageChanging {
  my( $this, $event ) = @_;
  my( $old ) = $event->GetOldSelection();

  if( $old == 2 ) {
    if ( Wx::MessageBox( "This demonstrates how a program may prevent the\n" .
                         "page change from taking place - if you select\n" .
                         "[No] the current page will stay the third one\n",
                         "Control sample",
                         wxICON_QUESTION | wxYES_NO, $this ) != wxYES ) {
      $event->Veto();

      return;
    }
  }

  $this->{TEXT}->AppendText( join '',
                             "Notebook selection is being changed from ",
                             $old, "\n" );
}

package MyButton;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::Button);

use Wx::Event qw(EVT_LEFT_DCLICK EVT_BUTTON);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_ );

  EVT_LEFT_DCLICK( $this, \&OnDClick );
  EVT_BUTTON( $this, $this, \&OnButton );

  $this;
}

sub OnDClick {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyButton::OnDClick' );
  $event->Skip();
}

sub OnButton {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyButton::OnButton' );
  $event->Skip();
}

package MyRadioBox;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::RadioBox);

use Wx::Event qw(EVT_SET_FOCUS EVT_KILL_FOCUS);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_ );

  EVT_SET_FOCUS( $this, \&OnFocusGot );
  EVT_KILL_FOCUS( $this, \&OnFocusLost );

  $this;
}

sub OnFocusGot {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyRadioBox::OnFocusGot' );
  $event->Skip();
}

sub OnFocusLost {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyRadioBox::OnFocusLost' );
  $event->Skip();
}

package MyComboBox;

use strict;
use vars qw(@ISA);

@ISA = qw(Wx::ComboBox);
use Wx::Event qw(EVT_SET_FOCUS EVT_CHAR EVT_KEY_DOWN EVT_KEY_UP);

sub new {
  my( $class ) = shift;
  my( $this ) = $class->SUPER::new( @_ );

  EVT_SET_FOCUS( $this, \&OnFocusGot );
  EVT_CHAR( $this, \&OnChar );
  EVT_KEY_DOWN( $this, \&OnKeyDown );
  EVT_KEY_UP( $this, \&OnKeyUp );

  $this;
}

sub OnChar {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyComboBox::OnChar' );

  if( $event->GetKeyCode() == ord( 'w' ) ) {
    Wx::LogMessage( 'MyComboBox: \'w\' will be ignored' );
  } else {
    $event->Skip();
  }
}

sub OnKeyDown {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyComboBox::OnKeyDown' );

  if( $event->GetKeyCode() == ord( 'w' ) ) {
    Wx::LogMessage( 'MyComboBox: \'w\' will be ignored' );
  } else {
    $event->Skip();
  }
}

sub OnKeyUp {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyComboBox::OnKeyUp' );
  $event->Skip();
}

sub OnFocusGot {
  my( $this, $event ) = @_;

  Wx::LogMessage( 'MyComboBox::FocusGot' );
  $event->Skip();
}

package MyFrame;

use strict;
use vars qw(@ISA);

use Wx qw(wxTheApp wxICON_INFORMATION);

@ISA = qw(Wx::Frame);

sub new {
    my( $class, $frame, $title, $x, $y, $w, $h ) = @_;
    my( $this ) = $class->SUPER::new( $frame, -1, $title,
                                      Wx::Point->new( $x, $y ),
                                      Wx::Size->new( $w, $h ) );
    $this->CreateStatusBar( 2 );
    $this->{PANEL} = MyPanel->new( $this, 10, 10, 300, 100 );

    use Wx::Event qw(EVT_SIZE EVT_MOVE EVT_IDLE EVT_CLOSE);

    EVT_SIZE( $this, \&OnSize );
    EVT_MOVE( $this, \&OnMove );
    EVT_IDLE( $this, \&OnIdle );
    EVT_CLOSE( $this, \&OnClose );

    $this;
}

sub OnQuit {
}

sub OnAbout {
}

sub OnClose {
  my( $this ) = shift;

  Wx::Log::SetActiveTarget( $this->{PANEL}->{OLDLOG} );

  $_[0]->Skip();
}

sub OnSize {
  my( $this, $event ) = @_;

  $this->_UpdateStatusBar( $this->GetPosition(), $event->GetSize() );

  $event->Skip();
}

sub OnMove {
  my( $this, $event ) = @_;

  $this->_UpdateStatusBar( $event->GetPosition(), $this->GetSize() );

  $event->Skip();
}

sub _UpdateStatusBar {
    my( $this, $pos, $size ) = @_;

    $this->SetStatusText( sprintf( "pos=(%d, %d), size=%dx%d",
                                   $pos->x, $pos->y, $size->width, $size->height ),
                          1 );
}

{
  my( $focused );

  sub OnIdle {
    my( $this, $event ) = @_;

    my( $f ) = Wx::Window::FindFocus();

    #FIXME// must be overloaded
    if( $f && $f ne $focused ) {
      $focused = $f;

      $this->SetStatusText( sprintf 'Focus: %s', ref $focused );
    }
  }
}


package main;

my( $app ) = MyApp->new();

$app->MainLoop();

# Local variables: #
# mode: cperl #
# End: #
