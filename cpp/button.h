/////////////////////////////////////////////////////////////////////////////
// Name:        button.h
// Purpose:     c++ wrapper for wxButton
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_BUTTON_H
#define _WXPERL_BUTTON_H

class _wxButton:public wxButton
{
    _DECLARE_DYNAMIC_CLASS( _wxButton );
    _DECLARE_SELFREF();
public:
    _wxButton( const char* package, wxWindow* parent, wxWindowID id, 
               const wxString& label,
               const wxPoint& pos, const wxSize& size, long style, 
               const wxValidator& validator, const wxString& name );
};

#endif // _WXPERL_BUTTON_H


// Local variables: //
// mode: c++ //
// End: //
