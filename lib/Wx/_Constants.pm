#############################################################################
## Name:        Constants.pm
## Purpose:     functions providing constants
## Author:      Mattia Barbon
## Modified by:
## Created:     29/10/2000
## RCS-ID:      $Id: _Constants.pm,v 1.12 2003/05/27 19:56:39 mbarbon Exp $
## Copyright:   (c) 2000-2003 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx::_Constants; # for RPM

package Wx;

my @vars;
BEGIN {
  @vars = qw(
  $_default_position $_default_size $_version_string $_default_validator
  $_null_bitmap $_null_icon $_null_colour $_null_cursor $_null_font $_null_pen
  $_null_brush $_null_palette $_null_accelerator
  $_pen_red $_pen_cyan $_pen_green $_pen_black $_pen_white
  $_pen_transparent $_pen_black_dashed $_pen_grey $_pen_medium_grey
  $_pen_light_grey
  $_brush_blue $_brush_green $_brush_white $_brush_black $_brush_grey
  $_brush_medium_grey $_brush_light_grey $_brush_transparent
  $_brush_cyan $_brush_red $_format_invalid $_clipboard);

  import vars @vars;
}

sub END {
  foreach ( $_clipboard, $_default_validator ) { s/^\$//; undef $$_ }
}

# !parser: sub { $_[0] =~ m/^\s*sub\s+(wx\w+)[^\}]*\}\s*(?:\#(.*))?$/ }
# !package: Wx

sub wxDefaultSize() { $_default_size }              # misc
sub wxDefaultPosition() { $_default_position }      # misc
sub wxDefaultValidator() { $_default_validator }    # misc

sub wxNullBitmap() { $_null_bitmap }                # bitmap
sub wxNullIcon() { $_null_icon }                    # icon
sub wxNullColour() { $_null_colour }                # colour color
sub wxNullCursor() { $_null_cursor }                # cursor
sub wxNullFont() { $_null_font }                    # font
sub wxNullPen() { $_null_pen }                      # pen
sub wxNullBrush() { $_null_brush }                  # brush
sub wxNullPalette() { $_null_palette }              # palette
sub wxNullAcceleratorTable() { $_null_accelerator }

sub wxRED_PEN() { $_pen_red }                       # pen
sub wxGREEN_PEN() { $_pen_green }                   # pen
sub wxCYAN_PEN() { $_pen_cyan }                     # pen
sub wxBLACK_PEN() { $_pen_black }                   # pen
sub wxWHITE_PEN() { $_pen_white }                   # pen
sub wxTRANSPARENT_PEN() { $_pen_transparent }       # pen
sub wxBLACK_DASHED_PEN() { $_pen_black_dashed }     # pen
sub wxGREY_PEN() { $_pen_grey }                     # pen
sub wxMEDIUM_GREY_PEN() { $_pen_medium_grey }       # pen
sub wxLIGHT_GREY_PEN() { $_pen_light_grey }         # pen

sub wxBLUE_BRUSH() { $_brush_blue }                 # brush
sub wxGREEN_BRUSH() { $_brush_green }               # brush
sub wxWHITE_BRUSH() { $_brush_white }               # brush
sub wxBLACK_BRUSH() { $_brush_black }               # brush
sub wxGREY_BRUSH() { $_brush_grey }                 # brush
sub wxMEDIUM_GREY_BRUSH() { $_brush_medium_grey }   # brush
sub wxLIGHT_GREY_BRUSH() { $_brush_light_grey }     # brush
sub wxTRANSPARENT_BRUSH() { $_brush_transparent }   # brush
sub wxCYAN_BRUSH() { $_brush_cyan }                 # brush
sub wxRED_BRUSH() { $_brush_red }                   # brush

sub wxFormatInvalid() { $_format_invalid }          # dnd
sub wxTheClipboard() { $_clipboard }                # clipboard

1;

# Local variables: #
# mode: cperl #
# End: #
