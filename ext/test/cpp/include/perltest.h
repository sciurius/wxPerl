/////////////////////////////////////////////////////////////////////////////
// Name:        ext/test/cpp/include/perltest.h
// Purpose:     test classes for wxPerl
// Author:      Mark Dootson
// Modified by:
// Created:     2012-09-28
// RCS-ID:      $Id$
// Copyright:   (c) 2012 Mark Dootson
// Licence:     This program is free software; you can redistribute it and/or
//              modify it under the same terms as Perl itself
/////////////////////////////////////////////////////////////////////////////

#ifndef _WXPERL_PERLTEST_CLASSES_H
#define _WXPERL_PERLTEST_CLASSES_H


class wxPerlTestAbstractNonObject
{

public:
    wxPerlTestAbstractNonObject( const wxString& moniker = wxT("AbstractNonObject") );
    
    virtual ~wxPerlTestAbstractNonObject();
    
    wxString GetMoniker() const { return m_moniker; }
    
    wxString GetMessage() const { return DoGetMessage(); }
    
    virtual wxString DoGetMessage() const = 0;
    
    virtual wxString EchoClassName() { return wxT("wxPerlTestAbstractNonObject"); }
    
    virtual wxString OnlyInBase() { return wxT("wxPerlTestAbstractNonObject"); }
   
private:
    wxString m_moniker;
    DECLARE_NO_COPY_CLASS(wxPerlTestAbstractNonObject);
};


class wxPerlTestNonObject: public wxPerlTestAbstractNonObject
{
    
public:
    wxPerlTestNonObject( const wxString& moniker = wxT("NonObject") );
    
    virtual ~wxPerlTestNonObject();
    
    virtual wxString DoGetMessage() const;
    
    virtual wxString EchoClassName() { return wxT("wxPerlTestNonObject"); }
    
private:
    DECLARE_NO_COPY_CLASS(wxPerlTestNonObject);
};



class wxPerlTestAbstractObject: public wxObject
{
    
public:
    wxPerlTestAbstractObject( const wxString& moniker = wxT("AbstractObject") );
        
    virtual ~wxPerlTestAbstractObject();
    
    wxString GetMoniker() const { return m_moniker; }
    
    wxString GetMessage() const { return DoGetMessage(); }
    
    virtual wxString DoGetMessage() const = 0;
    
    virtual wxString EchoClassName() { return wxT("wxPerlTestAbstractObject"); }
    
    virtual wxString OnlyInBase() { return wxT("wxPerlTestAbstractObject"); }
   
private:
    wxString  m_moniker;
    DECLARE_ABSTRACT_CLASS(wxPerlTestAbstractObject)
    DECLARE_NO_COPY_CLASS(wxPerlTestAbstractObject);
};

class wxPerlTestObject: public wxPerlTestAbstractObject
{
    
public:
    wxPerlTestObject( const wxString& moniker = wxT("Object") );
    
    virtual ~wxPerlTestObject();
    
    virtual wxString DoGetMessage() const;
    
    virtual wxString EchoClassName() { return wxT("wxPerlTestObject"); }
    
private:
    DECLARE_DYNAMIC_CLASS(wxPerlTestObject)
    DECLARE_NO_COPY_CLASS(wxPerlTestObject);
};


#endif
