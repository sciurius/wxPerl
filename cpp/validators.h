/////////////////////////////////////////////////////////////////////////////
// Name:        validators.h
// Purpose:     c++ wrapper for wxValidator, and wxPlValidator
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_VALIDATORS_H
#define _WXPERL_VALIDATORS_H

class _wxPlValidator:public wxValidator
{
    _DECLARE_DYNAMIC_CLASS( _wxPlValidator );
    _DECLARE_V_CBACK();
public:
    _wxPlValidator( const char* package );

    virtual wxObject* Clone() const;
    virtual bool Validate( wxWindow* );
    DEC_V_CBACK_BOOL__VOID( TransferToWindow );
    DEC_V_CBACK_BOOL__VOID( TransferFromWindow );
};

#endif // _WXPERL_VALIDATORS_H

// Local variables: //
// mode: c++ //
// End: //
