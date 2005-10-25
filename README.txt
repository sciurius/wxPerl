wxPerl is a wrapper for the wxWidgets (formerly known as wxWindows) GUI toolkit

Copyright (c) 2000-2005 Mattia Barbon.
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
ActivePerl 6xx  | Windows 2000  | wxMSW 2.5.5    | MSVC 5
           8xx  |               | wxMSW 2.4.2    | MSVC 6
5.6.1           |               |                | MinGW GCC 3.4
5.8.3           |               |                |
----------------+---------------+----------------+-------------------
5.8.3           | RedHat 8.0    | wxGTK 2.4.2    | GCC 3.2
5.6.1           | Debian 3.0    |                | GCC 2.95.2
                | FreeBSD       | wxGTK 2.5.5    |
                | Gentoo        |                |
----------------+---------------+----------------+-------------------
5.6.1           | Solaris       | wxGTK 2.5.4    | GCC 3.3
----------------+---------------+----------------+-------------------  
5.8.3           | Mac OS X 10.3 | wxMac 2.5.5    | GCC 3.3
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
