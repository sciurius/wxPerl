/////////////////////////////////////////////////////////////////////////////
// Name:        v_cback.h
// Purpose:     callback helper class for virtual functions
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_V_CBACK_H
#define _WXPERL_V_CBACK_H

class WXPLDLL _wxVirtualCallback:public _wxSelfRef
{
public:
    //  _wxVirtualCallback() {}; // dummy
    _wxVirtualCallback( const char* package );
    //  _wxVirtualCallback( SV* self, const char* package );
    //  ~_wxVirtualCallback();

    bool FindCallback( const char* name );
    SV* CallCallback( I32 flags = G_SCALAR, const char* argtypes=0, ... );
public:
    const char* m_package;
    HV* m_stash;
    SV* m_method;
};

inline _wxVirtualCallback::_wxVirtualCallback( const char* package ) {
    m_package = package;
    m_self = 0;
    m_stash = 0;
}

#endif // _WXPERL_V_CBACK_H

// Local variables: //
// mode: c++ //
// End: //
