#!/usr/bin/perl -w

use strict;
use Wx;
use lib "../../t";
use if !Wx::_wx_optmod_webview(), 'Test::More' => skip_all => 'No WebView Support';
use Test::More 'no_plan';
use Tests_Helper qw(:inheritance);

BEGIN { test_inheritance_start() }
use Wx::WebView;
test_inheritance_end();
