wxPerl is a wrapper built around the wxWidgets
(formerly known as wxWindows) GUI toolkit

Copyright (c) 2000-2004 Mattia Barbon.
This package is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

You need wxWidgets in order to build wxPerl (see http://www.wxwindows.org/).
You can use GTK, Win32, Mac OS X and Motif as windowing toolkits for wxPerl.

Please read the DEPRECATIONS section at the bottom!

INSTALLATION:

Build and install wxWidgets

perl Makefile.PL
make
make test
make install

for more detailed instructions see the docs/install.txt file;
in case of problems please consult the FAQ section therein.

TESTED PLATFORMS:

Perl            | OS            | wxWidgets      | Compiler
----------------+---------------+----------------+-------------------
ActivePerl 6xx  | Windows 2000  |                | MSVC 5
           8xx  |               | wxMSW 2.4.2    | MSVC 6
5.6.1           |               | wxMSW 2.5.1    | MinGW GCC
5.8.0           |               |                |
----------------+---------------+----------------+-------------------
5.8.0           | RedHat 8.0    | wxGTK 2.4.2    | GCC 3.2
5.6.1           | Debian 3.0    | wxMotif 2.5.1  | GCC 2.95.2
----------------+---------------+----------------+-------------------  
5.8.0           | Mac OS X 10.2 | wxMac 2.5.1    | GCC 3.1
----------------+---------------+----------------+-------------------

wxPerl has also been reported to work on FreeBSD and IRIX.

DEPRECATIONS

The following features have been deprecated and may disappear in the future

1 - class->new always returning an hash reference
    until now calling ->new( ... ) returned an hash reference for most
    classes derived from Wx::Window, hence the following code
    worked:

    my $button = Wx::Button->new( ... );
    $button->{attribute} = 'value';

    At some point in the future this will be changed so that only
    _user-defined_ classes derived from Wx::Window
    (or from any class derived from Wx::Window)
    will yield an hash reference, hence the following code will not work:

    my $button = Wx::Button->new( ... );
    my $window = Wx::Window->new( ... );
    $button->{a} = 'b';
    $window->{c} = 'd';

    while the following code will work as it did before:

    my $button = MyButton->new( ... ); # MyButton ISA Wx::Button
    my $window = MyWindow->new( ... ); # MyWindow ISA Wx::Window
    $button->{a} = 'b';
    $window->{c} = 'd';

2 - Use of $Wx::_foo

    wxPerl used to provide some constants named $Wx::_something
    (for example, $Wx::_msw, $Wx::_platform, $Wx::_wx_version).

    These constants are now deprecated, and will be removed in
    some future version; this information is available via
    functions in the Wx package (i.e. Wx::wxMSW())

    toolkit: wxMSW, wxGTK, wxMOTIF, wxX11, wxMAC, wxUNIVERSAL
    misc:    wxUNICODE, wxVERSION
    