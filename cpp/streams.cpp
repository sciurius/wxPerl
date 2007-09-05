/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/streams.cpp
// Purpose:     implementation for streams.h
// Author:      Mattia Barbon
// Modified by:
// Created:     30/03/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001-2002, 2004, 2006-2007 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
typedef wxFileOffset wxPliFileOffset;
#else
typedef off_t wxPliFileOffset;
#endif

// thread KO
const char sub_read[] = "sub { read $_[0], $_[1], $_[2] }";
const char sub_seek[] = "sub { seek $_[0], $_[1], $_[2]; tell $_[0] }";
const char sub_tell[] = "sub { tell $_[0] }";
const char sub_write[] = "sub { print { $_[0] } $_[1] }";
const char sub_length[] = "sub { eval { fileno( $_[0] ) } ? ( stat $_[0] )[7] : -1 }";

SV* sg_read;
SV* sg_seek;
SV* sg_tell;
SV* sg_write;
SV* sg_length;

class wxPliStreamInitializer
{
public:
    wxPliStreamInitializer()
    {
        dTHX;
        sg_read = eval_pv( CHAR_P sub_read, 1 );
        sg_seek = eval_pv( CHAR_P sub_seek, 1 );
        sg_tell = eval_pv( CHAR_P sub_tell, 1 );
        sg_write = eval_pv( CHAR_P sub_write, 1 );
        sg_length = eval_pv( CHAR_P sub_length, 1 );
        SvREFCNT_inc( sg_read );
        SvREFCNT_inc( sg_seek );
        SvREFCNT_inc( sg_tell );
        SvREFCNT_inc( sg_write );
        SvREFCNT_inc( sg_length );
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

wxPliFileOffset stream_seek( wxStreamBase* stream, SV* fh, wxPliFileOffset seek, wxSeekMode mode );
wxPliFileOffset stream_tell( const wxStreamBase* stream, SV* fh );
wxPliFileOffset stream_length( const wxStreamBase* stream, SV* fh );

// input stream

wxPliInputStream* wxPliInputStream_ctor( SV* sv )
{
    return new wxPliInputStream( sv );
}

wxPliOutputStream* wxPliOutputStream_ctor( SV* sv )
{
    return new wxPliOutputStream( sv );
}

wxPliInputStream::wxPliInputStream( SV* fh )
    :m_fh( fh )
{
    dTHX;
    SvREFCNT_inc( m_fh );
}

wxPliInputStream::wxPliInputStream( const wxPliInputStream& stream )
    :m_fh( stream.m_fh )
{
    dTHX;
    SvREFCNT_inc( m_fh );
}

const wxPliInputStream& wxPliInputStream::operator =
    ( const wxPliInputStream& stream )
{
    dTHX;
    if( m_fh ) SvREFCNT_dec( m_fh );
    m_fh = stream.m_fh;
    SvREFCNT_inc( m_fh );

    return *this;
}

wxPliInputStream::~wxPliInputStream()
{
    dTHX;
    SvREFCNT_dec( m_fh );
}

size_t wxPliInputStream::OnSysRead( void* buffer, size_t size )
{
    //FIXME// need a ( safe ) way to: create an SV, set ( NOT copy )
    //FIXME// buffer into it, then call sg_read

    dTHX;
    dSP;

    ENTER;
    SAVETMPS;

    SV* target = sv_2mortal( newSVsv( &PL_sv_undef ) );

    PUSHMARK( SP );
    XPUSHs( m_fh );
    XPUSHs( target );
    XPUSHs( sv_2mortal( newSVuv( size ) ) );
    PUTBACK;

    call_sv( sg_read, G_SCALAR );

    SPAGAIN;

    SV* sv_read_count = POPs;
    size_t read_count = 0;

    m_lasterror = wxSTREAM_NO_ERROR;
    if( !SvOK( sv_read_count ) )
        m_lasterror = wxSTREAM_READ_ERROR;
    else 
    {
        read_count = SvOK( target ) ? SvUV( sv_read_count ) : 0;
        if( !read_count )
            m_lasterror = wxSTREAM_EOF;
    }

    PUTBACK;

    if( read_count )
        memcpy( buffer, SvPV_nolen( target ), read_count );

    FREETMPS;
    LEAVE;

    return read_count;
}

wxPliFileOffset wxPliInputStream::OnSysSeek( wxPliFileOffset seek, wxSeekMode mode )
{
    return stream_seek( this, m_fh, seek, mode );
}

wxPliFileOffset wxPliInputStream::OnSysTell() const
{
    return stream_tell( this, m_fh );
}

wxFileOffset wxPliInputStream::GetLength() const
{
    return stream_length( this, m_fh );
}

size_t wxPliInputStream::GetSize() const
{
    return stream_length( this, m_fh );
}

// output stream

wxPliOutputStream::wxPliOutputStream( SV* fh )
    :m_fh( fh )
{
    dTHX;
    SvREFCNT_inc( m_fh );
}

wxPliOutputStream::wxPliOutputStream( const wxPliOutputStream& stream )
    :m_fh( stream.m_fh )
{
    dTHX;
    SvREFCNT_inc( m_fh );
}

const wxPliOutputStream& wxPliOutputStream::operator =
    ( const wxPliOutputStream& stream )
{
    dTHX;
    if( m_fh ) SvREFCNT_dec( m_fh );
    m_fh = stream.m_fh;
    SvREFCNT_inc( m_fh );

    return *this;
}

wxPliOutputStream::~wxPliOutputStream()
{
    dTHX;
    SvREFCNT_dec( m_fh );
}

size_t wxPliOutputStream::OnSysWrite( const void* buffer, size_t size )
{
    //FIXME// need a ( safe ) way to: create an SV, set ( NOT copy )
    //FIXME// buffer into it, then call sg_write

    // printf( "OnSysWrite: %x %d = ", buffer, size );

    dTHX;
    dSP;

    ENTER;
    SAVETMPS;

    SV* target = sv_2mortal( newSVpvn( CHAR_P ( const char*)buffer, size ) );

    PUSHMARK( SP );
    XPUSHs( m_fh );
    XPUSHs( target );
    XPUSHs( sv_2mortal( newSVuv( size ) ) );
    PUTBACK;

    call_sv( sg_write, G_SCALAR );

    SPAGAIN;

    SV* sv_write_count = POPs;
    size_t write_count = 0;

    m_lasterror = wxSTREAM_NO_ERROR;
    if( !SvOK( sv_write_count ) )
        m_lasterror = wxSTREAM_WRITE_ERROR;
    else
    {
        write_count = SvUV( sv_write_count );
    }

    PUTBACK;

    FREETMPS;
    LEAVE;

    // printf( "%d\n", write_count );fflush( stdout );
    // OnSysSeek( 0, wxFromCurrent );

    return write_count;
}

wxPliFileOffset wxPliOutputStream::OnSysSeek( wxPliFileOffset seek, wxSeekMode mode )
{
    return stream_seek( this, m_fh, seek, mode );
}

wxPliFileOffset wxPliOutputStream::OnSysTell() const
{
    return stream_tell( this, m_fh );
}

wxFileOffset wxPliOutputStream::GetLength() const
{
    return stream_length( this, m_fh );
}

size_t wxPliOutputStream::GetSize() const
{
    return stream_length( this, m_fh );
}

// helpers

wxPliFileOffset stream_seek( wxStreamBase* stream, SV* fh, wxPliFileOffset seek, wxSeekMode mode )
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

    dTHX;
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

    return ret;
}

wxPliFileOffset stream_tell( const wxStreamBase* stream, SV* fh )
{
    dTHX;
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

    return ret;
}

wxPliFileOffset stream_length( const wxStreamBase* stream, SV* fh )
{
    dTHX;
    dSP;

    ENTER;
    SAVETMPS;

    PUSHMARK( SP );
    XPUSHs( fh );
    PUTBACK;

    call_sv( sg_length, G_SCALAR );

    SPAGAIN;
    IV ret = POPi;
    PUTBACK;

    FREETMPS;
    LEAVE;

    return ret == -1 ? ~0 : ret;
}
