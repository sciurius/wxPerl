/////////////////////////////////////////////////////////////////////////////
// Name:        cpp/tipprovider.h
// Purpose:     C++ wrapper for wxTipProvider
// Author:      Mattia Barbon
// Modified by:
// Created:     07/09/2001
// RCS-ID:      $Id$
// Copyright:   (c) 2001-2002, 2007 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#include <wx/tipdlg.h>

class wxPliTipProvider:public wxTipProvider
{
    WXPLI_DECLARE_V_CBACK();
public:
    wxPliTipProvider( const char* package, size_t currentTip )
        :wxTipProvider( currentTip ),
         m_callback( "Wx::TipProvider" )
    {
        dTHX;
        m_callback.SetSelf( wxPli_non_object_2_sv( aTHX_ sv_newmortal(), this,
                                                   package ) );
    }

    void SetCurrentTip( size_t currentTip ) { m_currentTip = currentTip; }

    DEC_V_CBACK_WXSTRING__VOID( GetTip );
    DEC_V_CBACK_WXSTRING__WXSTRING( PreprocessTip );
};

DEF_V_CBACK_WXSTRING__VOID_pure( wxPliTipProvider, wxTipProvider, GetTip );
#if WXPERL_W_VERSION_LT( 3, 2, 0 )
DEF_V_CBACK_WXSTRING__WXSTRING( wxPliTipProvider, wxTipProvider, PreprocessTip );
#endif

// Local variables: //
// mode: c++ //
// End: //
