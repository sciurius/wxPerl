#!/usr/bin/perl -w

# test that overload dispatch works for
# specific functions

use strict;
use Wx;
use Wx::RichText;
use lib '../../t';
use Test::More 'tests' => 26;
use Tests_Helper qw(test_app :overload);
use Fatal qw(open);

my $nolog = Wx::LogNull->new;

test_app( sub {
my $frame = Wx::Frame->new( undef, -1, 'a' );
my $rtc = Wx::RichTextCtrl->new( $frame );
my $rtb = $rtc->GetBuffer;
my $ran = Wx::RichTextRange->new( 0, 1 );
my $ta = Wx::TextAttr->new;
my $tae = Wx::TextAttrEx->new;
my $rta = Wx::RichTextAttr->new;

# Wx::RichTextBuffer
test_override { $rtb->SetBasicStyle( $tae ) }
              'Wx::RichTextBuffer::SetBasicStyleEx';
test_override { $rtb->SetBasicStyle( $rta ) }
              'Wx::RichTextBuffer::SetBasicStyleRich';

if( Wx::wxVERSION() >= 2.007002 ) {
    test_override { $rtb->SetStyle( $ran, $rta ) }
                    'Wx::RichTextBuffer::SetStyleRich';
    test_override { $rtb->SetStyle( $ran, $tae ) }
                    'Wx::RichTextBuffer::SetStyleEx';
} else {
    ok( 1, 'skipped' );
    ok( 1, 'skipped' );
}

# Wx::RichTextCtrl
test_override { $rtc->SetBasicStyle( $tae ) }
              'Wx::RichTextCtrl::SetBasicStyleEx';
test_override { $rtc->SetBasicStyle( $rta ) }
              'Wx::RichTextCtrl::SetBasicStyleRich';

test_override { $rtc->SetStyle( $ran, $rta ) }
              'Wx::RichTextCtrl::SetStyleRange';
test_override { $rtc->SetStyle( 0, 1, $tae ) }
              'Wx::RichTextCtrl::SetStyleExFromTo';
test_override { $rtc->SetStyle( 0, 1, $ta ) }
              'Wx::RichTextCtrl::SetStyleFromTo';

if( Wx::wxVERSION() >= 2.007002 ) {
    if( Wx::wxVERSION() < 2.009 ) {
        test_override { $rtc->SetStyleEx( 0, 1, $tae ) }
                      'Wx::RichTextCtrl::SetStyleExExFromTo';
        ok( 1, 'balance test count' );
    } else {
        test_override { $rtc->SetStyleEx( $ran, $rta ) }
                      'Wx::RichTextCtrl::SetStyleExExRange';
        test_override { $rtc->SetStyleEx( $ran, $tae ) }
                      'Wx::RichTextCtrl::SetStyleExRange';
    }
} else {
    ok( 1, 'skipped' );
    ok( 1, 'skipped' );
}

test_override { $rtc->HasCharacterAttributes( $ran, $rta ) }
              'Wx::RichTextCtrl::HasCARich';
test_override { $rtc->HasCharacterAttributes( $ran, $tae ) }
              'Wx::RichTextCtrl::HasCAEx';

test_override { $rtc->HasParagraphAttributes( $ran, $rta ) }
              'Wx::RichTextCtrl::HasPARich';
test_override { $rtc->HasParagraphAttributes( $ran, $tae ) }
              'Wx::RichTextCtrl::HasPAEx';

# Wx::RichTextRange
test_override { Wx::RichTextRange->new }
              'Wx::RichTextRange::newDefault';
test_override { Wx::RichTextRange->new( 0, 1 ) }
              'Wx::RichTextRange::newFromTo';
test_override { Wx::RichTextRange->new( $ran ) }
              'Wx::RichTextRange::newCopy';

# Wx::TextAttrEx
test_override { Wx::TextAttrEx->new }
              'Wx::TextAttrEx::newDefault';
test_override { Wx::TextAttrEx->new( $tae ) }
              'Wx::TextAttrEx::newCopy';
test_override { Wx::TextAttrEx->new( $ta ) }
              'Wx::TextAttrEx::newAttr';

# Wx::RichTextAttr
test_override { Wx::RichTextAttr->new }
              'Wx::RichTextAttr::newDefault';
test_override { Wx::RichTextAttr->new( $rta ) }
              'Wx::RichTextAttr::newCopy';
test_override { Wx::RichTextAttr->new( $tae ) }
              'Wx::RichTextAttr::newAttrEx';
test_override { Wx::RichTextAttr->new( $ta ) }
              'Wx::RichTextAttr::newAttr';
if( Wx::wxVERSION() <= 2.009001 ) {
    test_override { Wx::RichTextAttr->new( Wx::wxRED(), Wx::wxRED() ) }
                    'Wx::RichTextAttr::newFull';
} else {
    ok( 1, "skipped" );
}
} );
