/////////////////////////////////////////////////////////////////////////////
// Name:        ext/test/cpp/src/perltest.cpp
// Purpose:     test classes for wxPerl
// Author:      Mark Dootson
// Modified by:
// Created:     2012-09-28
// RCS-ID:      $Id$
// Copyright:   (c) 2012 Mark Dootson
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

// For compilers that support precompilation, includes "wx.h".
#include "wx/wxprec.h"

#include "cpp/include/perltest.h"

// ----------------------------------------------------------------------------


wxPerlTestAbstractNonObject::wxPerlTestAbstractNonObject( const wxString& moniker )
{
    m_moniker = moniker;
}

wxPerlTestAbstractNonObject::~wxPerlTestAbstractNonObject()
{
}

wxPerlTestNonObject::wxPerlTestNonObject( const wxString& moniker )
    : wxPerlTestAbstractNonObject( moniker )
{
}

wxPerlTestNonObject::~wxPerlTestNonObject()
{
}

wxPerlTestAbstractObject::wxPerlTestAbstractObject( const wxString& moniker )
    : wxObject()
{
    m_moniker = moniker;
}

wxPerlTestAbstractObject::~wxPerlTestAbstractObject()
{
}

wxPerlTestObject::wxPerlTestObject( const wxString& moniker )
    : wxPerlTestAbstractObject( moniker )
{
}

wxPerlTestObject::~wxPerlTestObject()
{
}



wxString
wxPerlTestNonObject::DoGetMessage() const
{
    return wxT("A message from the C++ class wxPerlTestNonObject");
}

IMPLEMENT_ABSTRACT_CLASS(wxPerlTestAbstractObject, wxObject)

IMPLEMENT_DYNAMIC_CLASS(wxPerlTestObject, wxPerlTestAbstractObject)

wxString
wxPerlTestObject::DoGetMessage() const
{
    return wxT("A message from the C++ class wxPerlTestObject");
}
