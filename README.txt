wxPerl is a wrapper for the wxWidgets (formerly known as wxWindows) GUI toolkit

Copyright (c) 2000-2006 Mattia Barbon.
This package is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

You need wxWidgets in order to build wxPerl (see http://www.wxwidgets.org/).
You can use GTK, Win32, Mac OS X and Motif as windowing toolkits for wxPerl.

Please read the DEPRECATIONS section at the bottom!

INSTALLATION:

Build and install wxWidgets

perl Makefile.PL
make
make test
make install

for more detailed instructions see the docs/install.pod file;
in case of problems please consult the FAQ section therein.

TESTED PLATFORMS:

Perl            | OS            | wxWidgets      | Compiler
----------------+---------------+----------------+-------------------
ActivePerl 8xx  | Windows 2000  | wxMSW 2.8.x    | MSVC 5
Strawberry Perl | Windows XP    |                | MSVC 6
5.10.x          |               |                | MinGW GCC 3.4
----------------+---------------+----------------+-------------------
5.8.x           | Fedora 9      | wxGTK 2.8.x    | GCC 3.x
5.6.1           | Debian 4.0    |                | GCC 4.x
                | FreeBSD       |                |
                | Gentoo        |                |
----------------+---------------+----------------+-------------------  
5.8.x           | Mac OS X 10.3 | wxMac 2.5.3    | GCC 3.3
5.10.0          | Mac OS X 10.4 | wxMac 2.8.x    | GCC 4.0
                | Mac OS X 10.5 |                |
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
    will yield an hash reference, hence the following code will not
    work anymore:

    my $button = Wx::Button->new( ... );
    $button->{attribute} = 'value';

    while the following code will work as it did before:

    package MyButton;
    use base qw(Wx::Button);

    sub new {
        my $class = shift;
        my $self = $class->SUPER::new;	# always returns hash
        $self->{attribure} = 'value;
	return $self;
    }

2 - Use of $Wx::_foo

    wxPerl used to provide some constants named $Wx::_something
    (for example, $Wx::_msw, $Wx::_platform, $Wx::_wx_version).

    These constants are now deprecated, and will be removed in
    some future version; this information is available via
    functions in the Wx package (i.e. Wx::wxMSW())

    toolkit: wxMSW, wxGTK, wxMOTIF, wxX11, wxMAC, wxUNIVERSAL
    misc:    wxUNICODE, wxVERSION
