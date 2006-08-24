#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use Test::More tests => 4;
use Wx::DND;

my $app = Wx::App->new( sub { 1 } );
my $datafrmt = Wx::DataFormat->newUser( 'MyFormat' );
my $datafrmt2 = Wx::DataFormat->newUser( 'MyFormat' );
my $dosimple = Wx::DataObjectSimple->new( $datafrmt );
my $dosimple2 = Wx::DataObjectSimple->new( $datafrmt );
my $docomposite = Wx::DataObjectComposite->new;
my $docomposite2 = Wx::DataObjectComposite->new;
my $dotext = Wx::TextDataObject->new( 'Foo' );
my $dotext2 = Wx::TextDataObject->new( 'Foo' );
my $dobitmap = Wx::BitmapDataObject->new;
my $dobitmap2 = Wx::BitmapDataObject->new;
my $domy = MyDataObject->new( $datafrmt );
my $domy2 = MyDataObject->new( $datafrmt );
my $domy3 = MyDataObject->new( $datafrmt );
my $dropt = Wx::DropTarget->new;
my $dropt2 = Wx::DropTarget->new;

$docomposite->Add( $dotext );
$docomposite->Add( $domy3 );

undef $datafrmt2;
undef $dosimple2;
undef $domy2;
# undef $domy3; # causes a 'scalar leaked'
undef $dropt2;
undef $dobitmap2;
undef $docomposite2;

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

END { ok( 1, 'At END' ) };

package MyDataObject;

use base qw(Wx::PlDataObjectSimple);
