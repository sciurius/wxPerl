package W32;

use strict;
use Config;
use base 'Any_OS';
use wxMMUtils;

# check for WXDIR and WXWIN environment variables
unless( exists $ENV{WXDIR} and exists $ENV{WXWIN} ) {
  warn <<EOT;

**********************************************************************
WARNING!

You need to set the WXDIR and WXWIN variables; refer to
docs/install.txt for a detailed explanation
**********************************************************************

EOT
  exit 1;
}

sub top_targets {
  my $this = shift;

  my $text = $this->SUPER::top_targets( @_ );

  # --static requires linking at the end, after extensions.
  # !--static might require linking before extensions
  if( !$wxConfig::o_static ) {
    $text =~ s{^(\w+\s*:+.*?)subdirs(.*?)linkext(.*?)$}
      {$1linkext$2subdirs$3}m;
  }

  $text;
}

sub postamble {
  my $this = shift;
  my $wxdir = wx_config( 'wxdir' );
  my $implib = wx_config( 'implib' );
  $implib =~ s/lib([^\/\\]+?)\.\w+$/$1\.dll/;

  my $text = $this->SUPER::postamble( @_ ) || '';
  $text .= <<EOT;

ppmdist: pure_all ppd
\t\$(CP) ${implib} blib\\arch\\auto\\Wx
\tstrip blib\\arch\\auto\\Wx\\*.dll
\t\$(TAR) \$(TARFLAGS) \$(DISTVNAME)-ppm.tar blib
\tgzip --force --best \$(DISTVNAME)-ppm.tar

EOT

  $text;
}

use vars qw(%config);
sub configure {
  my $this = shift;
  local *config; *config = $this->SUPER::configure();

  $config{INC} .= " -I" . top_dir() . " ";
  if( building_extension() ) {
    $config{DEFINE} .= " -DWXPL_EXT ";
  } else {
    my $res = $this->res_file();
    $config{depend} = { $res => 'Wx.rc ' };
    $config{LDFROM} .= "\$(OBJECT) $res ";
    $config{dynamic_lib} = { INST_DYNAMIC_DEP => $res,
                             OTHERLDFLAGS => " " };
  }

  return \%config;
}

1;

# Local variables: #
# mode: cperl #
# End: #

