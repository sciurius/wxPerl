/////////////////////////////////////////////////////////////////////////////
// Name:        fshandler.h
// Purpose:     C++ classes for Wx::PlFSFile and Wx::PlFileSystemHandler
// Author:      Mattia Barbon
// Modified by:
// Created:     17/ 4/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_FS_FSHANDLER_H
#define _WXPERL_FS_FSHANDLER_H

#include <wx/filesys.h>
#include "cpp/streams.h"
#include "cpp/v_cback.h"

class wxPlFSFile:public wxFSFile
{
public:
    wxPlFSFile( SV* fh, const wxString& loc, const wxString& mimetype,
                const wxString& anchor )
        : wxFSFile( wxPliInputStream_ctor( fh ),
                    loc, mimetype, anchor, wxDateTime() ) { }
};

class wxPlFileSystemHandler:public wxFileSystemHandler
{
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlFileSystemHandler );
    WXPLI_DECLARE_V_CBACK();
public:
    wxPlFileSystemHandler( const char* package )
        : m_callback( "Wx::PlFileSystemHandler" )
    {
        m_callback.SetSelf( wxPli_make_object( this, package ), TRUE );
    }

    DEC_V_CBACK_BOOL__WXSTRING( CanOpen );
    DEC_V_CBACK_WXSTRING__WXSTRING_INT( FindFirst );
    DEC_V_CBACK_WXSTRING__VOID( FindNext );
    DEC_V_CBACK_WXFSFILEP__WXFILESYSTEM_WXSTRING( OpenFile );
};

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPlFileSystemHandler, wxFileSystemHandler );

DEF_V_CBACK_WXSTRING__VOID_pure( wxPlFileSystemHandler, wxFileSystemHandler,
                                 FindNext );

bool wxPlFileSystemHandler::CanOpen( const wxString& file )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "CanOpen" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR,
                                                     "P", &file );
        bool val = SvTRUE( ret );
        SvREFCNT_dec( ret );
        return val;
    }
    return false;
}

wxString wxPlFileSystemHandler::FindFirst( const wxString& file, int flags )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "FindFirst" ) )
    {
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR,
                                                     "Pi", &file, flags );
        wxString val;
        WXSTRING_INPUT( val, wxString, ret );
        SvREFCNT_dec( ret );
        return val;
    }
    return wxEmptyString;
}

#include     <wx/wfstream.h>

wxFSFile* wxPlFileSystemHandler::OpenFile( wxFileSystem& parent,
                                           const wxString& name )
{
    if( wxPliVirtualCallback_FindCallback( &m_callback, "OpenFile" ) )
    {
        SV* fs = wxPli_object_2_sv( sv_newmortal(), &parent );
        SV* ret = wxPliVirtualCallback_CallCallback( &m_callback, G_SCALAR,
                                                     "sP", fs, &name );
        wxFSFile* val = (wxFSFile*)wxPli_sv_2_object( ret, "Wx::FSFile" );
        sv_setiv( SvRV( fs ), 0 );
        if( SvROK( ret ) )
            sv_setiv( SvRV( ret ), 0 );
        SvREFCNT_dec( ret );

        return val;
    }
    return 0;
}

#endif

// local variables:
// mode: c++
// end:
