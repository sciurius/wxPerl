#!/usr/bin/perl -w

use strict;
use Test::More tests => 18;

use Wx;
use Wx::DocView;

my %did = ();

my $cp = Wx::CommandProcessor->new;
my $cmd = CP1->new( 0, 'first' );

ok( $cp->Submit( $cmd ) );

undef $cmd;

is( $did{first}, 1 );
ok( !$cp->CanUndo );

ok( $cp->Submit( CP1->new( 1, 'first' ) ) );
is( $did{first}, 2 );
ok( $cp->CanUndo );

ok( !$cp->Submit( CP2->new ) );

ok( $cp->Submit( CP1->new( 1, 'second' ) ) );
is( $did{second}, 1 );
ok( $cp->CanUndo );

# check ownership
my @cmds = $cp->GetCommands;
is_deeply( [ map $_->GetName, @cmds ], [ qw(first first second) ] );
undef @cmds;

ok( $cp->Undo );
is( $did{second}, 0 );

ok( $cp->Undo );
is( $did{first}, 1 );

ok( $cp->Redo );
is( $did{first}, 2 );

undef $cp;

{
    package CP1;

    use base qw(Wx::PlCommand);

    sub Do {
        my( $self ) = @_;

        ++$did{$self->GetName};

        return 1;
    }

    sub Undo {
        my( $self ) = @_;

        --$did{$self->GetName};

        return 1;
    }
}

{
    package CP2;

    use base qw(Wx::PlCommand);

    sub Do {
        main::ok( 1, __PACKAGE__ . '::Do' );

        return 0;
    }
}
