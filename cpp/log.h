/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/log.h
// Purpose:     c++ wrapper for wxLog and wxLogPassThrough
// Author:      Mattia Barbon
// Modified by:
// Created:     22/09/2002
// RCS-ID:      $Id$
// Copyright:   (c) 2002-2004 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/log.h>

class wxPlLog : public wxLog
{
//    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlLog );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR_NC( wxPlLog, "Wx::PlLog", true );
#if WXPERL_W_VERSION_LT( 2, 9, 0 ) || WXWIN_COMPATIBILITY_2_8
    DEC_V_CBACK_VOID__CWXCHARP_TIMET( DoLogString );
    DEC_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( DoLog );
#endif
    DEC_V_CBACK_VOID__VOID( Flush );
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    DEC_V_CBACK_VOID__WXLOGLEVEL_WXSTRING_WXLOGRECORDINFO( DoLogRecord );
    DEC_V_CBACK_VOID__WXLOGLEVEL_WXSTRING( DoLogTextAtLevel );
    DEC_V_CBACK_VOID__WXSTRING( DoLogText );
#endif
};
#if WXPERL_W_VERSION_LT( 2, 9, 0 ) || WXWIN_COMPATIBILITY_2_8
DEF_V_CBACK_VOID__CWXCHARP_TIMET( wxPlLog, wxLog, DoLogString );
DEF_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( wxPlLog, wxLog, DoLog );
#endif

DEF_V_CBACK_VOID__VOID( wxPlLog, wxLog, Flush );

#if WXPERL_W_VERSION_GE( 2, 9, 0 )
DEF_V_CBACK_VOID__WXLOGLEVEL_WXSTRING_WXLOGRECORDINFO( wxPlLog, wxLog, DoLogRecord );
DEF_V_CBACK_VOID__WXLOGLEVEL_WXSTRING( wxPlLog, wxLog, DoLogTextAtLevel );
DEF_V_CBACK_VOID__WXSTRING( wxPlLog, wxLog, DoLogText );
#endif

class wxPlLogPassThrough : public wxLogPassThrough
{
//    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlLogPassThrough );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR_NC( wxPlLogPassThrough,
                                  "Wx::PlLogPassThrough", true );
#if WXPERL_W_VERSION_LT( 2, 9, 0 ) || WXWIN_COMPATIBILITY_2_8
    DEC_V_CBACK_VOID__CWXCHARP_TIMET( DoLogString );
    DEC_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( DoLog );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
    DEC_V_CBACK_VOID__WXLOGLEVEL_WXSTRING_WXLOGRECORDINFO( DoLogRecord );
    DEC_V_CBACK_VOID__WXLOGLEVEL_WXSTRING( DoLogTextAtLevel );
    DEC_V_CBACK_VOID__WXSTRING( DoLogText );
#endif
};

#if WXPERL_W_VERSION_LT( 2, 9, 0 ) || WXWIN_COMPATIBILITY_2_8
DEF_V_CBACK_VOID__CWXCHARP_TIMET( wxPlLogPassThrough, wxLogPassThrough,
                                  DoLogString );
DEF_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( wxPlLogPassThrough,
                                             wxLogPassThrough, DoLog );
#endif
#if WXPERL_W_VERSION_GE( 2, 9, 0 )
DEF_V_CBACK_VOID__WXLOGLEVEL_WXSTRING_WXLOGRECORDINFO( wxPlLogPassThrough, wxLogPassThrough, DoLogRecord );
DEF_V_CBACK_VOID__WXLOGLEVEL_WXSTRING( wxPlLogPassThrough, wxLogPassThrough, DoLogTextAtLevel );
DEF_V_CBACK_VOID__WXSTRING( wxPlLogPassThrough, wxLogPassThrough, DoLogText );
#endif

#if WXPERL_W_VERSION_GE( 2, 9, 0 )
class wxPlLogFormatter : public wxLogFormatter
{
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR_NC( wxPlLogFormatter,
                                  "Wx::PlLogFormatter", true );
    
    wxString Format(wxLogLevel level,
                            const wxString& msg,
                            const wxLogRecordInfo& info) const;
protected:
    
    wxString FormatTime(time_t t) const;
};

wxString
wxPlLogFormatter::Format(wxLogLevel level,
                            const wxString& msg,
                            const wxLogRecordInfo& info) const
{
    dTHX;
    if( wxPliFCback( aTHX_ &m_callback, "Format" ) ) 
    {                                                               
        wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                              "IPq", level, &msg, &info, "Wx::LogRecordInfo" ) );
        wxString val;
        WXSTRING_INPUT( val, wxString, ret );
        return val;
    }
    else
        return wxLogFormatter::Format( level, msg, info );

}

wxString
wxPlLogFormatter::FormatTime(time_t t) const
{
    dTHX;
    if( wxPliFCback( aTHX_ &m_callback, "FormatTime" ) ) 
    {                                                               
        wxAutoSV ret( aTHX_ wxPliCCback( aTHX_ &m_callback, G_SCALAR,
                              "i", t) );
        wxString val;
        WXSTRING_INPUT( val, wxString, ret );
        return val;
    }
    else
        return wxLogFormatter::FormatTime( t );

}

#endif

// local variables:
// mode: c++
// end:
