/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/streams.h
// Purpose:     wrappers to pass streams from Perl to wxWidgets
//              (see also XS/Streams.xs)
// Author:      Mattia Barbon
// Modified by:
// Created:     30/03/2001
// RCS-ID:      $Id: streams.h,v 1.6 2004/12/21 20:59:21 mbarbon Exp $
// Copyright:   (c) 2001-2002, 2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_STREAMS_H
#define _WXPERL_STREAMS_H

#include <wx/stream.h>

// for wxWidgets use: store a Perl object and
// read from/write to it using wxWidgets functions

class wxPliInputStream:public wxInputStream
{
public:
    wxPliInputStream():m_fh( 0 ) {}
    wxPliInputStream( SV* fh );
    wxPliInputStream( const wxPliInputStream& stream );

    ~wxPliInputStream();

    const wxPliInputStream& operator =( const wxPliInputStream& stream );
protected:
    size_t GetSize() const { return ~(size_t)0; }
    size_t OnSysRead( void* buffer, size_t bufsize );

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxFileOffset OnSysSeek(wxFileOffset seek, wxSeekMode mode);
    wxFileOffset OnSysTell() const;
#else
    off_t OnSysSeek(off_t seek, wxSeekMode mode);
    off_t OnSysTell() const;
#endif
protected:
    SV* m_fh;
};

class wxPliOutputStream:public wxOutputStream
{
public:
    wxPliOutputStream():m_fh( 0 ) {}
    wxPliOutputStream( SV* fh );
    wxPliOutputStream( const wxPliOutputStream& stream );
    ~wxPliOutputStream();

    const wxPliOutputStream& operator = ( const wxPliOutputStream& stream );
protected:
    size_t OnSysWrite( const void* buffer, size_t size );

#if WXPERL_W_VERSION_GE( 2, 5, 3 )
    wxFileOffset OnSysSeek(wxFileOffset seek, wxSeekMode mode);
    wxFileOffset OnSysTell() const;
#else
    off_t OnSysSeek(off_t seek, wxSeekMode mode);
    off_t OnSysTell() const;
#endif
protected:
    SV* m_fh;
};

#endif
    // _WXPERL_STREAMS_H

// Local variables: //
// mode: c++ //
// End: //
