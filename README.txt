wxPerl is a wrapper built around the wxWindows GUI toolkit

Copyright (c) 2000-2001 Mattia Barbon.
This package is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

You need wxWindows in order to build wxPerl (see http://www.wxwindows.org/).
At this moment you may only use GTK, Motif or Win32 as windowing toolkits.

INSTALLATION:

Build and install wxWindows

perl Makefile.PL
make
make test
make install

for more detailed instructions see the docs/install.txt file

TESTED PLATFORMS:

Perl 5.6.0 ( ActivePerl build 616, 620 )
  i386,   Windows 95,           wxMSW 2.2.1,   VC++ 5.0
  i386,   Windows 2000,         wxMSW 2.2.1,   VC++ 5.0
    ( need to rebuild the perl56.lib import library,
     the one shipped with AP is for VC++ 6, see docs/install.txt for details )
  i386,   Windows 2000,         wxMSW 2.2.3,   MinGW GCC 2.95.2-1
    ( needs some additional hacking to work, see docs/install.txt for details )

Perl 5.6.0 ( built from sources with dmake & MinGW )
  i386,   Windows 2000,         wxMSW 2.2.3,   MinGW GCC 2.95.2-1
  
Perl 5.005_03
  i386,   RedHat Linux 6.1,     wxGTK 2.2.3,   GCC 2.91.x
  i386,   Debian GNU/Linux 2.2, wxGTK 2.2.3,   GCC 2.95.2
  i386,   Debian GNU/Linux 2.2, wxMotif 2.2.1, GCC 2.95.2

Perl 5.004_05
  i386,   Debian GNU/Linux 2.2, wxGTK 2.2.3,   GCC 2.95.2

Perl 5.004_04
  i386,   Debian GNU/Linux 2.2, wxGTK 2.2.3,   GCC 2.95.2