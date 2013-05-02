#!/usr/bin/perl -w

use strict;
use Config;
use if !$Config{useithreads} => 'Test::More' => skip_all => 'no threads';
use threads;

use Wx qw(:everything);
use Wx::IPC;
use if !Wx::_wx_optmod_ipc(), 'Test::More' => skip_all => 'No IPC Support';
use if !Wx::wxTHREADS, 'Test::More' => skip_all => 'No thread support';
use if !Wx::wxMSW, 'Test::More' => skip_all => 'Hangs on none wxMSW platforms';
# the hang is due to deadlock over fifo client / server in same process I think
use Test::More tests => 4;

my @keeps;

{
    my $servicename1 = create_service_name('WxInstallationTestsOne');
    my $servicename2 = create_service_name('WxInstallationTestsTwo');
    
    my $server1 =  Wx::Server->new;
    $server1->Create($servicename1);
    
    my $server2 =  Wx::Server->new;;
    $server2->Create($servicename2);
    
    my $client1 = Wx::Client->new;
    my $conn1 = $client1->MakeConnection('', $servicename1, 'Default Topic');
    
    my $client2 = Wx::Client->new;
    my $conn2 = $client2->MakeConnection('', $servicename2, 'Default Topic');
    
    push @keeps, ($server1, $client1, $conn1);
    
    $conn1->Disconnect;
    $conn2->Disconnect;
    
    # $server2, $client2, $conn2 destroyed when current scope ends
}

my $t = threads->create
  ( sub {
        ok( 1, 'In thread' );
    } );
ok( 1, 'Before join' );
$t->join;
ok( 1, 'After join' );

sub create_service_name {
    my($basename) = @_;
    # Our service name will be a unix domain socket
    # or an arbitrary DDE name on windows.
    # We also have to end up with the same path
    # on the client and the server, of course.
    
    # We are going to have 1 instance only
    # but it would be possible to create
    # some form of scheme where multiple
    # instances created some filesystem
    # directory that a client could query
    # for available running instances
    # and their service names.
    
    my $servicedir;
    
    if( $^O =~ /^mswin/i ) {
        require Win32;
        my $FOLDER_LOCAL_APPDATA = 0x001C;
        $servicedir = Win32::GetFolderPath($FOLDER_LOCAL_APPDATA, 1);
        $servicedir = Win32::GetShortPathName($servicedir);
        $servicedir =~ s/\\/\//g;
        $servicedir .= '/wxIPC';
    } elsif( $^O =~ /^darwin/i ) {
        $servicedir = $ENV{HOME} . '/Library/Application Support/wxIPC';
    } else {
        $servicedir = $ENV{HOME} . '/.wxIPC';
    }
    
    mkdir($servicedir, 0700) unless -d $servicedir;
    chmod(0700, $servicedir);
    my $servicename = qq($servicedir/$basename);
    return $servicename;
}


END { ok( 1, 'At END' ) };
