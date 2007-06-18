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

    DEC_V_CBACK_VOID__CWXCHARP_TIMET( DoLogString );
    DEC_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( DoLog );
};

DEF_V_CBACK_VOID__CWXCHARP_TIMET( wxPlLog, wxLog, DoLogString );
DEF_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( wxPlLog, wxLog, DoLog );

class wxPlLogPassThrough : public wxLogPassThrough
{
//    WXPLI_DECLARE_DYNAMIC_CLASS( wxPlLogPassThrough );
    WXPLI_DECLARE_V_CBACK();
public:
    WXPLI_DEFAULT_CONSTRUCTOR_NC( wxPlLogPassThrough,
                                  "Wx::PlLogPassThrough", true );

    DEC_V_CBACK_VOID__CWXCHARP_TIMET( DoLogString );
    DEC_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( DoLog );
};

DEF_V_CBACK_VOID__CWXCHARP_TIMET( wxPlLogPassThrough, wxLogPassThrough,
                                  DoLogString );
DEF_V_CBACK_VOID__WXLOGLEVEL_CWXCHARP_TIMET( wxPlLogPassThrough,
                                             wxLogPassThrough, DoLog );

// local variables:
// mode: c++
// end:
