/////////////////////////////////////////////////////////////////////////////
// Name:        controls.h
// Purpose:     c++ wrappers for wxControl-derived classes
// Author:      Mattia Barbon
// Modified by:
// Created:     29/10/2000
// RCS-ID:      
// Copyright:   (c) 2000 Mattia Barbon
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_CONTROLS_H
#define _WXPERL_CONTROLS_H

class _wxBitmapButton:public wxBitmapButton
{
    _DECLARE_DYNAMIC_CLASS( _wxBitmapButton );
    _DECLARE_SELFREF();
public:
    _wxBitmapButton( const char* package, wxWindow* parnt, wxWindowID id,
                     const wxBitmap& bitmap, const wxPoint& pos,
                     const wxSize& size, long style,
                     const wxValidator&, const wxString name );
};

class _wxCheckBox:public wxCheckBox
{
    _DECLARE_DYNAMIC_CLASS( _wxCheckBox );
    _DECLARE_SELFREF();
public:
    _wxCheckBox( const char* package, wxWindow* parent, wxWindowID id, 
                 const wxString& label, 
                 const wxPoint& pos, const wxSize& size, long style, 
                 const wxValidator& validator, const wxString& name );
};

class _wxCheckListBox:public wxCheckListBox
{
    _DECLARE_DYNAMIC_CLASS( _wxCheckListBox );
    _DECLARE_SELFREF();
public:
    _wxCheckListBox( const char* package, wxWindow* parent, wxWindowID id,
                     const wxPoint& pos, const wxSize& size, int n,
                     const wxString choices[], long style, 
                     const wxValidator& validator, const wxString& name );
};

class _wxChoice:public wxChoice
{
    _DECLARE_DYNAMIC_CLASS( _wxChoice );
    _DECLARE_SELFREF();
public:
    _wxChoice( const char* package, wxWindow* parent, wxWindowID id, 
               const wxPoint& pos, const wxSize& size, int n,
               const wxString choices[], long style, 
               const wxValidator& validator,
               const wxString& name );
};

class _wxComboBox:public wxComboBox
{
    _DECLARE_DYNAMIC_CLASS( _wxComboBox );
    _DECLARE_SELFREF();
public:
    _wxComboBox( const char* package, wxWindow* parent, wxWindowID id,
                 const wxString& value, const wxPoint& pos,
                 const wxSize& size, int n, const wxString chices[],
                 long style, const wxValidator& validator, 
                 const wxString& name );
};

class _wxGauge:public wxGauge
{
    _DECLARE_DYNAMIC_CLASS( _wxGauge );
    _DECLARE_SELFREF();
public:
    _wxGauge( const char* package, wxWindow* parent, wxWindowID id,
              int range, const wxPoint& pos, const wxSize& size,
              long style, const wxValidator& validator, const wxString &name );
};

class _wxListBox:public wxListBox
{
    _DECLARE_DYNAMIC_CLASS( _wxListBox );
    _DECLARE_SELFREF();
public:
    _wxListBox( const char* package, wxWindow* parent, wxWindowID id, 
                const wxPoint& pos, const wxSize& size, int n,
                const wxString choices[], long style, 
                const wxValidator& validator, const wxString& name );
};

class _wxListCtrl:public wxListCtrl
{
    _DECLARE_DYNAMIC_CLASS( _wxListCtrl );
    _DECLARE_SELFREF();
public:
    _wxListCtrl( const char* package, wxWindow* parent, wxWindowID id,
                 const wxPoint& pos, const wxSize& size, long style,
                 const wxValidator& validator, const wxString& name );
};

class _wxRadioBox:public wxRadioBox
{
    _DECLARE_DYNAMIC_CLASS( _wxRadioBox );
    _DECLARE_SELFREF();
public:
    _wxRadioBox( const char* package, wxWindow* parent, wxWindowID id,
                 const wxString& label, const wxPoint& point,
                 const wxSize& size, int n, const wxString choices[],
                 int majorDimension, long style, 
                 const wxValidator& validator, const wxString& name );
};

class _wxRadioButton:public wxRadioButton
{
    _DECLARE_DYNAMIC_CLASS( _wxRadioButton );
    _DECLARE_SELFREF();
public:
    _wxRadioButton( const char* package, wxWindow* parent, wxWindowID ID,
                    const wxString label, const wxPoint& pos,
                    const wxSize& size, long style,
                    const wxValidator& validator, const wxString& name );
};

class _wxScrollBar:public wxScrollBar
{
    _DECLARE_DYNAMIC_CLASS( _wxScrollBar );
    _DECLARE_SELFREF();
public:
    _wxScrollBar( const char* package, wxWindow* parent, wxWindowID id,
                  const wxPoint& pos, const wxSize& size, long style,
                  const wxValidator& validator, const wxString& name );
};

class _wxSpinButton:public wxSpinButton
{
    _DECLARE_DYNAMIC_CLASS( _wxSpinButton );
    _DECLARE_SELFREF();
public:
    _wxSpinButton( const char* package, wxWindow* parent, wxWindowID id,
                   const wxPoint& pos, const wxSize& size,
                   long style, const wxString& name );
};

class _wxSpinCtrl:public wxSpinCtrl
{
    _DECLARE_DYNAMIC_CLASS( _wxSpinCtrl );
    _DECLARE_SELFREF();
public:
    _wxSpinCtrl( const char* package, wxWindow* parent, wxWindowID id,
                 const wxString& value, const wxPoint& pos,
                 const wxSize& size, long style, int min, int max,
                 int initial, const wxString& name );
};

class _wxSlider:public wxSlider
{
    _DECLARE_DYNAMIC_CLASS( _wxSlider );
    _DECLARE_SELFREF();
public:
    _wxSlider( const char* package, wxWindow* parent, wxWindowID id,
               int value, int minValue, int maxValue,
               const wxPoint& pos, const wxSize& size,
               long style,
               const wxValidator& validator, const wxString& name );
};

class _wxStaticBitmap:public wxStaticBitmap
{
    _DECLARE_DYNAMIC_CLASS( _wxStaticBitmap );
    _DECLARE_SELFREF();
public:
    _wxStaticBitmap( const char* package,
                     wxWindow* parent, wxWindowID id, const wxBitmap& bitmap,
                     const wxPoint& pos, const wxSize& size, long style,
                     const wxString& name );
    _wxStaticBitmap( const char* package,
                     wxWindow* parent, wxWindowID id, const wxIcon& icon,
                     const wxPoint& pos, const wxSize& size, long style,
                     const wxString& name );
};

class _wxStaticBox:public wxStaticBox
{
    _DECLARE_DYNAMIC_CLASS( _wxStaticBox );
    _DECLARE_SELFREF();
public:
    _wxStaticBox( const char* package, wxWindow* parent, wxWindowID id,
                  const wxString& label, const wxPoint& pos,
                  const wxSize& size, long style, const wxString& name );
};

class _wxStaticLine:public wxStaticLine
{
    _DECLARE_DYNAMIC_CLASS( _wxStaticLine );
    _DECLARE_SELFREF();
public:
    _wxStaticLine( const char* package, wxWindow* parent, wxWindowID id,
                   const wxPoint& pos, const wxSize& size, long style, 
                   const wxString& name );
};

class _wxStaticText:public wxStaticText
{
    _DECLARE_DYNAMIC_CLASS( _wxStaticText );
    _DECLARE_SELFREF();
public:
    _wxStaticText( const char* package, wxWindow* parent, wxWindowID id, const wxString& label,
                   const wxPoint& pos, const wxSize& size, long style, const wxString& name );
};

class _wxTextCtrl:public wxTextCtrl
{
    _DECLARE_DYNAMIC_CLASS( _wxTextCtrl );
    _DECLARE_SELFREF();
public:
    _wxTextCtrl( const char* package, wxWindow* parent, wxWindowID id, 
                 const wxString& value, const wxPoint& pos, const wxSize& size,
                 long style, const wxValidator& validator, 
                 const wxString& name = wxTextCtrlNameStr );
};

class _wxTreeCtrl:public wxTreeCtrl
{
    _DECLARE_DYNAMIC_CLASS( _wxTreeCtrl );
    _DECLARE_V_CBACK();
public:
    _wxTreeCtrl( const char* package, wxWindow* parent, wxWindowID id,
                 const wxPoint& pos, const wxSize& size, long style,
                 const wxValidator& validator, const wxString& name );

    int OnCompareItems( const wxTreeItemId& item1,
                        const wxTreeItemId& item2 );
};

#endif // _WXPERL_CONTROLS_H

// Local variables: //
// mode: c++ //
// End: //
