wxPerl is a wrapper built around the wxWindows GUI toolkit

Copyright (c) 2000-2001 Mattia Barbon.
This package is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

You need wxWindows in order to build wxPerl (see http://www.wxwindows.org/).
At this moment you may only use GTK or Win32 ( Motif in alpha stage ) 
 as windowing toolkits for wxPerl.

INSTALLATION:

Build and install wxWindows

perl Makefile.PL
make
make test
make install

for more detailed instructions see the docs/install.txt file

TESTED PLATFORMS:

Perl            | OS            | wxWindows      | Compiler
----------------+---------------+----------------+-------------------
ActivePerl 616  | Windows 95    | wxMSW 2.2.9    | MSVC 5
       620,628  | Windows 2000  | wxMSW 2.3.2    | MSVC 6
5.6.1           |               |                | MinGW GCC
----------------+---------------+----------------+-------------------
5.005_03        | Debian 2.2    | wxGTK 2.2.9    | GCC 2.95.2
5.004_05        | Debian 3.0    | wxGTK 2.3.2    |
5.004_04 [1]    | RedHat 7.1    |                |
----------------+---------------+----------------+-------------------  

wxPerl has also been reported to work on FreeBSD.

[1] see docs/bugs.txt
