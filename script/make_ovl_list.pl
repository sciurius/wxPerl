#!/usr/bin/perl -w
#############################################################################
## Name:        script/make_ovl_list.pl
## Purpose:     builds overload constants
## Author:      Mattia Barbon
## Modified by:
## Created:     17/08/2001
## RCS-ID:      $Id: make_ovl_list.pl,v 1.17 2006/08/11 19:55:00 mbarbon Exp $
## Copyright:   (c) 2001-2003, 2005-2006 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

package MyFile;

sub TIEHANDLE {
  my $class = shift; $class = ref( $class ) ? ref( $class ) : $class;
  my $file = shift;

  return bless { FILE => $file,
                 DATA => '' }, $class;
}

sub PRINT {
  my $this = shift;
  $this->{DATA} .= join '', @_;
}

sub do_write {
  my $this = shift;
  local *OUT;

  print "Writing '", $this->{FILE}, ".\n";
  open OUT, "> " . $this->{FILE} or die "open '", $this->{FILE}, "': $!";
  print OUT $this->{DATA};
  close OUT or die "close '", $this->{FILE}, "': $!";
}

sub CLOSE {
  local *IN;
  my $this = shift;

  if( !open *IN, "< " . $this->{FILE} ) {
    $this->do_write;
  } else {
    my $text = join '', <IN>;
    if( $text eq $this->{DATA} ) {
      print "'", $this->{FILE}, "' not modified, skipping\n";
    } else {
      close IN;
      $this->do_write
    }
  }
}

package main;

my $ovl = shift @ARGV;
my $ovlc = shift @ARGV;
my $ovlh = shift @ARGV;

my %name2type =
  (
   wimg => 'Wx::Image',
   wbmp => 'Wx::Bitmap',
   wico => 'Wx::Icon',
   wmen => 'Wx::Menu',
   wmit => 'Wx::MenuItem',
   wrec => 'Wx::Rect',
   wreg => 'Wx::Region',
   wszr => 'Wx::Sizer',
   wtip => 'Wx::ToolTip',
   wwin => 'Wx::Window',
   wcol => 'Wx::Colour',
   wlci => 'Wx::ListItem',
   wsiz => 'Wx::Size',
   wpoi => 'Wx::Point',
   wgco => 'Wx::GridCellCoords',
   wdat => 'Wx::DataObject',
   wcur => 'Wx::Cursor',
   wehd => 'Wx::EvtHandler',
   wtid => 'Wx::TreeItemId',
   wfon => 'Wx::Font',
   wdc  => 'Wx::DC',
   wfrm => 'Wx::Frame',
   wgbp => 'Wx::GBPosition',
   wgbs => 'Wx::GBSpan',
   wgbi => 'Wx::GBSizerItem',
   wilo => 'Wx::IconLocation',
   wist => 1,
   wost => 1,
   num  => 1,
   str  => 1,
   bool => 1,
   arr  => 1,
  );

my %constants;

foreach my $i ( @ARGV ) {
  open IN, '< ' . $i or die "unable to open '$i'";

  while( <IN> ) {
    if( m/Wx::_match\(\s*\@_\s*,\s*\$Wx::_(\w+)\s*\,/ ||
        m/wxPliOvl_(\w+)/ ) {
      my $const = $1;
      my @const = split /_/, $const;
      foreach my $j ( @const ) {
        $j = 'num' if $j eq 'n';
        $j = 'str' if $j eq 's';
        $j = 'bool' if $j eq 'b';

        die "unrecognized type '$j' in file '$i'"
          unless $name2type{$j};
        $constants{$const} = \@const;
      }
    }
  }
}

my @keys = ( ( sort grep { $name2type{$_} ne '1' } keys %name2type ),
             ( sort grep { $name2type{$_} eq '1' } keys %name2type ) );

my $vars_comma = join ", ", map { "\$$_" } @keys;
my $vars = $vars_comma; $vars =~ s/,//g;
my $types = join ", ", map { "'$name2type{$_}'" }
  grep { $name2type{$_} ne '1' } @keys;

=for comment

open OUT, '> '. $ovl || die "unable to open file '$ovl'";
binmode OUT; # Perl 5.004 on Unix complains for CR

print OUT <<EOT;
#############################################################################
## Name:        _Ovl.pm
## Purpose:     overload constants (GENERATED, DO NOT EDIT)
## Author:      Mattia Barbon
## Modified by:
## Created:     17/ 8/2001
## Copyright:   (c) 2001 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

package Wx;

EOT

print OUT "use vars qw(\@tnames ${vars});\n";
print OUT "( ${vars_comma} ) = ( 1 .. 100 );\n\n";
print OUT "\@tnames = ( undef, ${types} );\n\n";

foreach my $i ( sort keys %constants ) {
  print OUT "\$Wx::_$i = [ ";
  print OUT join ", ", map { "\$$_" } @{$constants{$i}};
  print OUT " ];\n";
}

print OUT <<EOT;

1;

# Local variables: #
# mode: cperl #
# End: #
EOT

=cut

#open OUT, '> '. $ovlh || die "unable to open file '$ovlc'";
#binmode OUT;
tie *OUT1, 'MyFile', $ovlh;

my $enum = join ",\n", map { "    wxPliOvl$_" } @keys;
my $cpp_types = $types; $cpp_types =~ s/\'/\"/g;

print OUT1 <<EOT;
// GENERATED FILE, DO NOT EDIT

#ifndef _CPP_OVERLOAD_H
#define _CPP_OVERLOAD_H

enum
{
    wxPliOvl_Dummy = 0,
$enum
};

extern const char* wxPliOvl_tnames[];

#endif

EOT

foreach my $i ( sort keys %constants ) {
  print OUT1 "extern const unsigned char wxPliOvl_$i\[\];\n";
  print OUT1 "#define wxPliOvl_${i}_count " . scalar @{$constants{$i}} . "\n";
}

close OUT1;

tie *OUT2, 'MyFile', $ovlc;
#open OUT, '> '. $ovlc || die "unable to open file '$ovlc'";
#binmode OUT;

print OUT2 <<EOT;
// GENERATED FILE, DO NOT EDIT

const char* wxPliOvl_tnames[] = { 0,
$cpp_types
};

extern void wxPli_set_ovl_constant( const char* name,
                                    const unsigned char* value, int count );
EOT

print OUT2 <<EOT;

#ifndef WXPL_EXT

void SetOvlConstants()
{
    dTHX;
EOT

#foreach my $i ( @keys ) {
#  print OUT "    tmp = get_sv( \"Wx::${i}\", 1 ); sv_setiv( tmp, wxPliOvl${i} );\n";
#}

foreach my $i ( keys %constants ) {
  print OUT2 "    wxPli_set_ovl_constant( \"$i\", wxPliOvl_${i}, wxPliOvl_${i}_count );\n";
}

print OUT2 <<EOT;
}

#endif // WXPL_EXT

EOT

foreach my $i ( sort keys %constants ) {
  print OUT2 "const unsigned char wxPliOvl_$i\[\] = { ";
  print OUT2 join ", ", map { "wxPliOvl$_" } @{$constants{$i}};
  print OUT2 " };\n";
}

close OUT2;

exit 0;

# Local variables: #
# mode: cperl #
# End: #


