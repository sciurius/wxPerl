#############################################################################
## Name:        _Inheritance.pm
## Purpose:     set inheritance tree
## Author:      Mattia Barbon
## Modified by:
## Created:     25/11/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

no strict;

package Wx::EvtHandler;
package Wx::Window;       @ISA = qw(Wx::EvtHandler);
package Wx::Menu;         @ISA = qw(Wx::EvtHandler);
package Wx::MenuBar;      @ISA = qw(Wx::Window);
package Wx::MenuItem;
package Wx::_App;         @ISA = qw(Wx::EvtHandler);
package Wx::Frame;        @ISA = qw(Wx::Window);
package Wx::Panel;        @ISA = qw(Wx::Window);
package Wx::Dialog;       @ISA = qw(Wx::Panel);
package Wx::Control;      @ISA = qw(Wx::Window);
package Wx::Button;       @ISA = qw(Wx::Control);
package Wx::BitmapButton; @ISA = qw(Wx::Button);
package Wx::TextCtrl;     @ISA = qw(Wx::Control);
package Wx::StaticText;   @ISA = qw(Wx::Control);
package Wx::CheckBox;     @ISA = qw(Wx::Control);
package Wx::CheckListBox; @ISA = qw(Wx::ListBox);
package Wx::ControlWithItems; @ISA = qw(Wx::Control);
package Wx::Choice;       @ISA = qw(Wx::ControlWithItems);
package Wx::ListBox;      @ISA = qw(Wx::ControlWithItems);
package Wx::Notebook;     @ISA = qw(Wx::Control);
package Wx::ToolBarBase;  @ISA = qw(Wx::Control);
package Wx::ToolBar;      @ISA = qw(Wx::ToolBarBase);
package Wx::ToolBarSimple;@ISA = qw(Wx::Control);
package Wx::ToolBarToolBase;
package Wx::StaticBitmap; @ISA = qw(Wx::Control);
package Wx::Gauge;        @ISA = qw(Wx::Control);
package Wx::Slider;       @ISA = qw(Wx::Control);
package Wx::SpinCtrl;     @ISA = qw(Wx::Control);
package Wx::SpinButton;   @ISA = qw(Wx::Control);
package Wx::RadioBox;     @ISA = qw(Wx::Control);
package Wx::RadioButton;  @ISA = qw(Wx::Control);
package Wx::StaticLine;   @ISA = qw(Wx::Control);
package Wx::StaticBox;    @ISA = qw(Wx::Control);
package Wx::ScrollBar;    @ISA = qw(Wx::Control);
package Wx::StatusBarGeneric; @ISA = qw(Wx::Window);
package Wx::MiniFrame;    @ISA = qw(Wx::Frame);
package Wx::SplitterWindow; @ISA = qw(Wx::Window);
package Wx::ScrolledWindow; @ISA = qw(Wx::Panel);
package Wx::ColourDialog; @ISA = qw(Wx::Dialog);
package Wx::DirDialog;    @ISA = qw(Wx::Dialog);
package Wx::FileDialog;   @ISA = qw(Wx::Dialog);
package Wx::TextEntryDialog; @ISA = qw(Wx::Dialog);
package Wx::MessageDialog; @ISA = qw(Wx::Dialog);
package Wx::ProgressDialog;@ISA = qw(Wx::Dialog);

package Wx::Validator;    @ISA = qw(Wx::EvtHandler);
package Wx::TextValidator;@ISA = qw(Wx::Validator);
package Wx::GenericValidator;@ISA = qw(Wx::Validator);
package Wx::PlValidator;  @ISA = qw(Wx::Validator);

package Wx::GDIObject;
package Wx::Font;         @ISA = qw(Wx::GDIObject);
package Wx::Region;       @ISA = qw(Wx::GDIObject);
package Wx::Cursor;       @ISA = qw(Wx::GDIObject);
package Wx::Bitmap;       @ISA = qw(Wx::GDIObject);
package Wx::Brush;        @ISA = qw(Wx::GDIObject);
package Wx::Pen;          @ISA = qw(Wx::GDIObject);

package Wx::DC;
package Wx::WindowDC;     @ISA = qw(Wx::DC);
package Wx::PaintDC;      @ISA = qw(Wx::WindowDC);

package Wx::Image;
package Wx::ImageHandler;
package Wx::BMPHandler;   @ISA = qw(Wx::ImageHandler);
package Wx::PNGHandler;   @ISA = qw(Wx::ImageHandler);
package Wx::JPEGHandler;  @ISA = qw(Wx::ImageHandler);
package Wx::GIFHandler;   @ISA = qw(Wx::ImageHandler);
package Wx::PCXHandler;   @ISA = qw(Wx::ImageHandler);
package Wx::PNMHandler;   @ISA = qw(Wx::ImageHandler);
package Wx::TIFFHandler;  @ISA = qw(Wx::ImageHandler);

package Wx::Log;
package Wx::LogTextCtrl;  @ISA = qw(Wx::Log);

package Wx::Sizer;
package Wx::BoxSizer;     @ISA = qw(Wx::Sizer);
package Wx::StaticBoxSizer;@ISA = qw(Wx::BoxSizer);
package Wx::GridSizer;    @ISA = qw(Wx::Sizer);
package Wx::FlexGridSizer;@ISA = qw(Wx::GridSizer);
package Wx::NotebookSizer;@ISA = qw(Wx::Sizer);

# this is because the inheritance tree is a bit different between
# wxGTK and wxMSW
#FIXME// motif?

use strict;

package Wx::MemoryDC;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk || $Wx::_platform == $Wx::_motif ) {
  @ISA = qw(Wx::WindowDC);
}
else {
  @ISA = qw(Wx::DC);
}

package Wx::ScreenDC;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::PaintDC);
}
else {
  @ISA = qw(Wx::WindowDC);
}

package Wx::ComboBox;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::Control);
}
else {
  @ISA = qw(Wx::Choice);
}

package Wx::StatusBar;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::StatusBarGeneric);
}
else {
  @ISA = qw(Wx::Window);
}

package Wx::Icon;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::Bitmap);
}
else {
  @ISA = qw(Wx::GDIObject);
}

package Wx::Colour;

use vars qw(@ISA);

if( $Wx::_platform == $Wx::_gtk ) {
  @ISA = qw(Wx::GDIObject);
}

1;

# Local variables: #
# mode: cperl #
# End: #
