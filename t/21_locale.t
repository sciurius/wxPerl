#!/usr/bin/perl -w

use strict;
use Wx qw( wxLANGUAGE_DEFAULT );
use Wx::Locale;
use Test::More 'tests' => 4;

my $langinfo = Wx::Locale::GetLanguageInfo(wxLANGUAGE_DEFAULT);
isa_ok( $langinfo, 'Wx::LanguageInfo', 'GetLanguageInfo' );

my $goodname = $langinfo->GetCanonicalName;

my $langinfo2 = Wx::Locale::FindLanguageInfo($goodname);
isa_ok( $langinfo2, 'Wx::LanguageInfo', 'FindLanguageInfo' );

my $langinfo3 = Wx::Locale::GetLanguageInfo(5000);
ok(!defined($langinfo3), 'Undefined GetLanguageInfo');

my $langinfo4 = Wx::Locale::FindLanguageInfo('xx_xx');
ok(!defined($langinfo4), 'Undefined FindLanguageInfo');







