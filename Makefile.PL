#############################################################################
## Name:        Makefile.PL
## Purpose:     Makefile.PL
## Author:      Mattia Barbon
## Modified by:
## Created:      1/10/2000
## RCS-ID:      
## Copyright:   (c) 2000 Mattia Barbon
## Licence:     This program is free software; you can redistribute it and/or
##              modify it under the same terms as Perl itself
#############################################################################

use strict;

use ExtUtils::MakeMaker;
use Config;

sub BEGIN {
  if( $] < 5.005 ) {
    package File::Spec;

    sub catfile {
      shift;

      join '/', @_;
    }

    package main;
  } else {
    require File::Spec;
  }
}

use vars qw(@interesting_xs $debug_mode);

@interesting_xs = qw(Wx.xs Controls.xs Event.xs Constant.xs 
Functions.xs Window.xs Frames.xs GDI.xs);

my( $perl_version ) = int( $] * 1000 );

# configures subroutines depending
# from os/window system
sub BEGIN {
  SWITCH: {
      local( $_ ) = $Config{osname};

      /MSWin32/ && do {
        if( $Config{cc} =~ /^cl/i ) {
          *main::configure = \&configure_win32_msvc;
          *MY::postamble = \&MY::postamble_win32_msvc;
          last SWITCH;
        }

        die "Your compiler is not currently supported on Win32 platform"
      };

      # default: uses wx-config script
      do {
        *main::configure = \&configure_wxconfig;
        *MY::postamble = \&MY::postamble_wxconfig;
      };
    }
}

foreach ( @ARGV ) { if( m/^DEBUG=(\d+)$/ ) { $debug_mode = $1 ; undef $_; } }

WriteMakefile( NAME => 'Wx',
               ( $] >= 5.005 ? 
                 ( ABSTRACT_FROM => 'Wx.pm',
                   AUTHOR => 'Mattia Barbon <mbarbon@dsi.unive.it>',
                 ) : () ),
               VERSION_FROM => 'Wx.pm',
               CONFIGURE => \&configure,
               XSOPT => '-C++ -noprototypes',
               OBJECT => join( ' ',
                               MY::obj_from_src( @main::interesting_xs ), '' ),
             );

#
# takes parameters from the wx-config script
#
sub configure_wxconfig {
  my( $cccflags, $libs );
  my( %config ) = ( DEFINE => "-DWXP_VERSION=$perl_version" . ' ',
                  );

  if( $Config{cc} =~ /^cc|gcc$/i ) { $config{CCFLAGS} = '-g -x c++ ' }

  $cccflags = qx(wx-config --cflags);
  $libs = qx(wx-config --libs);

  foreach ( split ' ', $cccflags ) {
    m(^[-/]I) && do { $config{INC} .= $_ . ' '; next; };
    m(^[-/]D) && do { $config{DEFINE} .= $_ . ' '; next; };
    $config{CCFLAGS} .= $_ . ' ';
  }

  $config{LIBS} .= ' ' . $libs;

  foreach (keys %config) {
    print( $_ ," =>", $config{$_}, "\n" );
  }

  \%config;
}

#
# takes parametes form make*.env
#
sub configure_win32_msvc {
  my( $cccflags, $ldflags, $libs );

  my( %config ) = ( CCFLAGS => '-TP' . ' ',
                    DEFINE => " -DWXP_VERSION=$perl_version" . ' ',
                    depend =>
                    {  File::Spec->catfile( 'blib', 'arch', 'auto', 'Wx',
                                            'Wx.' . $Config{dlext} )
                       => 'Wx.res ',
                       'Wx.res' => 'Wx.rc ',
                    },
                    clean => { FILES => '*.pdb *.res Wx_def.old', },
                    LDFROM => '$(OBJECT) Wx.res',
                  );

  if( $debug_mode ) {
    $config{CCFLAGS} .= '-Zi ';
    $config{dynamic_lib}{OTHERLDFLAGS} .= '-debug ';
  }

  if( $Config{make} eq 'nmake' ) {
    my( $final ) = $debug_mode ? 'FINAL=0' : 'FINAL=1';
    $cccflags = qx"nmake /nologo /s /f nmake.mak cccflags $final";
    $libs = qx"nmake /nologo /s /f nmake.mak libs $final";

    foreach ( split ' ', $cccflags ) {
      m(^[-/]DSTRICT) && next;
      m(^[-/]M) && next;
      m(^[-/]I) && do { $config{INC} .= $_ . ' '; next; };
      m(^[-/]D) && do { $config{DEFINE} .= $_ . ' '; next; };
      $config{CCFLAGS} .= $_ . ' ';
    }

   foreach ( split ' ', $libs ) {
     m(wx)i || next;
     $config{LIBS} .= $_ . ' ';
   }
  }

  foreach (keys %config) {
    m/^[A-Z]+$/ || next;
    print( $_ ," => ", $config{$_}, "\n" );
  }

  \%config;
}


package MY;

use strict;
use Config;

#
# portable paths for lib/Wx/_Exp.pm and lib/Wx/Event.pm
#

my( $exp, $evt, $cst );
sub BEGIN {
  $exp = File::Spec->catfile( 'lib', 'Wx', '_Exp.pm' );
  $evt = File::Spec->catfile( 'lib', 'Wx', 'Event.pm' );
  $cst = File::Spec->catfile( 'lib', 'Wx', '_Constants.pm' );
}

sub depend {
  my( $this ) = shift;

  my( %depend ) = ( xs_depend( $this ),
                    'pm_to_blib' => $exp,
                    $exp => join( ' ', 'Constant.xs' , $evt, $cst ),
                    );
  my( %this_depend ) = @_;

  foreach ( keys %depend ) {
    $this_depend{$_} .= ' ' . $depend{$_};
  }

  $this->SUPER::depend( %this_depend );
}

#
# for .rc file compilation and automatic export list generation
#
sub postamble_win32_msvc {
  my( $this ) = shift;
  my( $wxdir ) = qx{nmake /nologo /s /f nmake.mak wxdir};

  chomp $wxdir;

  qq{
Wx.res: Wx.rc
\trc -I${wxdir}\\include Wx.rc

} .
$exp . qq{ :
\tperl script/make_exp_list.pl Constant.xs $evt $cst $exp
};
}

#
# automatic export list generation
#
sub postamble_wxconfig {
  $exp . qq{ :
\tperl script/make_exp_list.pl Constant.xs $evt $cst $exp
};
}

#
# Some utility functions
#

#
# quick and dirty method for creating dependencies:
# considers files included via #include "..." or INCLUDE: ...
# (not #include <...>) and assumes no included file
# incudes another file (since these are all local files,
# this is no problem)
#
sub scan_xs($) {
  my( $xs ) = @_;

  local( *IN, $_ );
  my( @cinclude, @xsinclude );

  open IN,$xs;

  while( $_ = <IN> ) {
    m/^\#\s*include\s+"([^"]*)"\s*$/ && do { push @cinclude, $1; next; };
    m/^\s*INCLUDE:\s+(.*)$/ && do { push @xsinclude, $1; next; };
  }

  close IN;

  ( \@cinclude, \@xsinclude );
}

#
# Makes dependencies for
# *.xs, *.c (from *.xs), *.obj (from *.xs) and
# blib/arch/auto/Wx/Wx.shared_object_extension
#
sub xs_depend {
  my( $this ) = @_;

  my( %depend );
  my( $c, $o, $cinclude, $xsinclude );

  foreach ( keys %{ $this->{XS} } ) {
    ( $cinclude, $xsinclude ) = scan_xs( $_ );
    $c = $this->{XS}{$_};
    $o = obj_from_src( $c );

    $depend{ $c } = $_ . ' ' . join( ' ', @$xsinclude );
    $depend{ $o } = $c . ' ' . join( ' ', @$cinclude );
  }

  $depend{ File::Spec->catfile( 'blib', 'arch', 'auto', 'Wx',
                                'Wx.' . $Config{dlext} ) }
    .= join(' ', obj_from_src( @main::interesting_xs ) );

  %depend;
}

#
# computes the name for an object file, given
# the source file name
#
sub obj_from_src {
  my( @xs ) = @_;
  my( $obj_ext ) = $Config{_o} || $Config{obj_ext};

  foreach( @xs ) {
    $_ =~ s[\.(?:xs|c|cc|cpp)$][$obj_ext]e;
  }

  if( wantarray ) { return @xs }
  else { return $xs[0] };
}

# Local variables: #
# mode: cperl #
# End: #
