/////////////////////////////////////////////////////////////////////////////
// Name:        streams.cpp
// Purpose:     implementation for streams.h
// Author:      Mattia Barbon
// Modified by:
// Created:     30/ 3/2001
// RCS-ID:      
// Copyright:   (c) 2001 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

const char sub_read[] = "sub { sysread $_[0], $_[1], $_[2] }";
const char sub_seek[] = "sub { sysseek $_[0], $_[1], $_[2] }";
const char sub_tell[] = "sub { sysseek $_[0], 0, 1 }";
const char sub_write[] = "sub { syswrite $_[0], $_[1] }";

SV* sg_read;
SV* sg_seek;
SV* sg_tell;
SV* sg_write;

class wxPliStreamInitializer
{
public:
    wxPliStreamInitializer()
    {
        sg_read = eval_pv( CHAR_P sub_read, 1 );
        sg_seek = eval_pv( CHAR_P sub_seek, 1 );
        sg_tell = eval_pv( CHAR_P sub_tell, 1 );
        sg_write = eval_pv( CHAR_P sub_write, 1 );
        SvREFCNT_inc( sg_read );
        SvREFCNT_inc( sg_seek );
        SvREFCNT_inc( sg_tell );
        SvREFCNT_inc( sg_write );
    }

    ~wxPliStreamInitializer()
    {
        // SvREFCNT_dec( sg_read );
        // SvREFCNT_dec( sg_seek );
        // SvREFCNT_dec( sg_tell );
        // SvREFCNT_dec( sg_write );
    }
};

wxPliStreamInitializer dummy;

// helpers

off_t stream_seek( wxStreamBase* stream, SV* fh, off_t seek, wxSeekMode mode );
off_t stream_tell( const wxStreamBase* stream, SV* fh );

// input stream

wxPliInputStream::wxPliInputStream( SV* fh )
    :m_fh( fh )
{
    SvREFCNT_inc( m_fh );
}

wxPliInputStream::wxPliInputStream( const wxPliInputStream& stream )
    :m_fh( stream.m_fh )
{
    SvREFCNT_inc( m_fh );
}

const wxPliInputStream& wxPliInputStream::operator =
    ( const wxPliInputStream& stream )
{
    if( m_fh ) SvREFCNT_dec( m_fh );
    m_fh = stream.m_fh;
    SvREFCNT_inc( m_fh );

    return *this;
}

wxPliInputStream::~wxPliInputStream()
{
    SvREFCNT_dec( m_fh );
}

size_t wxPliInputStream::OnSysRead( void* buffer, size_t size )
{
    //FIXME// need a ( safe ) way to: create an SV, set ( NOT copy )
    //FIXME// buffer into it, then call sg_read

//    printf( "OnSysRead: %x %d = ", buffer, size );

    dSP;

    ENTER;
    SAVETMPS;

    SV* target = sv_2mortal( newSVsv( &PL_sv_undef ) );

    PUSHMARK( SP );
    XPUSHs( m_fh );
    XPUSHs( target );
    XPUSHs( sv_2mortal( newSViv( size ) ) );
    PUTBACK;

    call_sv( sg_read, G_SCALAR );

    SPAGAIN;

    SV* sv_read_count = POPs;
    size_t read_count;

    m_lasterror = wxSTREAM_NO_ERROR;
    if( !SvOK( sv_read_count ) )
        m_lasterror = wxSTREAM_READ_ERROR;
    else if( !( read_count = SvIV( sv_read_count ) ) )
        m_lasterror = wxSTREAM_EOF;

    PUTBACK;

    memcpy( buffer, SvPV_nolen( target ), read_count );

    FREETMPS;
    LEAVE;

//    printf( "%d\n", read_count );fflush( stdout );
//    OnSysSeek( 0, wxFromCurrent );

    return read_count;
}

off_t wxPliInputStream::OnSysSeek( off_t seek, wxSeekMode mode )
{
    return stream_seek( this, m_fh, seek, mode );
}

off_t wxPliInputStream::OnSysTell() const
{
    return stream_tell( this, m_fh );
}

// output stream

wxPliOutputStream::wxPliOutputStream( SV* fh )
    :m_fh( fh )
{
    SvREFCNT_inc( m_fh );
}

wxPliOutputStream::wxPliOutputStream( const wxPliOutputStream& stream )
    :m_fh( stream.m_fh )
{
    SvREFCNT_inc( m_fh );
}

const wxPliOutputStream& wxPliOutputStream::operator =
    ( const wxPliOutputStream& stream )
{
    if( m_fh ) SvREFCNT_dec( m_fh );
    m_fh = stream.m_fh;
    SvREFCNT_inc( m_fh );

    return *this;
}

wxPliOutputStream::~wxPliOutputStream()
{
    SvREFCNT_dec( m_fh );
}

size_t wxPliOutputStream::OnSysWrite( const void* buffer, size_t size )
{
    //FIXME// need a ( safe ) way to: create an SV, set ( NOT copy )
    //FIXME// buffer into it, then call sg_write

    // printf( "OnSysWrite: %x %d = ", buffer, size );

    dSP;

    ENTER;
    SAVETMPS;

    SV* target = sv_2mortal( newSVpvn( CHAR_P ( const char*)buffer, size ) );

    PUSHMARK( SP );
    XPUSHs( m_fh );
    XPUSHs( target );
    XPUSHs( sv_2mortal( newSViv( size ) ) );
    PUTBACK;

    call_sv( sg_write, G_SCALAR );

    SPAGAIN;

    SV* sv_write_count = POPs;
    size_t write_count;

    m_lasterror = wxSTREAM_NO_ERROR;
    if( !SvOK( sv_write_count ) )
        m_lasterror = wxSTREAM_WRITE_ERROR;

    PUTBACK;

    FREETMPS;
    LEAVE;

    // printf( "%d\n", write_count );fflush( stdout );
    // OnSysSeek( 0, wxFromCurrent );

    return write_count;
}

off_t wxPliOutputStream::OnSysSeek( off_t seek, wxSeekMode mode )
{
    return stream_seek( this, m_fh, seek, mode );
}

off_t wxPliOutputStream::OnSysTell() const
{
    return stream_tell( this, m_fh );
}

// helpers

off_t stream_seek( wxStreamBase* stream, SV* fh, off_t seek, wxSeekMode mode )
{
    IV pl_act;

    switch( mode )
    {
    case wxFromStart:
        pl_act = 0;
        break;
    case wxFromCurrent:
        pl_act = 1;
        break;
    case wxFromEnd:
        pl_act = 2;
        break;
    default:
        return -1;
    }

    // printf( "OnSysSeek: %d %d = ", seek, mode );

    dSP;

    ENTER;
    SAVETMPS;

    PUSHMARK( SP );
    XPUSHs( fh );
    XPUSHs( sv_2mortal( newSViv( seek ) ) );
    XPUSHs( sv_2mortal( newSViv( pl_act ) ) );
    PUTBACK;

    call_sv( sg_seek, G_SCALAR );

    SPAGAIN;
    IV ret = POPi;
    PUTBACK;

    FREETMPS;
    LEAVE;

    // printf( "%d\n", ret );fflush( stdout );
    return ret;
}

off_t stream_tell( const wxStreamBase* stream, SV* fh )
{
    dSP;

    ENTER;
    SAVETMPS;

    PUSHMARK( SP );
    XPUSHs( fh );
    PUTBACK;

    call_sv( sg_tell, G_SCALAR );

    SPAGAIN;
    IV ret = POPi;
    PUTBACK;

    FREETMPS;
    LEAVE;

//    printf( "OnSysTell: %d\n", ret );fflush( stdout );

    return ret;
}
