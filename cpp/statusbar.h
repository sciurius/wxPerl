/////////////////////////////////////////////////////////////////////////////
// Name:        statusbar.h
// Purpose:     c++ wrapper for wxStatusBar
// Author:      Mattia Barbon
// Modified by:
// Created:      2/ 9/2002
// RCS-ID:      
// Copyright:   (c) 2002 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#define WXPLI_CONSTRUCTOR_4( name, packagename, incref, argt1, argt2, argt3, argt4 ) \
     name( const char* package, argt1 _arg1, argt2 _arg2, argt3 _arg3,     \
           argt4 _arg4 )                                                   \
         :m_callback( packagename )                                        \
     {                                                                     \
         m_callback.SetSelf( wxPli_make_object( this, package ), incref ); \
         Create( _arg1, _arg2, _arg3, _arg4 );                             \
     }

#define WXPLI_DECLARE_CLASS_4( name, incref, argt1, argt2, argt3, argt4 ) \
class wxPli##name:public wx##name                                       \
{                                                                       \
    WXPLI_DECLARE_DYNAMIC_CLASS( wxPli##name );                         \
    WXPLI_DECLARE_SELFREF();                                            \
public:                                                                 \
    WXPLI_DEFAULT_CONSTRUCTOR( wxPli##name, wxPl##name##Name, incref ); \
    WXPLI_CONSTRUCTOR_4( wxPli##name, wxPl##name##Name, incref,         \
                         argt1, argt2, argt3, argt4 );    \
};

WXPLI_DECLARE_CLASS_4( StatusBar, TRUE,
                       wxWindow*, wxWindowID, long, const wxString& );

WXPLI_IMPLEMENT_DYNAMIC_CLASS( wxPliStatusBar, wxStatusBar );

// Local variables: //
// mode: c++ //
// End: //
